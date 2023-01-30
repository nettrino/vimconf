local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local utils = require("null-ls.utils")
null_ls.setup({
    debug = true,
    sources = {
        -- formatters
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort.with({
            extra_args = { "--profile", "black", "--filter-files" },
        }),
        null_ls.builtins.formatting.golines,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "spaces" },
        }),
        null_ls.builtins.formatting.terraform_fmt.with({
            filetypes = { "hcl", "terraform" },
        }),
        -- linters
        null_ls.builtins.diagnostics.flake8.with({
            filetypes = { "python" },
            -- black handles lines and breaks
            extra_args = { "--ignore", "E501,W503,D100,D101,D102,D103,D104,D105,D106,D107" },
        }),
        -- FIXME check ruff
        null_ls.builtins.diagnostics.mypy.with({
            runtime_condition = function(params)
                return utils.path.exists(params.bufname)
            end,
        }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
