return {
	"nvimdev/guard.nvim",
	-- Builtin configuration, optional
	dependencies = {
		"nvimdev/guard-collection",
	},
	event = "BufReadPre",
	config = function()
		local ft = require("guard.filetype")
		ft("c,cpp"):fmt("clang-format")

		vim.g.guard_config = {
			-- the only options for the setup function
			fmt_on_save = true,
			-- Use lsp if no formatter was defined for this filetype
			lsp_as_default_formatter = false,
		}
	end,
}
