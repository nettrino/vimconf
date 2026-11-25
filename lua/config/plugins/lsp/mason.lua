-- mason builds these with `go install`; without a Go toolchain every startup
-- reports "failed to install", so only ask for them once go is on $PATH
local function with_go(list, go_pkgs)
	if vim.fn.executable("go") == 1 then
		vim.list_extend(list, go_pkgs)
	end
	return list
end

return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		"neovim/nvim-lspconfig",
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				-- binaries referenced by conform.nvim / nvim-lint
				ensure_installed = with_go({
					"prettier",
					"stylua",
					"eslint_d",
					"golangci-lint",
					"ruff",
					"clang-format",
					"sqlfluff",
				}, { "golines", "gofumpt" }),
			},
		},
	},
	-- v2 dropped automatic_installation, so every server that used to be
	-- auto-installed by nvim-lsp-installer is listed here explicitly:
	-- https://github.com/mason-org/mason-lspconfig.nvim/discussions/538
	opts = {
		-- installed as CLI tools for conform/nvim-lint, not as language servers;
		-- enabling them too duplicates every ruff diagnostic
		automatic_enable = {
			exclude = { "ruff", "stylua" },
		},
		ensure_installed = with_go({
			"html",
			"cssls",
			"tailwindcss",
			"lua_ls",
			"emmet_ls",
			"ts_ls",
			"svelte",
			"prismals",
			"pyright",
			"pylsp",
		}, { "gopls" }),
	},
}
