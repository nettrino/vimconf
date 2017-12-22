" ===================================================  GLOBAL SETTINGS
"
set nocompatible              " Vim not vi
let g:vimroot=expand($HOME . "/.vim")

"| PLUGINS START
"|
"v
"

" init
let g:plug_dir=expand(g:vimroot . "/plugged")
call plug#begin(g:plug_dir)

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
Plug 'mbbill/undotree'
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

if !(has('win32') || has ('win64'))
    " cscope only for Linux / Mac
    Plug 'brookhong/cscope.vim'
endif

" more snippets (depends on ultisnips)
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" visual line (requires syntastic for error/warning detection)
Plug 'itchyny/lightline.vim' | Plug 'w0rp/ale'

" open filesystem browser (on demand loading)
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeTabsToggle' }

" language-specific
Plug 'editorconfig/editorconfig-vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' }

Plug 'lilydjwg/colorizer',  { 'for' : 'CSS' }
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'PHP' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }

Plug 'vim-latex/vim-latex', { 'for': ['tex', 'latex', 'plaintext'] }
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'raichoo/smt-vim'
Plug 'tomlion/vim-solidity'

" Java-specific -- really slow!
" Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
" Plug 'tfnico/vim-gradle', { 'for': 'java' }
" Plug 'tpope/vim-classpath', { 'for': 'java' }

" Load colorschemes
let colorschemes=expand(g:vimroot . "/colorschemes")
Plug colorschemes

" wrap it up
call plug#end()

"^
"|
"| PLUGINS END
"
set t_Co=256

" load configs
let default_config = expand(g:vimroot . "/config/default.vim")
execute "source ".fnameescape(default_config)
let plugins_config = expand(g:vimroot . "/config/plugins.vim")
execute "source ".fnameescape(plugins_config)
let misc_config = expand(g:vimroot . "/config/misc.vim")
execute "source ".fnameescape(misc_config)

"===================================================  USER SETTINGS

" user settings - this will be ignored by git
let user_config = expand(g:vimroot . "/config/user.vim")
execute "source ".fnameescape(user_config)
