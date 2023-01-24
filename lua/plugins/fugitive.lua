vim.cmd([[
    command! -nargs=* Browse
]])

return function(use)
    -- adds git commands such as :Gdiffssplit for 3-way-merge
    use({
        "tpope/vim-fugitive",
        requires = {
            "tpope/vim-rhubarb",
        },
    })
end
