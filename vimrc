" ===================================================  GLOBAL SETTINGS
"
set nocompatible              " Vim not vi

"| PLUGINS START
"|
"v
"

" init
call plug#begin('~/.vim/plugged')
"disable parallel plugs
let g:plug_threads = 1

" === Plugs
Plug 'scrooloose/nerdcommenter'
Plug 'Lokaltog/powerline'
Plug 'garbas/vim-snipmate'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'godlygeek/tabular'
Plug 'Lokaltog/vim-powerline'
Plug 'sjl/gundo.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'embear/vim-localvimrc'
Plug 'vim-scripts/hgrev'
Plug 'vim-scripts/taglist.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Raimondi/delimitMate'

" On demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeTabsToggle' }
Plug 'majutsushi/tagbar', { 'on':  'TagbarOpen' }

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" JS-specific
Plug 'editorconfig/editorconfig-vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' }

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
