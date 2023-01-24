vim.g.mkdp_open_to_the_world = 1
vim.g.mkdp_echo_preview_url = 1

return function(use)
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        cmd = {
            "MarkdownPreview",
        },
        config = function()
            -- need to manually set commands as otherwise they are not registering
            -- for some reason when lazily loaded
            vim.cmd([[
			command! -buffer MarkdownPreview call mkdp#util#open_preview_page()
			command! -buffer MarkdownPreviewStop call mkdp#util#stop_preview()
			command! -buffer MarkdownPreviewToggle call mkdp#util#toggle_preview()
			]])
        end,
    })
end
