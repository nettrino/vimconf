return {
	priority = 1000, -- make sure to load this before all the other start plugins
	"projekt0n/github-nvim-theme",
	config = function()
		require("github-theme").setup({
			options = {
				bg_search = "#00006b",
				hide_nc_statusline = false,
			},
			-- groups = {
			-- 	all = {
			-- ["@funcion"] = { fg = "palette.pink" },
			-- ["@identifier"] = { fg = "palette.yellow" },
			-- ["@field"] = { fg = "palette.red" },
			-- ["@boolean"] = { bg = "#00ff8b", fg = "#aaff8b", sp = "#1af231", style = "underline" },
			-- ["@type.definition"] = { fg = "palette.green" },
			-- ["@variable"] = { fg = "palette.red" },
			-- ["@constant.builtin"] = { fg = "palette.pink" },
			-- ["StatusLineNC"] = { bg = "#00ff8b", fg = "#aaff8b", sp = "#1af231", style = "underline" },
			-- 	},
			-- },
		})
		vim.cmd("colorscheme github_dark_dimmed")
	end,
}
