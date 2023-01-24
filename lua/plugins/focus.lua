return function(use)
    use({
        "junegunn/goyo.vim",
        cmd = {
            "Goyo",
        },
        config = function()
            vim.g.goyo_width = 120
        end,
    })
    use({
        "junegunn/limelight.vim",
        cmd = {
            "Limelight",
        },
        config = function()
            vim.cmd([[
                autocmd! User GoyoEnter Limelight
                autocmd! User GoyoLeave Limelight!
            ]])
        end,
    })
end
