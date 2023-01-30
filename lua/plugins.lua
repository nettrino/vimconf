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

        -- fuzzy finder with ,ff etc.
        use({
            "nvim-telescope/telescope.nvim",
            requires = { { "nvim-lua/plenary.nvim" } },
        })

        -- parser support and syntax highlight
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = "all",
                    highlight = {
                        enable = true,
                    },
                    ignore_install = { "phpdoc" },
                })
            end,
        })

        use({
            "numToStr/Comment.nvim",
            keys = {
                { "n", "gc" },
                { "n", "gb" },
                { "v", "gc" },
                { "v", "gb" },
            },
            config = function()
                require("Comment").setup({
                    padding = true,
                    sticky = true,
                    ignore = "^$",
                    toggler = {
                        line = "gcc",
                        block = "gbc",
                    },
                    opleader = {
                        line = "gc",
                        block = "gb",
                    },
                    extra = {
                        above = "gcO",
                        below = "gco",
                        eol = "gcA",
                    },
                    mappings = {
                        basic = true,
                        extra = true,
                        extended = false,
                    },
                    pre_hook = nil,
                    post_hook = nil,
                })
            end,
        })

        use({
            "projekt0n/github-nvim-theme",
            config = function()
                require("github-theme").setup({
                    theme_style = "dimmed",
                    -- overrides = function(c)
                    --     return {
                    --         ColorColumn = { bg = "#222222" },
                    --         Normal = { bg = "#0d1117" }
                    --     }
                    -- end
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

        -- Statusline
        -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
        use({
            "nvim-lualine/lualine.nvim",
            after = "github-nvim-theme",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = function()
                require("lualine").setup({
                    options = {
                        theme = "auto", -- or you can assign github_* themes individually.
                        -- ... your lualine config
                    },
                })
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
            branch = "v1.x",
            requires = {
                -- LSP Support
                { "neovim/nvim-lspconfig" }, -- Required
                { "williamboman/mason.nvim" }, -- Optional
                { "williamboman/mason-lspconfig.nvim" }, -- Optional

                -- Autocompletion
                { "hrsh7th/nvim-cmp" }, -- Required
                { "hrsh7th/cmp-nvim-lsp" }, -- Required
                { "hrsh7th/cmp-buffer" }, -- Optional
                { "hrsh7th/cmp-path" }, -- Optional
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
            config = function()
                require("config.null-ls")
            end,
        })

        -- Automatically set up your configuration after cloning packer.nvim
        -- Must live end after all plugins
        if packer_bootstrap then
            require("packer").sync()
        end
    end,
})
