"
" ====== GUNDO_TOGGLE
"
nnoremap <S-u> :GundoToggle<CR>
let g:gundo_close_on_revert=1


"
" ====== NerdTreeTabs
"
nnoremap <C-g> :NERDTreeTabsToggle<cr>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                   \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo' ]
let NERDTreeHighlightCursorline=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1

"
" ====== Fugitive
"
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>

"
" ====== NerdCommenter
"
" Go into visual mode and then type ,cc or cn to comment and ,cu to uncomment
" Put a space around comment markers
let g:NERDSpaceDelims = 1

"
" ====== Syntastic
"
highlight SyntasticWarning NONE
highlight SyntasticError NONE
let g:syntastic_debug=0
let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:quickfixsigns_classes=['qfl', 'vcsdiff', 'breakpoints']
let g:syntastic_enable_highlighting = 1
let g:syntastic_warning_symbol = "!"
let g:syntastic_error_symbol = "x"
map <F3> :SyntasticToggleMode<CR>

" See ~/.vim/bundle/syntastic/syntax_checkers for options
" open errors with :lopen

" python
let g:syntastic_python_checkers = ['pylint', 'python']
" php
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
"c
let g:syntastic_c_check_header = 1
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_c_no_include_search = 1
let g:syntastic_c_no_default_include_dirs = 1
let g:syntastic_c_compiler = 'clang'
let g:syntastic_c_checkers = ['make']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_no_include_search = 1
let g:syntastic_cpp_no_default_include_dirs = 1
let g:syntastic_cpp_checkers = ['clang_check', 'gcc']
"javascript
let g:syntastic_javascript_checkers = ['jshint']

"
" ====== Powerline
"
let g:Powerline_symbols = 'unicode'
set laststatus=2

"
" ====== Tabularize
"
noremap \c :Tabularize /\/\*<CR>
noremap \= :Tabularize /=<CR>
noremap \: :Tabularize /:<CR>
noremap \+ :Tabularize /+<CR>
noremap \: :Tabularize /^[^:]*:\zs/l0l1<CR>
noremap \> :Tabularize /=><CR>
noremap \, :Tabularize /,\zs/l0l1<CR>
noremap \{ :Tabularize /{<CR>
noremap \\| :Tabularize /\|<CR>
noremap \& :Tabularize /\(&\\|\\\\\)<CR>

"
" ====== Tagbar
"
nnoremap <Leader>t :TagbarOpen fjc<CR>

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


"
" ======= ultisnips
"
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
set runtimepath+=~/.vim/bundle/ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"
" ======= EditorConfig
"
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"
" ======= vim-javascript
"
let g:javascript_enable_domhtmlcss=1

"
" ======= js-beautify
"
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<CR><CR>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<CR><CR>
let html_no_rendering = 1
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<CR><CR>


"
" ======= vim-indent-guides
"
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_start_level=4
let g:indent_guides_guide_size=1
map <F7> :IndentGuidesToggle<CR>
"
" ======= auto-pairs
"

" ========================= AUTOCMDs ======================================

" Automatically open the quickfix window on :make
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" ========================= INDENT HACKS ==================================

" Remove trailing whitespace
autocmd FileType * autocmd BufWritePre <buffer> :%s/\s\+$//e

" fix backspace
set backspace=indent,eol,start

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
au FileType make set noexpandtab shiftwidth=8 softtabstop=0

" ensure normal tabs in assembly files
" and set to NASM syntax highlighting
au FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm

" prevent # from going to start of line in python
au BufRead *.py inoremap # X<c-h>#

" Uncomment the following for permanent addition
au BufNewFile,BufRead *.c.* setf rtl

" Project-specific identation
" augroup ProjectSetup
  " au BufRead,BufEnter /path/to/project1/* set et sts=2 cindent cinoptions=..
  " au BufRead,BufEnter /path/to/project2/* set noet sts=4 cindent ...
" augroup END
