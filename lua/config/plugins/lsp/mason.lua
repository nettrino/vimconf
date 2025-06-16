return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "html",
                "cssls",
                "tailwindcss",
                "lua_ls",
                "emmet_ls",
                "gopls",
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
            automatic_enable = true,
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "isort", -- python formatter
                "black", -- python formatter
                "autoflake", -- python formatter
                "flake8", -- python linter
                "pylint", -- python linter
                "eslint_d", -- js linter
                "golangci-lint", -- golang linter
                "golines", -- golang formatter
            },
        })
    end,
}
