return {
	"nvimdev/guard.nvim",
	event = "BufReadPre",
	config = function()
		local ft = require("guard.filetype")

		ft("c,cpp,json"):fmt("clang-format")

		require("guard").setup({
			-- the only options for the setup function
			fmt_on_save = true,
			-- Use lsp if no formatter was defined for this filetype
			lsp_as_default_formatter = false,
		})
	end,
}
