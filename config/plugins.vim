"
" ====== UndoTree
"
noremap <S-u> :UndotreeToggle<CR>
let g:gundo_close_on_revert=1

"
" ====== NerdTreeTabs
"
noremap <C-g> :NERDTreeTabsToggle<cr>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$',
                   \ '\.so$', '\.egg$', '^\.git$', '\.cmi', '\.cmo' ]
let NERDTreeDirArrows=0

"
" ====== vim-json
"
let g:vim_json_syntax_conceal = 0

"
" ====== Fugitive
"
noremap <silent> <Leader>gd :Gdiff<CR>
noremap <silent> <Leader>gb :Gblame<CR>

"
" ====== PyDocstring
"
noremap <C-i> :Pydocstring<CR>

"
" ====== auto-pairs
"
let g:AutoPairsOnlyWhitespace = 1

"
" ====== jedi-vim
"

if has('nvim')
    " using deoplete on nvim
    let g:jedi#completions_enabled = 0
else
    let g:jedi#popup_on_dot = 0
    " set completeopt+=menuone
endif
let g:jedi#max_doc_height = 50
" show call signatures in the command line
set noshowmode
let g:jedi#show_call_signatures = 2
" split the window to show the definition when pressing <Leader>d
let g:jedi#use_splits_not_buffers = "winwidth"
let g:jedi#show_call_signatures_delay = 50

" notes:
" rename variables with <Leader>r
" show documentation with K
" show usages of a name <Leader>n

"
" ====== vim-go
"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" no quickfix in preview
let g:go_list_type = ""
let g:go_fmt_fail_silently = 1
let g:go_addtags_transform = "snakecase"
" silent type info
function! s:custom_auto_type_info() abort
    silent! call go#tool#Info(1)
endfunction
augroup vim-go-custom
    autocmd!
    autocmd CursorHold *.go call s:custom_auto_type_info()
augroup end
"
" ====== LanguageClient
"

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['pyls'],
    \ 'cpp': ['clangd'],
    \ 'go': ['go-langserver'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

"
" ====== Deoplete options
"
if has('nvim')
    " uncomment to debug
    " let g:deoplete#enable_profile = 1
    " call deoplete#enable_logging('DEBUG', 'deoplete.log')
    " call deoplete#custom#source('jedi', 'debug_enabled', 1)

    let g:deoplete#enable_at_startup = 1

    let g:deoplete#source#attribute#is_silent=1

    " let g:deoplete#disable_auto_complete = 1
    " inoremap <silent><expr> <c-space> deoplete#mappings#manual_complete()

    " let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

    " set sources
    " let g:deoplete#sources = {}
    " let g:deoplete#sources.cpp = ['LanguageClient']
    " let g:deoplete#sources.python = ['LanguageClient']
    " let g:deoplete#sources.python3 = ['LanguageClient']
    " let g:deoplete#sources.rust = ['LanguageClient']
    " let g:deoplete#sources.go = ['LanguageClient']
    " let g:deoplete#sources.c = ['LanguageClient']
    " let g:deoplete#sources.vim = ['vim']

    " PHP
    let g:deoplete#sources#padawan#add_parentheses = 1
    " needed for echodoc to work if add_parentheses is 1
    let g:deoplete#skip_chars = ['$']

    let g:deoplete#sources = {}
    let g:deoplete#sources.php = ['padawan', 'ultisnips', 'tags', 'buffer']
endif

"
" ====== Neosnippet
"
if has('nvim')
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <expr><TAB>
    \ pumvisible() ? "\<C-n>" :
    \ neosnippet#expandable_or_jumpable() ?
    \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif
endif

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
if v:version >= 704
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
endif

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
noremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
noremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
noremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
noremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
noremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
noremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
noremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
noremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
noremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
noremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

"
" ====== ALE
"
" open errors with :lopen.
let g:ale_sign_warning = '!'
let g:ale_sign_error = 'x'
let g:ale_linters = {
            \ 'python': ['pylint', 'python'],
            \ 'php': ['php', 'phpcs', 'phpmd'],
            \ 'javascript': ['jshint'],
            \ 'go' : ['gometalinter'],
            \ 'java': ['javac'],
            \ 'c': ['make', 'clang'],
            \ 'cpp': ['make', 'clang++'],
            \ }
let g:ale_fixers = {
            \ 'python': ['isort'],
            \ 'go': ['goimports', 'gofmt'],
            \ }
let g:ale_set_highlights=0
let g:ale_lint_delay=0
let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed='never'

" if you want the actual text to be highlighted you need to set guibg!
highlight ALEErrorSign ctermbg=black ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
highlight ALEStyleErrorSign ctermbg=NONE ctermfg=LightRed
highlight ALEStyleWarningSign ctermbg=NONE ctermfg=LightYellow

" See ~/.vim/bundle/syntastic/syntax_checkers for options
" Don't forget to update lightline for each checker added!

" python
" some pylint error codes: http://pylint-messages.wikidot.com/all-codes
" C0111 Missing docstring
" C0103 Invalid  argument name
" F0401 Unable to import %s
let g:ale_python_flake8_executable=''
let g:ale_python_pylint_options='--disable C0111,C0103,F0401'

" go
let g:ale_go_gometalinter_options='--aggregate'

" c
let g:ale_c_gcc_options = '-std=c14 -Wall'
let g:ale_c_clang_options = '-std=c14 -Wall'
" cpp
let g:ale_cpp_gcc_options = '-std=c++14 -Wall'
let g:ale_cpp_clang_options = '-std=c++14 -Wall'

"
" ======= Lightline
"
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

function! WordCount() abort
    if v:version >= 800
        return wordcount()['words']
    else
        " not supported for older versions
        return -1
    endif
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
augroup ALEUpdateLightline
    autocmd!
    autocmd User ALELint call s:MaybeUpdateLightline()
augroup END

function! s:MaybeUpdateLightline() abort
  if exists('#lightline')
    call lightline#update()
  end
endfunction

set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['absolutepath', 'modified']],
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
