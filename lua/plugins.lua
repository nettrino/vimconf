local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
                                  install_path})
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost loader.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Install plugins
return packer.startup({
    function(use)
        use 'wbthomason/packer.nvim' -- packer can manage itself

        -- status line
        use {
            "hoob3rt/lualine.nvim",
            after = "github-nvim-theme",
            config = function()
                require("lualine").setup {
                    options = {
                        theme = "auto" -- or you can assign github_* themes individually.
                        -- ... your lualine config
                    }
                }
            end
        }

        use {
            'nvim-telescope/telescope.nvim', 
            requires = { {'nvim-lua/plenary.nvim'} }
        }

        -- parser support
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {
                "nvim-treesitter/nvim-treesitter-refactor",
            },
            run = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    -- built-in modules
                    highlight = {
                        enable = true,
                        use_languagetree = true,
                        disable = {},
                    },
                    indent = {
                        enable = true,
                        disable = {},
                    },
                    autopairs = {
                        enable = true,
                    },
                    rainbow = {
                        enable = true,
                        extended_mode = true,
                    },

                    -- additinal plugins
                    refactor = {
                        highlight_definitions = {
                            enable = true,
                        },
                        highlight_current_scope = {
                            enable = false,
                        },
                    },
                    ensure_installed = "all",
                    ignore_install = { "phpdoc" },
                })
            end,
        }

        use {
            "projekt0n/github-nvim-theme",
            config = function()
                require("github-theme").setup({
                    theme_style = "dark_default",
                    overrides = function(c)
                        return {
                            ColorColumn = { bg = "#222222" }
                        }
                    end
                })
            end
        }

        use {
            'windwp/nvim-autopairs',
            config = function()
                require('nvim-autopairs').setup()
            end
        }       

        use {
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons',
                opt = true
            },
            config = function()
                require("config.nvim-tree")
            end,
        }

        -- colors in terminal with colortoggle
        use {
            'norcalli/nvim-colorizer.lua',
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
            end
        }

        use{
            "iamcco/markdown-preview.nvim",
            run = function() vim.fn["mkdp#util#install"]() end,
        }

        -- faster lua startup
        use {
            'lewis6991/impatient.nvim',
            config = function()
                require("impatient")
            end
        }

        -- Statusline
        -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = function()
                require("lualine").setup {
                    options = {
                        theme = "auto" -- or you can assign github_* themes individually.
                        -- ... your lualine config
                    }
                }
            end
        }

        use {
            "simnalamburt/vim-mundo",
            config = function()
                require("config.mundo")
            end
        }

        -- use Mason + null-ls + cmp for language servers / linters / formatters
        use {
            'williamboman/mason.nvim',
            requires = {
                -- LSP Support
                {'williamboman/mason-lspconfig.nvim'}, -- Optional
                {'neovim/nvim-lspconfig'},             -- Required
                {"jose-elias-alvarez/null-ls.nvim"},
                --{"folke/trouble.nvim"},
                --{"folke/lsp-colors.nvim"},
                --{"weilbith/nvim-code-action-menu"},
                {"ray-x/lsp_signature.nvim"},
                --{"folke/neodev.nvim"},
                {"nvim-lua/plenary.nvim"},
                -- Autocompletion
                {'L3MON4D3/LuaSnip'},
                {'hrsh7th/nvim-cmp'},
                {'hrsh7th/cmp-nvim-lsp'},
                {'hrsh7th/cmp-buffer'},
                {'hrsh7th/cmp-path'},
                {'hrsh7th/cmp-nvim-lua'},
                {'saadparwaiz1/cmp_luasnip'},
                {'onsails/lspkind-nvim'},
            },
            config = function()
                require("config.lsp")
            end,
        }

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
})

