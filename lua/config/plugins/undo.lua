return {
	-- pure vimscript, unlike vim-mundo which needs the pynvim python provider
	"mbbill/undotree",
	keys = {
		{ "<S-u>", "<cmd>UndotreeToggle<cr>", desc = "Toggle undo tree" },
	},
}
