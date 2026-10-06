return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
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
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				sql = { "sqlfluff" },
				go = { "gofumpt", "golines" },
				proto = { "buf" },
			},
			formatters = {
				golines = { prepend_args = { "--max-len=80" } },
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 3000,
			},
		})

		-- vim.keymap.set({ "n", "v" }, "<leader>mp", function()
		-- 	conform.format({
		-- 		lsp_format = "fallback",
		-- 		async = false,
		-- 		timeout_ms = 1000,
		-- 	})
		-- end, { desc = "Format file or range (in visual mode)" })
	end,
}
