" ===================================================  GLOBAL SETTINGS
"
let g:vimroot=expand($HOME . "/.vim")

"| PLUGINS START
"|
"v
"

" init
let g:plug_dir=expand(g:vimroot . "/plugged")
call plug#begin(g:plug_dir)

"disable parallel plugs
"let g:plug_threads = 1

" change working directory to project root
Plug 'airblade/vim-rooter'
" enable multiple comments
Plug 'scrooloose/nerdcommenter'
" interpret a file by function
Plug 'MarcWeber/vim-addon-mw-utils'
" align text (e.g., '=' in consequent lines)
Plug 'godlygeek/tabular'
" git-style undo options
Plug 'mbbill/undotree'
" git diff/blame functionality
Plug 'tpope/vim-fugitive'
" search and local vimrc files (".lvimrc") in the dir tree
if has('nvim') || v:version >= 704
    Plug 'embear/vim-localvimrc'
endif
" show guides at indent stops
Plug 'nathanaelkane/vim-indent-guides'
" pretty vim -d (diff)
Plug 'chrisbra/vim-diff-enhanced'
" display list of functions, variables etc.
Plug 'majutsushi/tagbar'
" distraction-free editing
Plug 'junegunn/goyo.vim'
" auto-completion for quotes, parentheses etc.
" this plugin does not play well with vim-tex, so keep this in mind
" See https://github.com/Raimondi/delimitMate/issues/48 and
" https://github.com/junegunn/vim-plug/issues/63
Plug 'Raimondi/delimitMate'
" faster folding
Plug 'Konfekt/FastFold'

" Smart completion
if has('nvim')
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    " code snippet <tab> completion
    Plug 'garbas/vim-snipmate'
endif

if !(has('win32') || has ('win64'))
    " cscope only for Linux / Mac
    Plug 'brookhong/cscope.vim'
endif

if (has('python') || has('python3')) && (has('nvim') || v:version >= 704)
    " more snippets (depends on ultisnips)
    " Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
endif

" visual line (requires syntastic for error/warning detection)
Plug 'itchyny/lightline.vim' | Plug 'w0rp/ale'

" open filesystem browser (on demand loading)
if has('nvim')
    Plug 'scrooloose/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
else
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeTabsToggle' }
    Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeTabsToggle' }
endif
"
" language-specific
"

" Javascript
Plug 'editorconfig/editorconfig-vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
if !(has('win32') || has ('win64'))
	Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' }
endif
" Python
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
if has('nvim')
    Plug 'zchee/deoplete-jedi', { 'for': 'python' }
else
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
endif

" Go (order matters?)
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'buoto/gotests-vim', { 'for': 'go' }
if has('nvim')
    Plug 'mdempsky/gocode', {
                \ 'for': 'go',
                \ 'rtp': 'nvim',
                \ 'do': '~/.vim/plugged/gocode/nvim/symlink.sh'
                \ }
    Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make' }
    Plug 'sebdah/vim-delve', { 'for': 'go' }
else
    Plug 'mdempsky/gocode', {
                \ 'for': 'go',
                \ 'rtp': 'vim',
                \ 'do': '~/.vim/plugged/gocode/vim/symlink.sh'
                \ }
endif

" php
if has('nvim')
    Plug 'padawan-php/deoplete-padawan', { 'for': 'php' }
endif

" Markdown
Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }

Plug 'lilydjwg/colorizer',  { 'for' : 'CSS' }
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'raichoo/smt-vim'
Plug 'tomlion/vim-solidity'
" html css
Plug 'mattn/emmet-vim'

" Java-specific -- really slow!
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'tfnico/vim-gradle', { 'for': 'java' }
Plug 'tpope/vim-classpath', { 'for': 'java' }

" Load colorschemes
let colorschemes=expand(g:vimroot . "/colorschemes")
Plug colorschemes

" wrap it up
call plug#end()

"^
"|
"| PLUGINS END
"

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
