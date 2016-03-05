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
Plug 'gscrooloose/nerdtree.git'
Plug 'gscrooloose/nerdcommenter.git'
Plug 'gLokaltog/powerline.git'
Plug 'ggarbas/vim-snipmate.git'
Plug 'gtomtom/tlib_vim.git'
Plug 'gMarcWeber/vim-addon-mw-utils.git'
Plug 'ghonza/vim-snippets.git'
Plug 'ggodlygeek/tabular.git'
Plug 'gjistr/vim-nerdtree-tabs.git'
Plug 'gLokaltog/vim-powerline.git'
Plug 'gsjl/gundo.vim.git'
Plug 'gscrooloose/syntastic.git'
Plug 'gtpope/vim-fugitive.git'
Plug 'gmajutsushi/tagbar.git'
Plug 'gembear/vim-localvimrc.git'
Plug 'gvim-scripts/hgrev.git'
Plug 'gvim-scripts/taglist.vim.git'
Plug 'gSirVer/ultisnips.git'
Plug 'gnathanaelkane/vim-indent-guides.git'
Plug 'gRaimondi/delimitMate.git'

" JS-specific
" Plug 'geditorconfig/editorconfig-vim.git'
" Plug 'gpangloss/vim-javascript.git'
" Plug 'gmaksimr/vim-jsbeautify.git'
" LLVM-specific
" Plug 'gSuperbil/llvm.vim.git'

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
