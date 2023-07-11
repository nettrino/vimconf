local null_ls = require("null-ls")
local utils = require("null-ls.utils")

-- list here what should be installed
require("mason-null-ls").setup({
    ensure_installed = {
        -- tf
        "terraform_fmt",
        -- lua
        "stylua",
        -- python
        "black",
        "mypy",
        "isort",
        "flake8",
        -- js ts,
        "prettier",
        -- golang
        "golines",
        "gofmt",
        "golangci-lint",
    },
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local async_formatting = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        vim.lsp.util.make_formatting_params({}),
        function(err, res, ctx)
            if err then
                local err_msg = type(err) == "string" and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
                return
            end

            if res then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd("silent noautocmd update")
                end)
            end
        end
    )
end

null_ls.setup({
    debug = false,
    sources = {
        --
        --
        --
        -- formatters
        --
        --
        --
        null_ls.builtins.formatting.trim_whitespace,

        --
        -- python
        --
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort.with({
            extra_args = { "--profile", "black", "--filter-files" },
        }),

        --
        -- golang
        --
        null_ls.builtins.formatting.golines.with({
            extra_args = { "--max-len=80" },
        }),
        null_ls.builtins.formatting.gofmt,

        --
        -- lua
        --
        null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "spaces" },
        }),

        --
        -- terraform
        --
        null_ls.builtins.formatting.terraform_fmt.with({
            filetypes = { "hcl", "terraform" },
        }),

        --
        -- js/ts
        --
        null_ls.builtins.formatting.prettier,

        --
        -- prisma
        --
        null_ls.builtins.formatting.prismaFmt,

        --
        --
        --
        -- linters --> running `gl` on a line tells you where it came from
        --
        --
        --
        null_ls.builtins.diagnostics.flake8.with({
            extra_args = { "--ignore", "E501,W503,D100,D101,D102,D103,D104,D105,D106,D107" },
        }),

        null_ls.builtins.diagnostics.tsc,
        null_ls.builtins.diagnostics.mypy.with({
            runtime_condition = function(params)
                return utils.path.exists(params.bufname)
            end,
        }),
        null_ls.builtins.diagnostics.golangci_lint,
    },

    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    async_formatting(bufnr)
                end,
            })
        end
    end,
})
