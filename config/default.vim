" =========================== COLORS =====================================
set background=dark
colorscheme monokain

" ====================== GENERAL CONFIG ==================================
set number						" Numbering of lines
set hidden                      " Don't abandon buffers moved to the backgr.
set updatecount=100             " Write swap file to disk every 100 chars
set directory=~/.vim/swap       " Directory to use for the swap file
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
set textwidth=80
set formatoptions=cqtr
set wrapmargin=0
set colorcolumn=80
set mouse=a			            " Enable mouse in all modes

" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /100 : save 100 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each register
"   :1000 : up to 1000 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo=%100,'100,/100,h,\"500,:1000,n~/.vim/viminfo

" ctags: recurse up to home to find tags. See
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
" for an explanation and other ctags tips/tricks
set tags+=tags;$HOME
set t_Co=256

" Undo
set undolevels=10000
if has("persistent_undo")
  set undodir=~/.vim/undo  " Allow undos to persist even after a file is closed
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
map <Leader>y "+2yy
"cut to X11 clipboard
map <Leader>d "+dd
"paste X11 clipboard
map <Leader>p "+p


"go to previous tab
map <F1> :tabp<CR>
"go to next tab
map <F2> :tabn<CR>
"open new tab
map <C-n> :tabnew<CR>
"reload document from disk
map <F5> :e<CR>
"spelling toggle
nmap <F6>      :setlocal spell!<CR>
imap <F6> <C-o>:setlocal spell!<CR>

map <F9> :make<CR>

" Add license
map :license :0r ~/.vim/license.txt


"\ 0r ~/.vim/license.txt
"augroup END

" Resize window splits
nnoremap <S-Up>    3<C-w>-
nnoremap <S-Down>  3<C-w>+
nnoremap <S-Left>  3<C-w><
nnoremap <S-Right> 3<C-w>>

nnoremap _ :split<cr>
nnoremap \| :vsplit<cr>

" hex mode
map <Leader>hon :set binary <bar> %!xxd<CR>
map <Leader>hof :set binary <bar> %!xxd -r<CR>
