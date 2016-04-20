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

" change working directory to project root
Plug 'airblade/vim-rooter'
" enable multiple comments
Plug 'scrooloose/nerdcommenter'
" code snippet <tab> completion
Plug 'garbas/vim-snipmate'
" interpret a file by function
Plug 'MarcWeber/vim-addon-mw-utils'
" align text (e.g., '=' in consequent lines)
Plug 'godlygeek/tabular'
" git-style undo options
Plug 'sjl/gundo.vim'
" git diff/blame functionality
Plug 'tpope/vim-fugitive'
" search and local vimrc files (".lvimrc") in the dir tree
Plug 'embear/vim-localvimrc'
" show guides at indent stops
Plug 'nathanaelkane/vim-indent-guides'
" auto-completion for quotes, parentheses etc.
Plug 'Raimondi/delimitMate'
" pretty vim -d (diff)
Plug 'chrisbra/vim-diff-enhanced'
" display list of functions, variables etc.
Plug 'majutsushi/tagbar'
" cscope
Plug 'brookhong/cscope.vim'

" more snippets (depends on ultisnips)
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" visual line (requires syntastic for error/warning detection)
Plug 'itchyny/lightline.vim' | Plug 'scrooloose/syntastic'

" open filesystem browser (on demand loading)
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeTabsToggle' }

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
