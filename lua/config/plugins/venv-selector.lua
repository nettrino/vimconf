return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	ft = "python",
	-- without fd, setup errors inside the python FileType autocmd and aborts the
	-- rest of it (treesitter never starts), so skip the plugin until fd exists
	cond = function()
		for _, bin in ipairs({ "fd", "fdfind", "fd_find" }) do
			if vim.fn.executable(bin) == 1 then
				return true
			end
		end
		return false
	end,
	opts = {},
	keys = {
		{ ",v", "<cmd>VenvSelect<cr>" },
	},
}
