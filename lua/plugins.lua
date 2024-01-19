local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap =
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost loader.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Install plugins
return packer.startup({
    function(use)
        use("wbthomason/packer.nvim") -- packer can manage itself

        use({
            "lukas-reineke/indent-blankline.nvim",
        })

        use({ "towolf/vim-helm" })

        -- fuzzy finder with ,ff etc.
        use({
            "nvim-telescope/telescope.nvim",
            requires = { { "nvim-lua/plenary.nvim" } },
        })

        -- git
        -- FIXME
        -- noremap <silent> <Leader>gd :Git diff<CR>
        -- noremap <silent> <Leader>gb :Git blame<CR>
        use("tpope/vim-fugitive")

        -- parser support and syntax highlight
        -- this is orthogonal to ftdetect and syntax plugins
        -- see what exactly gets loaded and when with
        -- 'nvim --startuptime log'
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = {
                        "c",
                        "lua",
                        "vim",
                        "vimdoc",
                        "python",
                        "go",
                        "bash",
                        "html",
                        "css",
                        "javascript",
                        "typescript",
                        "rust",
                        "terraform",
                    },
                    highlight = {
                        enable = true,
                    },
                    ignore_install = { "phpdoc" },
                })
            end,
        })

        use({
            "nvim-treesitter/playground",
            run = ":TSInstall query",
            requires = {
                { "nvim-treesitter/nvim-treesitter" },
            },
            config = function()
                require("nvim-treesitter.configs").setup({
                    playground = {
                        enable = true,
                        disable = {},
                        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                        persist_queries = false, -- Whether the query persists across vim sessions
                        keybindings = {
                            toggle_query_editor = "o",
                            toggle_hl_groups = "i",
                            toggle_injected_languages = "t",
                            toggle_anonymous_nodes = "a",
                            toggle_language_display = "I",
                            focus_language = "f",
                            unfocus_language = "F",
                            update = "R",
                            goto_node = "<cr>",
                            show_help = "?",
                        },
                    },
                })
            end,
        })

        use({
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup()
            end,
        })

        use({
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup({
                    ---Add a space b/w comment and the line
                    padding = true,
                    ---Whether the cursor should stay at its position
                    sticky = true,
                    ---Lines to be ignored while (un)comment
                    ignore = "^$",
                })
            end,
        })

        -- use({ "catppuccin/nvim", as = "catppuccin" })
        -- vim.cmd("colorscheme catppuccin")

        use({
            "projekt0n/github-nvim-theme",
            config = function()
                require("github-theme").setup({
                    options = {
                        bg_search = "#00006b",
                        hide_nc_statusline = false,
                    },
                    groups = {
                        all = {
                            ["@funcion"] = { fg = "palette.pink" },
                            ["@identifier"] = { fg = "palette.yellow" },
                            ["@field"] = { fg = "palette.red" },
                            ["@boolean"] = { bg = "#00ff8b", fg = "#aaff8b", sp = "#1af231", style = "underline" },
                            ["@type.definition"] = { fg = "palette.green" },
                            ["@variable"] = { fg = "palette.red" },
                            ["@constant.builtin"] = { fg = "palette.pink" },
                            ["StatusLineNC"] = { bg = "#00ff8b", fg = "#aaff8b", sp = "#1af231", style = "underline" },
                        },
                    },
                })
            end,
        })
        vim.cmd("colorscheme github_dark_dimmed")

        -- use({
        --     "EdenEast/nightfox.nvim",
        --     config = function()
        --         require("gitsigns").setup()
        --     end,
        -- })
        -- vim.cmd("colorscheme carbonfox")

        -- Statusline
        -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
        use({
            "nvim-lualine/lualine.nvim",
            requires = {
                { "kyazdani42/nvim-web-devicons" },
                { "b0o/incline.nvim" },
            },
            config = function()
                require("incline").setup()
                require("lualine").setup({
                    options = {
                        theme = "github_dark_dimmed",
                    },
                })
            end,
        })

        use({
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup()
            end,
        })

        use({
            "nvim-tree/nvim-tree.lua",
            requires = {
                "nvim-tree/nvim-web-devicons",
                opt = true,
            },
            config = function()
                require("config.nvim-tree")
            end,
        })

        use({
            "ludovicchabant/vim-gutentags",
            config = function()
                if vim.fn.executable("fd") == 0 then
                    return function() end
                end

                if vim.fn.executable("ctags") == 0 then
                    return function() end
                end

                vim.g.gutentags_define_advanced_commands = true
                vim.g.gutentags_file_list_command = "fd --strip-cwd-prefix"
            end,
        })

        -- colors in terminal with colortoggle
        use({
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
        })

        use({
            "iamcco/markdown-preview.nvim",
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
        })

        -- faster lua startup
        use({
            "lewis6991/impatient.nvim",
            config = function()
                require("impatient")
            end,
        })

        use({
            "simnalamburt/vim-mundo",
            config = function()
                require("config.mundo")
            end,
        })

        -- lsp
        use({
            "VonHeikemen/lsp-zero.nvim",
            branch = "v2.x",
            requires = {
                -- LSP Support
                { "neovim/nvim-lspconfig" }, -- Required
                { "williamboman/mason.nvim" }, -- Optional
                { "williamboman/mason-lspconfig.nvim" }, -- Optional

                -- Autocompletion
                { "hrsh7th/nvim-cmp" }, -- Required
                { "hrsh7th/cmp-nvim-lsp" }, -- Required
                { "hrsh7th/cmp-buffer" }, -- Optional
                -- { "hrsh7th/cmp-path" }, -- Optional
                { "saadparwaiz1/cmp_luasnip" }, -- Optional
                { "hrsh7th/cmp-nvim-lua" }, -- Optional

                -- Snippets
                { "L3MON4D3/LuaSnip" }, -- Required
                { "rafamadriz/friendly-snippets" }, -- Optional
            },
            config = function()
                require("config.lsp")
            end,
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
            after = "mason.nvim",
            requires = {
                { "jay-babu/mason-null-ls.nvim" },
            },
            config = function()
                require("config.null-ls")
            end,
        })

        -- nim
        -- use({
        --     "alaviss/nim.nvim",
        --     after = "null-ls.nvim",
        --     config = function()
        --         require("config.nim")
        --     end,
        -- })

        -- Automatically set up your configuration after cloning packer.nvim
        -- Must live end after all plugins
        if packer_bootstrap then
            require("packer").sync()
        end
    end,
})
