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
Plug 'airblade/vim-rooter'
Plug 'scrooloose/nerdcommenter'
Plug 'garbas/vim-snipmate'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'godlygeek/tabular'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'embear/vim-localvimrc'
Plug 'vim-scripts/hgrev'
Plug 'vim-scripts/taglist.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Raimondi/delimitMate'
Plug 'chrisbra/vim-diff-enhanced'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim' | Plug 'scrooloose/syntastic'

" On demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeTabsToggle' }
Plug 'majutsushi/tagbar', { 'on':  'TagbarOpen' }

" JS-specific
Plug 'editorconfig/editorconfig-vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' }

" Python-specific
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }

" Java-specific
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'tfnico/vim-gradle', { 'for': 'java' }
Plug 'tpope/vim-classpath', { 'for': 'java' }

" CSV-specific
Plug 'chrisbra/csv.vim'

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
so ~/.vim/config/default.vim
so ~/.vim/config/plugins.vim
so ~/.vim/config/misc.vim

"===================================================  USER SETTINGS

" user settings - this will be ignored by git
so ~/.vim/config/user.vim
