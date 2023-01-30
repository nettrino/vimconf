require("nvim-tree").setup()

-- OR setup with some options
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
    sort_by = "case_sensitive",
    view = {
        width = 40,
        signcolumn = "yes",
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
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
    renderer = {
        group_empty = true,
        highlight_modified = "name",
        icons = {
            webdev_colors = true,
            git_placement = "before",
            modified_placement = "after",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
                modified = false,
            },
            glyphs = {
                default = "",
                symlink = "",
                bookmark = "",
                modified = "●",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "◌",
                    -- deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    filters = {
        dotfiles = false,
    },
})
