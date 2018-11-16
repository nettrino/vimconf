" init
let g:vim_root=expand("$HOME/.vim")

" add g:vim_root to the front of the runtimepath
execute "set rtp^=".g:vim_root
execute "source " .g:vim_root . '\\vimrc'
