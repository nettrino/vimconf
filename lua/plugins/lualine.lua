return function(use)
    use({
        "nvim-lualine/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
            "lewis6991/gitsigns.nvim",
        },
        config = function()
            table.insert(require("lualine.extensions.fugitive").filetypes, "fugitiveblame")

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "powerline",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        "NvimTree",
                        "alpha",
                        "fugitive",
                        "fugitiveblame",
                        "qf",
                    },
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = {
                        function()
                            return string.sub(require("lualine.components.mode")(), 1, 1)
                        end,
                    },
                    lualine_b = {
                        {
                            "filename",
                            file_status = true,
                            path = 1,
                        },
                    },
                    lualine_c = {
                        "diagnostics",
                        { "filetype", icon_only = true },
                        {
                            "fileformat",
                            symbols = {
                                unix = "",
                                dos = "",
                                mac = "",
                            },
                        },
                    },
                    lualine_x = {
                        {
                            "diff",
                            source = function()
                                local count_for = function(type)
                                    local gsd = vim.b.gitsigns_status_dict
                                    if gsd and gsd[type] and gsd[type] > 0 then
                                        return gsd[type]
                                    end
                                    return 0
                                end
                                return {
                                    added = count_for("added"),
                                    modified = count_for("changed"),
                                    removed = count_for("removed"),
                                }
                            end,
                        },
                        function()
                            return " " .. (vim.b.gitsigns_head or "")
                        end,
                    },
                    lualine_y = { "progress", "location" },
                    lualine_z = {},
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                extensions = {},
            })
        end,
    })
end
