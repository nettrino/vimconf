local lsp = require("lsp-zero").preset({})
-- lsp.preset("recommended")

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.ensure_installed({
    "gopls",
    "pylsp",
    "lua_ls",
    "clangd",
    "tsserver",
})

local cmp = require("cmp")
local cmp_action = lsp.cmp_action()
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/autocomplete.md
cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip", keyword_length = 2 },
    },
    mapping = {
        -- nter will only confirm the selected item. You need to select the item before pressing enter.
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Up>"] = cmp.mapping.select_prev_item(cmp_select_opts),
        ["<Down>"] = cmp.mapping.select_next_item(cmp_select_opts),
        ["<Tab>"] = cmp_action.luasnip_supertab(),
        ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        documentation = {
            max_height = 15,
            max_width = 60,
        },
    },
    formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(entry, item)
            local short_name = {
                nvim_lsp = "LSP",
                nvim_lua = "nvim",
            }

            local menu_name = short_name[entry.source.name] or entry.source.name

            item.menu = string.format("[%s]", menu_name)
            return item
        end,
    },
})

lsp.configure("pylsp", {
    settings = {
        pylsp = {
            configurationSources = { "flake8", "mypy" },
            plugins = {
                pycodestyle = { enabled = false },
                flake8 = { enabled = false },
            },
        },
    },
})

lsp.setup()

vim.opt.signcolumn = "yes"
vim.diagnostic.config({
    virtual_text = true,
})

-- Show enabled formatters via :ListFormatters
vim.api.nvim_create_user_command("ListFormatters", function()
    local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })

    local formatters = vim.tbl_filter(function(c)
        return c.supports_method("textDocument/formatting")
    end, clients)

    formatters = vim.tbl_map(function(c)
        return c.name
    end, formatters)

    if #formatters > 0 then
        print(vim.inspect(formatters))
    else
        print("No formatters active in current buffer")
    end
end, {})
