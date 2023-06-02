local lsp = require("lsp-zero")
lsp.preset("recommended")

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.ensure_installed({
    -- most auto-install lsps will create issues in systems where the language
    -- is not installed by default. Just add python and js things
    -- manually via Mason for everything else
    "pylsp",
    "lua_ls",
    "tsserver",
    "eslint",
})

local cmp_action = lsp.cmp_action()
local cmp = require("cmp")
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    mapping = {
        -- nter will only confirm the selected item. You need to select the item before pressing enter.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Up>"] = cmp.mapping.select_prev_item(cmp_select_opts),
        ["<Down>"] = cmp.mapping.select_next_item(cmp_select_opts),
        ["<Tab>"] = cmp_action.luasnip_supertab(),
        ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
    },
})

lsp.configure("pylsp", {
    settings = {
        pylsp = {
            configurationSources = { "flake8", "mypy" },
            plugins = {
                -- we have black for these
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
