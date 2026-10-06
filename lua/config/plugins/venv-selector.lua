return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python",
		"nvim-telescope/telescope.nvim",
	},
	lazy = false,
	-- regexp branch was merged into main on 2025-08-27 and now only errors out
	-- https://github.com/linux-cultist/venv-selector.nvim#-changelog
	opts = {},
	keys = {
		{ ",v", "<cmd>VenvSelect<cr>" },
	},
}
