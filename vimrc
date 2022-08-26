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
Plug 'maximbaz/lightline-ale'
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

if (has('python3') && (has('nvim') || v:version >= 704))
    " more snippets (depends on ultisnips)
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'davidhalter/jedi-vim'
endif


Plug 'rhysd/vim-clang-format'

" run tests
Plug 'janko/vim-test'

" language server
if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
else
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
endif
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" fuzzy searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

"
" Language-specific plugins
"

" Javascript / Typescript
Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'

if !(has('win32') || has ('win64'))
	Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' }
endif

" Typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

" Python
Plug 'psf/black', { 'for': 'python', 'tag': '*' }
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'petobens/poet-v', {'for': 'python'}

" Solidity
Plug 'tomlion/vim-solidity'

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
