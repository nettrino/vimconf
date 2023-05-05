local lsp = require("lsp-zero")
lsp.preset("recommended")

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.ensure_installed({
    "gopls",
    "pylsp",
})

---require("lspconfig").nim_langserver.setup({})

lsp.setup()
vim.opt.signcolumn = "yes"
vim.diagnostic.config({
    virtual_text = true,
})
