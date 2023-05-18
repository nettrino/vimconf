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

-- Make sure you setup `cmp` after lsp-zero
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/autocomplete.md
cmp.setup({
    mapping = {
        -- nter will only confirm the selected item. You need to select the item before pressing enter.
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp_action.luasnip_supertab(),
        ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
    },
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip", keyword_length = 2 },
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
