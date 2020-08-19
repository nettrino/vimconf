" ===================================================  GLOBAL SETTINGS
"
let g:vimroot=expand($HOME . "/.vim")

"| PLUGINS START
"v

" init
let g:plug_dir=expand(g:vimroot . "/plugged")
call plug#begin(g:plug_dir)

"disable parallel plugs
"let g:plug_threads = 1

"
" Core plugins with toggles
"

" open filesystem browser (on demand loading) (toggle with Ctrl + g)
if has('nvim')
    Plug 'scrooloose/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
else
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeTabsToggle' }
    Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeTabsToggle' }
endif
" display list of functions, variables etc. (',t')
Plug 'majutsushi/tagbar'
" git-based per-file local undo tree (toggle with 'U')
Plug 'mbbill/undotree'
" comment multiple lines (visual select + ',cc' to comment/',cu' to uncomment)
Plug 'scrooloose/nerdcommenter'
"
" language server support
"
Plug 'neoclide/coc.nvim',   {'branch': 'release'}

" align text (e.g., '=' in consequent lines - visual select then ,<sumbol>)
Plug 'godlygeek/tabular'
" git diff/blame functionality (',gb' for blame, ',gd' for diff etc)
Plug 'tpope/vim-fugitive'
" show guides at indent stops (toggle with F4)
Plug 'nathanaelkane/vim-indent-guides'
" distraction-free editing (:Goyo and :Goyo! for on/off)
Plug 'junegunn/goyo.vim'

"
" Other always-on plugins
"

" Colorschemes
let colorschemes=expand(g:vimroot . "/colorschemes")
Plug colorschemes
" visual line (requires syntastic for error/warning detection)
Plug 'itchyny/lightline.vim' | Plug 'w0rp/ale'
" search and local vimrc files (".lvimrc") in the dir tree
if has('nvim') || v:version >= 704
    Plug 'embear/vim-localvimrc'
endif
" interpret a file by function
Plug 'MarcWeber/vim-addon-mw-utils'
" pretty vim -d (diff)
Plug 'chrisbra/vim-diff-enhanced'
" change working directory to project root
Plug 'airblade/vim-rooter'
" auto-completion for quotes, parentheses etc.
" this plugin does not play well with vim-tex, so keep this in mind
" See https://github.com/Raimondi/delimitMate/issues/48 and
" https://github.com/junegunn/vim-plug/issues/63
" Plug 'Raimondi/delimitMate'

" faster folding
Plug 'Konfekt/FastFold'

" cscope
let has_cscope = system("which cscope")
if !v:shell_error && !(has('win32') || has ('win64'))
    Plug 'brookhong/cscope.vim'
endif

if (has('python') || has('python3')) && (has('nvim') || v:version >= 704)
    " more snippets (depends on ultisnips)
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
endif

" run tests
Plug 'janko/vim-test'

"
" Language-specific plugins
"

" Javascript
Plug 'editorconfig/editorconfig-vim', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
if !(has('win32') || has ('win64'))
	Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' }
endif

" Typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

" Python
if has ('black')
    Plug 'psf/black', { 'for': 'python', 'tag': '*' }
else
    Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
    Plug 'tell-k/vim-autopep8', { 'for': 'python' }
endif
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }

" check if jedi is present an load it accordingly
let has_jedi = system("python -c 'import jedi'")
if !v:shell_error
    if has('nvim')
        Plug 'zchee/deoplete-jedi', { 'for': 'python' }
    else
        Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    endif
endif


" Go (order matters?)
let has_go = system("which go")
if !v:shell_error && !(has('win32') || has ('win64'))
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
endif

" PHP
if !(has('win32') || has ('win64'))
    if has('nvim')
        Plug 'padawan-php/deoplete-padawan', { 'for': 'php' }
    endif
endif

" html css
Plug 'mattn/emmet-vim'

" Java-specific -- really slow!
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
Plug 'tfnico/vim-gradle', { 'for': 'java' }
Plug 'tpope/vim-classpath', { 'for': 'java' }

" other
Plug 'lilydjwg/colorizer',  { 'for' : 'CSS' }
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'msteinert/vim-ragel', { 'for': 'ragel' }
Plug 'raichoo/smt-vim'
Plug 'tomlion/vim-solidity'
Plug 'ElmCast/elm-vim'

" wrap it up
call plug#end()

"^
"| PLUGINS END

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
