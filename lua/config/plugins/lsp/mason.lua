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
				ensure_installed = {
					"prettier",
					"stylua",
					"eslint_d",
					"golangci-lint",
					"golines",
					"gofumpt",
					"ruff",
					"clang-format",
					"sqlfluff",
				},
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
		ensure_installed = {
			"html",
			"cssls",
			"tailwindcss",
			"lua_ls",
			"emmet_ls",
			"gopls",
			"ts_ls",
			"svelte",
			"prismals",
			"pyright",
			"pylsp",
		},
	},
}
