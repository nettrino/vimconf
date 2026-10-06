return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- native config API, the require("lspconfig") framework is removed in
		-- nvim-lspconfig v3: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user_lsp_keymaps", { clear = true }),
			callback = function(ev)
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, noremap = true, silent = true, desc = desc })
				end

				map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
				map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
				map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
				map("n", "gb", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
				map("n", "gl", vim.diagnostic.open_float, "Show line diagnostics")
				map("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, "Go to previous diagnostic")
				map("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, "Go to next diagnostic")
				map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
				map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")
			end,
		})

		vim.lsp.config("svelte", {
			on_attach = function(client)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client:notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
					end,
				})
			end,
		})

		vim.lsp.config("emmet_ls", {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		vim.lsp.config("pylsp", {
			settings = {
				pylsp = {
					configurationSources = { "flake8", "mypy" },
					plugins = {
						-- ruff covers these
						pycodestyle = { enabled = false },
						flake8 = { enabled = false },
						ruff = {
							enabled = true,
							formatEnabled = true,
							preview = false,
						},
					},
				},
			},
		})

		vim.lsp.config("nim_langserver", {
			settings = {
				nim = {
					nimsuggestPath = "~/.nimble/bin/",
				},
			},
		})

		vim.lsp.config("buf_ls", {
			filetypes = { "proto" },
		})

		vim.lsp.config("clangd", {
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			cmd = {
				"clangd",
				"--completion-style=detailed",
				"--header-insertion=never",
			},
		})

		-- root_dir for files under GOMODCACHE is handled upstream, see
		-- https://github.com/neovim/nvim-lspconfig/issues/804
		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- mason-lspconfig enables whatever it installed; the rest are expected
		-- on $PATH (clangd from xcode, buf from brew, nimlangserver from nimble)
		vim.lsp.enable({
			"html",
			"ts_ls",
			"cssls",
			"tailwindcss",
			"svelte",
			"prismals",
			"emmet_ls",
			"pyright",
			"pylsp",
			"nim_langserver",
			"buf_ls",
			"clangd",
			"gopls",
			"lua_ls",
		})
	end,
}
