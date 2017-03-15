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
" ====== Syntastic
"
let g:syntastic_stl_format     = '%E{e:%e(%fe)}%B{|}%W{w:%w}'
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
" open errors with :lopen.
" Don't forget to update lightline for each checker added!

" python
let g:syntastic_python_checkers = ['pylint', 'python']
" some pylint error codes: http://pylint-messages.wikidot.com/all-codes
"
" C0111 Missing docstring
" C0103 Invalid  argument name
" F0401 Unable to import %s
let g:syntastic_python_pylint_args='--disable C0111,C0103,F0401'

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
"java
let g:syntastic_java_checkers = ['javac']
let g:syntastic_java_javac_autoload_maven_classpath = 1

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
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
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
" ======= lightline
"

" always on
set laststatus=2

let g:lightline = {
            \ 'active': {
            \   'right': [ [ 'syntastic', 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'filename': 'LightLineFilename',
            \ },
            \ 'component_expand': {
            \   'syntastic': 'SyntasticStatuslineFlag',
            \   'lineinfo': 'WordCount'
            \ },
            \ 'component_type': {
            \ 'syntastic': 'warning',
            \ }
\ }

function! LightLineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
    let fname = expand('%p:t')
    return fname
endfunction

function! WordCount()
    let s:old_status = v:statusmsg
    exe "silent normal g\<c-g>"
    let s:word_count = str2nr(split(v:statusmsg)[11])
    let v:statusmsg = s:old_status
    return s:word_count
endfunction

augroup AutoWordCount
	autocmd!
	autocmd BufWritePost * call s:word_count()
augroup END

augroup AutoSyntastic
	autocmd!
	autocmd BufWritePost *.py,*.php,*.js,*.c,*.cpp,*.java call s:syntastic()
augroup END

function! s:syntastic()
	SyntasticCheck
	call lightline#update()
endfunction

function! s:word_count()
	call WordCount()
	call lightline#update()
endfunction
