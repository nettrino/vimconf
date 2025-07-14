return {
    "stevearc/conform.nvim",
    opts = {},
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
        go = { "gofumpt", "golines" },
    },
    formatters = {
        ["goimports-reviser"] = { prepend_args = { "-rm-unused" } },
        golines = { prepend_args = { "--max-len=80" } },
    },
    config = function()
        require("conform").setup({
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })
    end,
}
