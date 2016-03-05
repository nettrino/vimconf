" ===================================================  GLOBAL SETTINGS
"
set nocompatible              " Vim not vi
filetype off                  " required by Vundle

"| PLUGINS START
"|
"v
"

" set the runtime path to include Vundle
call plug#begin('~/.vim/plugged')


" === Plugs
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/Lokaltog/powerline.git'
Plug 'https://github.com/garbas/vim-snipmate.git'
Plug 'https://github.com/tomtom/tlib_vim.git'
Plug 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
Plug 'https://github.com/honza/vim-snippets.git'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/jistr/vim-nerdtree-tabs.git'
Plug 'https://github.com/Lokaltog/vim-powerline.git'
Plug 'https://github.com/sjl/gundo.vim.git'
Plug 'https://github.com/scrooloose/syntastic.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/embear/vim-localvimrc.git'
Plug 'https://github.com/vim-scripts/hgrev.git'
Plug 'https://github.com/vim-scripts/taglist.vim.git'
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plug 'https://github.com/Raimondi/delimitMate.git'

" JS-specific
" Plug 'https://github.com/editorconfig/editorconfig-vim.git'
" Plug 'https://github.com/pangloss/vim-javascript.git'
" Plug 'https://github.com/maksimr/vim-jsbeautify.git'
" LLVM-specific
" Plug 'https://github.com/Superbil/llvm.vim.git'

" Load colorschemes
Plug '~/.vim/colorschemes'


" wrap it up
call plug#end()

"^
"|
"| PLUGINS END
"

filetype plugin indent on
syntax on
syntax enable
set t_Co=256

" load config
so ~/.vim/config/vimrc.default
so ~/.vim/config/plugins.vim
so ~/.vim/config/misc.vim

"===================================================  USER SETTINGS

" user settings - this will be ignored by git
so ~/.vim/config/vimrc.user
