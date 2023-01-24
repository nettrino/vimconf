return function(use)
    use({
        "tanvirtin/monokai.nvim",
        config = function()
            local monokai = require("monokai")
            local palette = monokai.classic
            monokai.setup({
                custom_hlgroups = {
                    LspReferenceRead = {
                        bg = palette.red,
                        fg = palette.white,
                    },
                    LspReferenceText = {
                        bg = palette.red,
                        fg = palette.white,
                    },
                    LspReferenceWrite = {
                        bg = palette.red,
                        fg = palette.white,
                    },
                    GitSignsAdd = {
                        fg = palette.green,
                    },
                    GitSignsDelete = {
                        fg = palette.pink,
                    },
                    GitSignsChange = {
                        fg = palette.orange,
                    },
                    TabLine = {
                        bg = palette.base2,
                        fg = palette.base6,
                    },
                    TabLineSel = {
                        bg = palette.base5,
                        fg = palette.white,
                        style = "bold",
                    },
                    TabLineFill = {
                        bg = palette.base2,
                    },
                },
            })
        end,
    })
end
