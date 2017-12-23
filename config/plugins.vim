"
" ====== UndoTree
"
nnoremap <S-u> :UndotreeToggle<CR>
let g:gundo_close_on_revert=1


"
" ====== NerdTreeTabs
"
nnoremap <C-g> :NERDTreeTabsToggle<cr>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                   \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo' ]
let NERDTreeDirArrows=0

"
" ====== Fugitive
"
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>

"
" ====== PyDocstring
"
nnoremap <C-i> :Pydocstring<CR>

"
" ====== NerdCommenter
"
" Go into visual mode and then type ,cc or cn to comment and ,cu to uncomment
" Put a space around comment markers
let g:NERDSpaceDelims = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'smt': { 'left': ';','right': '' } }

"
" ====== delimitMate
"

" Python stuff
let g:delimitMate_nesting_quotes = ['"','`']
au FileType python let b:delimitMate_nesting_quotes = ['"']
au FileType python let b:delimitMate_expand_cr = 0

let delimitMate_smart_matchpairs = '\%(\w\|\!\|[£$]\|[^[:space:][:punct:]]\)'
let delimitMate_smart_quotes = 1
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
" Disable F1 for tabar
if exists("g:tagbar_map_help")
    unlet g:tagbar_map_help
endif
let g:tagbar_map_help='?'

"
" ======= ultisnips
"
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let ultisnips_dir=expand(g:vimroot . "/bundle/ultisnips")
if !isdirectory(ultisnips_dir)
    call mkdir(ultisnips_dir, "p", 0755)
endif
set runtimepath+=ultisnips_dir
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
map <F4> :IndentGuidesToggle<CR>


"
" ======= vim-javacomplete2
"
autocmd FileType java setlocal omnifunc=javacomplete#Complete

"
" ======= vim-latex
"

" No folding please
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments=""
let g:Tex_FoldedMisc=""

"
" ======= vim-rooter
"
let g:rooter_manual_only = 1
let g:rooter_silent_chdir = 1
let g:rooter_chdir_makefile = 1

"
" ====== colorizer
"
let g:colorizer_maxline = 1000

"
" ======= cscope
"
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>

" d: Find functions called by this function
noremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

"
" ====== ALE
"
" open errors with :lopen.
let g:ale_sign_warning = '!'
let g:ale_sign_error = 'x'
let g:ale_fixers = {
    \ 'python': ['pylint', 'python'],
    \ 'php': ['php', 'phpcs', 'phpmd'],
    \ 'javascript': ['jshint'],
    \ 'java': ['javac'],
    \ 'c': ['make', 'clang'],
    \ 'cpp': ['make', 'clang++'],
    \ }
let g:ale_python_flake8_executable=''
let g:ale_set_highlights=0
let g:ale_lint_delay=200
let g:ale_lint_on_enter=0
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed='never'

" See ~/.vim/bundle/syntastic/syntax_checkers for options
" Don't forget to update lightline for each checker added!

" python
" some pylint error codes: http://pylint-messages.wikidot.com/all-codes
" C0111 Missing docstring
" C0103 Invalid  argument name
" F0401 Unable to import %s
let g:ale_python_pylint_options='--disable C0111,C0103,F0401'

"c
let g:ale_c_gcc_options = '-std=c14 -Wall'
let g:ale_c_clang_options = '-std=c14 -Wall'
"cpp
let g:ale_cpp_gcc_options = '-std=c++14 -Wall'
let g:ale_cpp_clang_options = '-std=c++14 -Wall'

"
" ======= Lightline
"
set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['filename', 'modified']],
    \   'right': [
    \       ['lineinfo'],
    \       ['percent'],
    \       ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']
    \    ]
    \ },
    \ 'component_expand': {
    \   'linter_warnings': 'LightlineLinterWarnings',
    \   'linter_errors': 'LightlineLinterErrors',
    \   'lineinfo': 'WordCount'
    \ },
    \ 'component_type': {
    \   'readonly': 'error',
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error'
    \ },
    \ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d !', all_non_errors)
endfunction
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:all_errors == 0 ? '' : printf('%d x', all_errors)
endfunction

function! WordCount()
    return wordcount()['words']
endfunction

augroup AutoWordCount
    autocmd!
    autocmd BufWritePost * call s:word_count()
augroup END

function! s:word_count()
    call WordCount()
    call lightline#update()
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
autocmd User ALELint call s:MaybeUpdateLightline()
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction
