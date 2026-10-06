return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- main is the rewritten plugin: no nvim-treesitter.configs module, no
		-- lazy loading, highlighting/indent wired through core nvim APIs
		-- https://github.com/nvim-treesitter/nvim-treesitter/tree/main#setup
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup({})

			-- parsers are compiled with `tree-sitter build`, so without the CLI
			-- every install fails with a separate error
			if vim.fn.executable("tree-sitter") == 1 then
				ts.install({
					"bash",
					"c",
					"css",
					"dockerfile",
					"gitignore",
					"go",
					"graphql",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"prisma",
					"python",
					"query",
					"rust",
					"terraform",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				})
			else
				vim.notify_once("tree-sitter CLI not found, skipping parser install (see README)", vim.log.levels.WARN)
			end

			-- incremental selection is builtin since 0.12, see :h v_an
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
				callback = function(args)
					local buf = args.buf
					local lang = vim.treesitter.language.get_lang(args.match)
					if not lang or not vim.treesitter.language.add(lang) then
						return
					end
					if vim.fn.getfsize(vim.api.nvim_buf_get_name(buf)) > 500 * 1024 then
						return
					end
					vim.treesitter.start(buf, lang)
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
