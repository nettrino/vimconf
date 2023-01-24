vim.cmd([[
nmap <Leader>dd <Plug>VimspectorContinue
nnoremap <Leader>de :call vimspector#Reset()<CR>
nmap <Leader>dc <Plug>VimspectorContinue

nmap <Leader>dt <Plug>VimspectorToggleBreakpoint
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dj <Plug>VimspectorStepOver
nmap <Leader>dk <Plug>VimspectorRunToCursor
nmap <Leader>dl <Plug>VimspectorStepInto
]])

return function(use)
    use("puremourning/vimspector")
end
