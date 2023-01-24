vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

local opts = {
    noremap = true,
    silent = true,
}

vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<CR>", opts)

return function(use)
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        cmd = {
            "NvimTreeToggle",
        },
        setup = function() end,
        config = function()
            require("nvim-tree").setup({
                disable_netrw = true,
                hijack_netrw = true,
                open_on_setup = false,
                ignore_ft_on_setup = {},
                open_on_tab = false,
                hijack_cursor = false,
                update_cwd = false,
                hijack_directories = {
                    enable = false,
                    auto_open = true,
                },
                diagnostics = {
                    enable = false,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    },
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                    ignore_list = {},
                },
                system_open = {
                    cmd = nil,
                    args = {},
                },
                filters = {
                    dotfiles = false,
                    custom = {},
                },
                git = {
                    enable = true,
                    ignore = true,
                    timeout = 500,
                },
                view = {
                    width = 30,
                    hide_root_folder = false,
                    side = "left",
                    adaptive_size = false,
                    mappings = { custom_only = false, list = {} },
                    number = false,
                    relativenumber = false,
                    signcolumn = "yes",
                },
                trash = {
                    cmd = "trash",
                    require_confirm = true,
                },
                actions = {
                    open_file = {
                        window_picker = {
                            enable = false,
                        },
                    },
                },
            })
        end,
    })
end
