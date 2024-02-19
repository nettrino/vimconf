return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"b0o/incline.nvim",
	},
	config = function()
		require("incline").setup()
		require("lualine").setup({
			options = {
				theme = "github_dark_dimmed",
			},
		})
	end,
}
