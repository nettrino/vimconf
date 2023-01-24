return function(use)
    use({
        "McAuleyPenney/tidy.nvim",
		branch = "main",
        event = "BufWritePre",
        config = function()
            require("tidy").setup()
        end,
    })
end
