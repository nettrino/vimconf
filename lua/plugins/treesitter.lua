return function(use)
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-refactor",
        },
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
                textobjects = {
                    enable = true,
                    select = {
                        lookahead = true,
                        enable = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]]"] = "@function.outer",
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]["] = "@function.outer",
                            ["]F"] = "@function.outer",
                            ["]C"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[["] = "@function.outer",
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[]"] = "@function.outer",
                            ["[F"] = "@function.outer",
                            ["[C"] = "@class.outer",
                        },
                    },
                },
                ensure_installed = "all",
                ignore_install = { "phpdoc" },
            })
        end,
    })
    use({
        "romgrk/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                patterns = {
                    default = {
                        "class",
                        "function",
                        "method",
                    },
                    terraform = {
                        "block",
                    },
                },
            })
        end,
    })
    use({
        "nvim-treesitter/playground",
        cmd = {
            "TSPlaygroundToggle",
        },
    })
    use({
        -- not in treesitter yet
        -- https://github.com/helix-editor/helix/issues/3117
        "alaviss/nim.nvim",
        ft = { "nim" },
    })
end
