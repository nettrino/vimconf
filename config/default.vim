" =========================== COLORS =====================================
set t_Co=256
set background=dark

if !empty($CONEMUBUILD)
    set termencoding=utf8
    set encoding=utf8
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set bs=indent,eol,start
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>
endif

colorscheme monokain

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

" Formatting, indentation and tabbing - see end of vimrc for custom settings
set autoindent smartindent
set smarttab                    " Make <tab> and <backspace> smarter
set expandtab
set tabstop=4
set shiftwidth=4
set formatoptions=cqtr
set colorcolumn=80

set mouse=a			            " Enable mouse in all modes
" make sure things work even inside tmux
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" Directory to use for the swap file
let swapdir=expand(g:vimroot . "/swap")
if !isdirectory(swapdir)
    call mkdir(swapdir, "p", 0755)
endif
execute "set directory=".fnameescape(swapdir)

let editinfo=expand(g:vimroot . "/.viminfo")
" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /200 : save 200 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each register
"   :1000 : up to 1000 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo=%100,'200,/100,h,\"500,:1000,neditinfo

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

" After 4s of inactivity, check for ext. file modifications on next keyrpress
au CursorHold * checktime

"
" ====== cscope
"
if has("cscope")
  " Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
  set cscopetag

  " Check cscope for definition of a symbol before checking ctags. Set to 1 if
  " you want the reverse search order.
  set csto=0

  " Add any cscope database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  endif

  " Show msg when any other cscope db is added
  set cscopeverbose
end



" ========================= KEY MAPPINGS ======================================

let mapleader=","
let localmapleader=","

"Turn off highlight of search
map <Leader>/ :nohlsearch<cr>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

"Copy to X11 clipboard. Need to install a vim version that supports +xclipboard
"for this to work like vim-athena, otherwise the selection won't be copied
" FIXME add support for Windows
map <Leader>y "+2yy
"cut to X11 clipboard
map <Leader>d "+dd
"paste X11 clipboard
map <Leader>p "+p

" F1 prev tab
" F2 next tab
" F3 Syntastic Toggle
" F4 Indent Guides Toggle
" F5 Reload page
" F6 Spell Toggle
" F7 Save session (open tabs) (will overwrite any previous session)
" F8 Restore Session (only a single session is restored)
" F9 Make (if makefile is present)


"go to previous tab
map <F1> :tabp<CR>
"go to next tab
map <F2> :tabn<CR>
"open new tab
map <C-n> :tabnew<CR>
"reload document from disk
map <F5> :e<CR>
"spelling toggle
nmap <F6> :setlocal spell!<CR>
imap <F6> <C-o>:setlocal spell!<CR>

" FIXME http://stackoverflow.com/questions/1642611/how-to-save-a-session-in-vim
" map <F7> :mksession! ~/.vim_saved_session<CR>
" map <F8> :source ~/.vim_saved_session<CR>

map <F9> :make<CR>

" Resize window splits
" up
nnoremap <C-k>      3<C-w>-
" down
nnoremap <C-j>  3<C-w>+
" left
nnoremap <C-h>  3<C-w><
" right
nnoremap <C-l> 3<C-w>>

nnoremap _ :split<cr>
nnoremap \| :vsplit<cr>

" hex mode
map <Leader>hon :set binary <bar> %!xxd<CR>
map <Leader>hof :set binary <bar> %!xxd -r<CR>

" Remove trailing whitespace
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" fix backspace
set backspace=indent,eol,start

" select all
map <C-a> <esc>ggVG<CR>
