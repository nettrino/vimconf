" ===================== COLORS & TERMINAL =====================================
set t_Co=256
set background=dark

if !empty($CONEMUBUILD)
    set termencoding=utf8
    set encoding=utf8
    set term=xterm
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set bs=indent,eol,start
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>
endif

if !(has('win32') || has ('win64'))
    colorscheme monokain
else
    " this has been working nicely with solarized dark theme from the
    " colortool released by Microsoft. See github.com/microsoft/console
    colorscheme DevC++
endif

" ====================== GENERAL CONFIG ==================================
set number						" Numbering of lines
set hidden                      " Don't abandon buffers moved to the backgr.
set updatecount=100             " Write swap file to disk every 100 chars
set diffopt=filler,iwhite       " In diff mode, ignore whitespace,
                                " align lines
                                "
set history=1000                " Remember 1000 commands
set scrolloff=3                 " Start scrolling 3 lines before win. border
set visualbell t_vb=            " Disable error bells
set t_BE=                       " no braketed paste mode

" Formatting, indentation and tabbing - see end of vimrc for custom settings
set autoindent
filetype plugin indent on
set smarttab                    " Make <tab> and <backspace> smarter
set expandtab
set tabstop=4
set shiftwidth=4
set formatoptions=cqtr
set colorcolumn=80
set completeopt-=preview " disable preview window at the bottom of the screen

" Enable mouse in all modes
set mouse=a
" make sure things work even inside tmux
if !has('nvim')
    if has("mouse_sgr")
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    end
else
    set guicursor=
endif

" Directory to use for the swap file
let swapdir=expand(g:vimroot . "/swap")
if !isdirectory(swapdir)
    call mkdir(swapdir, "p", 0755)
endif
execute "set directory=".fnameescape(swapdir)

" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %

" ====================== GENERAL CONFIG ==================================
set number						" Numbering of lines
set hidden                      " Don't abandon buffers moved to the backgr.
set updatecount=100             " Write swap file to disk every 100 chars
set diffopt=filler,iwhite       " In diff mode, ignore whitespace,
                                " align lines
                                "
set history=1000                " Remember 1000 commands
set scrolloff=3                 " Start scrolling 3 lines before win. border
set visualbell t_vb=            " Disable error bells
set t_BE=                       " no braketed paste mode

" Formatting, indentation and tabbing - see end of vimrc for custom settings
set autoindent
filetype plugin indent on
set smarttab                    " Make <tab> and <backspace> smarter
set expandtab
set tabstop=4
set shiftwidth=4
set formatoptions=cqtr
set colorcolumn=80
set completeopt-=preview " disable preview window at the bottom of the screen

" Enable mouse in all modes
set mouse=a
" make sure things work even inside tmux
if !has('nvim')
    if has("mouse_sgr")
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    end
else
    set guicursor=
endif

" Directory to use for the swap file
let swapdir=expand(g:vimroot . "/swap")
if !isdirectory(swapdir)
    call mkdir(swapdir, "p", 0755)
endif
execute "set directory=".fnameescape(swapdir)

" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %

" ====================== GENERAL CONFIG ==================================
set number						" Numbering of lines
set hidden                      " Don't abandon buffers moved to the backgr.
set updatecount=100             " Write swap file to disk every 100 chars
set diffopt=filler,iwhite       " In diff mode, ignore whitespace,
                                " align lines
                                "
set history=1000                " Remember 1000 commands
set scrolloff=3                 " Start scrolling 3 lines before win. border
set visualbell t_vb=            " Disable error bells
set t_BE=                       " no braketed paste mode

" Formatting, indentation and tabbing - see end of vimrc for custom settings
set autoindent
filetype plugin indent on
set smarttab                    " Make <tab> and <backspace> smarter
set expandtab
set tabstop=4
set shiftwidth=4
set formatoptions=cqtr
set colorcolumn=80
set completeopt-=preview " disable preview window at the bottom of the screen

