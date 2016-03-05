" ===================================================  GLOBAL SETTINGS
"
set nocompatible              " Vim not vi
filetype off                  " required by Vundle

"| PLUGINS START
"|
"v
"

" init
call plug#begin('~/.vim/plugged')
"disable parallel plugs
let g:plug_threads = 1

" === Plugs
Plug 'scrooloose/nerdtree.git', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter.git'
Plug 'Lokaltog/powerline.git'
Plug 'garbas/vim-snipmate.git'
Plug 'tomtom/tlib_vim.git'
Plug 'MarcWeber/vim-addon-mw-utils.git'
Plug 'godlygeek/tabular.git'
Plug 'jistr/vim-nerdtree-tabs.git'
Plug 'Lokaltog/vim-powerline.git'
Plug 'sjl/gundo.vim.git'
Plug 'scrooloose/syntastic.git'
Plug 'tpope/vim-fugitive.git'
Plug 'majutsushi/tagbar.git'
Plug 'embear/vim-localvimrc.git'
Plug 'vim-scripts/hgrev.git'
Plug 'vim-scripts/taglist.vim.git'
Plug 'nathanaelkane/vim-indent-guides.git'
Plug 'Raimondi/delimitMate.git'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" JS-specific
Plug 'editorconfig/editorconfig-vim.git', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript.git', { 'for': 'javascript' }
Plug 'maksimr/vim-jsbeautify.git', { 'for': 'javascript' }

" Load colorschemes
Plug '~/.vim/colorschemes'


" wrap it up
call plug#end()

"^
"|
"| PLUGINS END
"
set t_Co=256

" load config
so ~/.vim/config/vimrc.default
so ~/.vim/config/plugins.vim
so ~/.vim/config/misc.vim

"===================================================  USER SETTINGS

" user settings - this will be ignored by git
so ~/.vim/config/vimrc.user
