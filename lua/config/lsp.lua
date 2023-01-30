local servers = {'gopls', 'pyright', 'jsonls', 'yamlls'}
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

local on_attach_common = function(client, bufnr)
	-- Mappings.
	local opts = { noremap = true, silent = true }
	local function nmap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	nmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	nmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	nmap("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	nmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- moved to fzf as it allows to easily open in new tab/split/etc
	-- nmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	nmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	nmap("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	nmap("n", "<leader>qf", ":CodeActionMenu<CR>", opts)
	nmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	nmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	nmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

	vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
	vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
	vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
	vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
	vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
	vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
	vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
	vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
	vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
	vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
	vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
	vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
	vim.cmd("command! LspStopServers lua vim.lsp.stop_client(vim.lsp.get_active_clients())")

	-- delay before float appears or autocomplete shows up
	vim.o.updatetime = 20
	vim.cmd("autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focusable=false})")

	if client.server_capabilities.document_highlight then
		vim.cmd([[
		augroup lsp_document_highlight
		autocmd! * <buffer>
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
		]])
	end
	-- format on save
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("Format", { clear = true }),
			buffer = bufnr,
			callback = function() vim.lsp.buf.formatting_seq_sync() end
		})
	end
end

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach_common,
        capabilities = capabilities
    }
end

local nvim_lsp = require("lspconfig")
local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
vim.lsp.buf.format({
    filter = function(client)
	-- if null-ls has formatter for this filetype,
	-- then only let null-ls format this buffer
	-- otherwise anything is valid
	local filetype = vim.bo.filetype
	for _, source in pairs(null_ls.get_sources()) do
	    if source.methods[null_ls.methods.FORMATTING] and source.filetypes[filetype] then
		return client.name == "null-ls"
	    end
	end
	return true
    end,
    bufnr = bufnr,
})
end

local lspkind = require("lspkind")
lspkind.init()

-- luasnip setup
local luasnip = require 'luasnip'


-- full list at 
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#formatting
local sources = {
	null_ls.builtins.diagnostics.eslint_d,
	null_ls.builtins.diagnostics.flake8,
	null_ls.builtins.diagnostics.mypy,
	null_ls.builtins.code_actions.eslint_d,
	null_ls.builtins.formatting.prettierd,
	null_ls.builtins.formatting.black,
	null_ls.builtins.formatting.fish_indent,
	null_ls.builtins.formatting.nimpretty,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.bibclean,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.golines.with({
        extra_args = {"--max-len=80"}
    }),
    null_ls.builtins.diagnostics.markdownlint,
	null_ls.builtins.formatting.shfmt.with({
		extra_args = {
			"-i",
			"4", -- 4 spaces
			"-ci", -- indent switch cases
			"-sr", -- redirect operators are followed by space
			"-bn", -- binary ops like && or | (pipe) start the line
		},
	}),
	null_ls.builtins.formatting.stylua.with({
		extra_args = { "--indent-type", "spaces" },
	}),
	null_ls.builtins.formatting.terraform_fmt.with({
		filetypes = { "hcl", "terraform" },
	}),
	helpers.make_builtin({
		name = "importanize",
		meta = {
			url = "https://github.com/miki725/importanize",
			description = "Organize imports",
		},
		method = null_ls.methods.FORMATTING,
		filetypes = { "python" },
		generator_opts = {
			command = "importanize",
			args = {},
			to_stdin = true,
		},
		factory = helpers.formatter_factory,
	}),
}

for _, v in pairs(sources) do
	local cmd = v._opts.command
	v.condition = function()
		return vim.fn.executable(cmd) > 0
	end
end

null_ls.setup({
	sources = sources,
	on_attach = function(client, bufnr)
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})

		vim.cmd("command! NullLsStop lua vim.lsp.stop_client(" .. client.id .. ")")

		on_attach_common(client, bufnr)
	end,
})


-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    formatting = {
                    format = lspkind.cmp_format({
                        with_text = true, -- do not show text alongside icons
                        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        menu = {
                            buffer = "(Buffer)",
                            calc = "(Calc)",
                            emoji = "(Emoji)",
                            gh_issues = "(Issues)",
                            luasnip = "(Snippet)",
                            nvim_lsp = "(LSP)",
                            path = "(Path)",
                            treesitter = "(TS)",
                            spell = "(Spell)",
                        },
                    }),
                },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    }),
    sources = {
	{
        	name = 'nvim_lsp',
		priority_weight = 100,
                max_item_count = 10,
    	}, 
	{
        	name = 'path',
		priority_weight = 90,
		max_item_count = 4,
    	}, 
	{
        	name = 'luasnip',
		priority_weight = 85,
    	}, 
	{
		name = 'buffer',
		priority_weight = 80,
		option = {
		    -- Avoid accidentally running on big files
		    get_bufnrs = function()
			local buf = vim.api.nvim_get_current_buf()
			local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
			if byte_size > 256 * 1024 then -- 256KB Megabyte max
			    return {}
			end
			return {buf}
		    end
        }
    }}
}

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
