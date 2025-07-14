return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                lua = { "stylua" },
                python = { "isort", "black", "autoflake" },
                go = { "gofumpt", "golines" },
            },
            formatters = {
                autoflake = {
                    args = { "--remove-all-unused-imports", "--stdin-display-name", "$FILENAME", "-" },
                },
                golines = { prepend_args = { "--max-len=80" } },
            },
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 3000,
            },
        })

        -- vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        -- 	conform.format({
        -- 		lsp_fallback = true,
        -- 		async = false,
        -- 		timeout_ms = 1000,
        -- 	})
        -- end, { desc = "Format file or range (in visual mode)" })
    end,
}
