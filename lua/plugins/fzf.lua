local opts = {
    noremap = true,
    silent = true,
}

vim.api.nvim_set_keymap("n", "<leader>ff", ":FzfLua builtin<CR>", opts)

vim.api.nvim_set_keymap("n", "<c-P>", ":FzfLua git_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<c-B>", ":FzfLua buffers<CR>", opts)
vim.api.nvim_set_keymap("n", "<c-t>", ":FzfLua btags<CR>", opts)
vim.api.nvim_set_keymap("n", "<a-t>", ":FzfLua tags<CR>", opts)

vim.api.nvim_set_keymap("n", "z=", ":FzfLua spell_suggest<CR>", opts)

vim.api.nvim_set_keymap("n", "gr", ":FzfLua lsp_references<CR>", opts)

return function(use)
    use({
        "ibhagwan/fzf-lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        cmd = {
            "FzfLua",
        },
        config = function()
            require("fzf-lua").setup({
                lsp = {
                    -- make lsp requests synchronous so they work with null-ls
                    async_or_timeout = 3000,
                },
            })
        end,
    })
end