" Enable mouse in all modes
set mouse=a
" make sure things work even inside tmux
if !has('nvim')
    if has("mouse_sgr")
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    end
else
    set guicursor=
endif

" Directory to use for the swap file
let swapdir=expand(g:vimroot . "/swap")
if !isdirectory(swapdir)
    call mkdir(swapdir, "p", 0755)
endif
execute "set directory=".fnameescape(swapdir)

" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /200 : save 200 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each register
"   :1000 : up to 1000 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo=%100,'200,/100,h,\"500,:1000

" ctags: recurse up to home to find tags. See
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
" for an explanation and other ctags tips/tricks
set tags+=tags;$HOME

" Undo
set undolevels=10000
let undo_dir=expand(g:vimroot . "/undo")
if !isdirectory(undo_dir)
    call mkdir(undo_dir, "p", 0755)
endif
if has("persistent_undo")
 " Allow undos to persist even after a file is closed
  execute "set undodir=".fnameescape(undo_dir)
  set undofile
endif

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

" open new pages on the right split when vsplitting
set splitright

" ========================= KEY MAPPINGS ======================================

let mapleader=","
let localmapleader=","

"Turn off highlight of search
noremap <Leader>/ :nohlsearch<cr>
noremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Paste mode toggle
set pastetoggle=<F2>
set clipboard=unnamed
"Copy to X11 clipboard. Need to install a vim version that supports +xclipboard
"for this to work like vim-athena, otherwise the selection won't be copied
" FIXME add support for Windows
noremap <Leader>y "+2yy
"cut to X11 clipboard
noremap <Leader>d "+dd
"paste X11 clipboard
noremap <Leader>p "+p

" F1 is the default key for help so leave it as it is
" F2 Paste mode toggle
" F3 Syntastic Toggle
" F4 Indent Guides Toggle
" F5 Reload page
" F6 Spell Toggle
" F7 Save session (open tabs) (will overwrite any previous session)
" F8 Restore Session (only a single session is restored)
" F9 Make (if makefile is present)
" F10 Toggle distraction-free editing (Goyo)

"go to previous tab
noremap <S-z> :tabp<CR>
"go to next tab
noremap <S-x> :tabn<CR>
"open new tab
noremap <C-n> :tabnew<CR>
"reload document from disk
noremap <F5> :e<CR>
"spelling toggle
noremap <F6> :setlocal spell!<CR>
imap <F6> <C-o>:setlocal spell!<CR>

noremap <F9> :make<CR>
noremap <F10> :Goyo<CR>

" splits
noremap _ :split<cr>
noremap \| :vsplit<cr>
" Resize window splits
" up
noremap <C-k> 2<C-w>-
" down
noremap <C-j> 2<C-w>+
" left
noremap <C-h> 2<C-w><
" right
noremap <C-l> 2<C-w>>

" hex mode
noremap <Leader>hon :set binary <bar> %!xxd<CR>
noremap <Leader>hof :set binary <bar> %!xxd -r<CR>

" select all
noremap <C-a> <esc>ggVG<CR>

" Autocomplete with Ctrl + Space
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" sort selected
vnoremap <Leader>s :sort<CR>

" indent with < directly in visual mode
vnoremap < <gv
vnoremap > >gv

" Enable Greek!
" Map to Ctrl+L
inoremap <c-l> <c-^>
set keymap=greek_utf-8
set iminsert=0
set imsearch=-1

" hide dashes in folds and remember folds on close
set fillchars=fold:\ "
" augroup remember_folds
  " autocmd!
  " autocmd BufWinLeave * mkview
  " autocmd BufWinEnter * silent! loadview
" augroup END

" ========================= AutoCmds ======================================

" After 4s of inactivity, check for ext. modifications on next keyrpress
augroup reload_if_inactive
    autocmd!
    autocmd CursorHold * checktime
augroup END

" Remove trailing whitespace at every write
function! <SID>StripTrailingWhitespaces() abort
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

augroup trailing_whitespaces
    autocmd!
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
augroup END

" fix backspace
set backspace=indent,eol,start
