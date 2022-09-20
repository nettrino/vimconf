vim.opt.backup = false -- creates a backup file
vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "80"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.cursorline = true -- highlight the current line
vim.opt.diffopt = "filler,iwhite" -- In diff mode, ignore whitespace,
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.opt.formatoptions = "cqtr"
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.history = 1000
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in `search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.number = true -- set numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.relativenumber = false -- set relative numbered lines
vim.opt.scrolloff = 3 -- Start scrolling 8 lines before win. border
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.showmatch = true -- we don't need to see things like -- INSERT -- anymore
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitbelow = true -- open new pages on the bottom when splitting
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.splitright = true -- open new pages on the right split when vsplitting
vim.opt.swapfile = false -- creates a swapfile
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
vim.opt.undodir = os.getenv("HOME") .. "/.config/lvim/undo"
vim.opt.undofile = true -- enable persistent undo
vim.opt.undolevels = 10000
vim.opt.updatetime = 300 -- faster completion
vim.opt.wrap = false -- display lines as one long line
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited


-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker" -- try onedarker for a non-black background
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","


-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
-- lvim.builtin.treesitter.ensure_installed = {
--   "bash",
--   "c",
--   "javascript",
--   "json",
--   "lua",
--   "python",
--   "typescript",
--   "tsx",
--   "css",
--   "rust",
--   "java",
--   "yaml",
-- }

lvim.builtin.treesitter.ignore_install = { "haskell", "phpdoc" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumeko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
local pyright_opts = {} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("pyright", pyright_opts)

local function codeql_on_attach_callback(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>lua show_diagnostics_details()<CR>", { silent = true; })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", { silent = true; })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true; })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gK", "<Cmd>lua vim.lsp.buf.hover()<CR>", { silent = true; })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true; })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", { silent = true; })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gF", "<Cmd>lua vim.lsp.buf.formatting()<CR>", { silent = true; })
  vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
  vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
  vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.util.buf_clear_references()]]
end

require("lvim.lsp.manager").setup("codeqlls", {
  on_attach = codeql_on_attach_callback;
  settings = {
    --
    search_path = {
      "~/projects/codeql-home",
      "~/projects/codeql-home/codeql-repo",
      "~/.codeql/packages",
    };
  };
})

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "80" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8",
    filetypes = { "python" },
    -- black handles lines
    extra_args = { "--ignore", "E501" },
  },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}

-- Additional Plugins
lvim.plugins = {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "mbbill/undotree",
    config = function()
      vim.cmd("let g:gundo_close_on_revert=1")
    end,
  },
  {
    "flazz/vim-colorschemes",
  },
  {
    'pixelneo/vim-python-docstring',
    config = function()
      vim.cmd("let g:python_style = 'numpy'")
    end,
  },
  {
    "rhysd/vim-clang-format",
    config = function()
      vim.cmd("let g:clang_format#detect_style_file = 1")
      vim.cmd("let g:clang_format#auto_format = 1")
      vim.cmd("autocmd FileType c ClangFormatAutoEnable")
    end,
  },
  {
    "pwntester/codeql.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
      {
        's1n7ax/nvim-window-picker',
        tag = 'v1.*',
        config = function()
          require 'window-picker'.setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              bo = {
                filetype = {
                  "codeql_panel",
                  "codeql_explorer",
                  "qf",
                  "TelescopePrompt",
                  "TelescopeResults",
                  "notify",
                  "NvimTree",
                  "neo-tree",
                },
                buftype = { 'terminal' },
              },
            },
            current_win_hl_color = '#e35e4f',
            other_win_hl_color = '#44cc41',
          })
        end,
      }
    },
    config = function()
      require("codeql").setup {
        results = {
          max_paths = 10,
          max_path_depth = nil,
        },
        panel = {
          group_by = "sink", -- "source"
          show_filename = true,
          long_filename = false,
          context_lines = 3,
        },
        max_ram = 32000,
        job_timeout = 60000,
        format_on_save = true,
        search_path = {
          "/Users/nettrino/projects/codeql-home",
          "/Users/nettrino/projects/codeql-home/codeql-repo",
          "./codeql"
        },
      }
    end
  }
}

-- Plugin Keymappings
lvim.keys.normal_mode["<S-u>"] = ":UndotreeToggle<cr>"

-- nvim-tree (check :help; nvim-tree-lua for mappings)
lvim.keys.normal_mode["<C-g>"] = ":NvimTreeToggle<cr>"




-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})

-- default useful keymappings

-- ctr + o go to definition
-- ctr + i come back from definition
-- shift + k: show information about a class

-- USER-keymappings

-- save
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- previous tab shift-z
lvim.keys.normal_mode["<S-z>"] = ":tabp<cr>"
-- next tab shift-x
lvim.keys.normal_mode["<S-x>"] = ":tabn<cr>"
-- new tab
lvim.keys.normal_mode["<C-n>"] = ":tabnew<cr>"

-- split windows
lvim.keys.normal_mode["_"] = ":split<cr>"
lvim.keys.normal_mode["|"] = ":vsplit<cr>"

-- splitm resize up/down/left/right with ctr+key
lvim.keys.normal_mode["<C-k>"] = "2<C-w>-"
lvim.keys.normal_mode["<C-j>"] = "2<C-w>+"
lvim.keys.normal_mode["<C-h>"] = "2<C-w><"
lvim.keys.normal_mode["<C-l>"] = "2<C-w>>"

-- sort
lvim.keys.normal_mode["<Leader>s"] = ":sort<cr>yy"

-- select all
lvim.keys.normal_mode["<C-a>"] = "<esc>ggVG<CR>"

-- clipboard
vim.opt.clipboard = ""

lvim.builtin.which_key.mappings.y = { '"+y', "Yank to clipboard" }
lvim.builtin.which_key.mappings.p = { '"+p', "paste from clipboard" }
lvim.builtin.which_key.mappings.P = { '"+P', "Paste from clipboard" }
lvim.builtin.which_key.mappings.y = {
  y = {
    '"+yy', "Yank line to clipboard"
  }
}
lvim.builtin.which_key.vmappings.y = {
  '"+y', "Yank to clipboard"
}
lvim.builtin.which_key.vmappings.p = {
  '"+p', "Paste from clipboard"
}
