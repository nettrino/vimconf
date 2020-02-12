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
" ====== coc-nvim
"
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
"set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"
" ====== vim-test
"
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

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
let g:go_info_mode='guru'
" " silent type info
" function! s:custom_auto_type_info() abort
    " silent! call go#tool#Info(1)
" endfunction
" augroup vim-go-custom
    " autocmd!
    " autocmd CursorHold *.go call s:custom_auto_type_info()
" augroup end

"
" ====== Markdown Composer
"
let g:markdown_composer_open_browser=0
" preview with ,md
noremap <Leader>md : ComposerStart<cr> :ComposerOpen<cr>

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
            \ 'python': ['pyls', 'pylint', 'python'],
            \ 'php': ['php', 'phpcs', 'phpmd'],
            \ 'javascript': ['jshint'],
            \ 'go' : ['golangcli-lint', 'gometalinter', 'golint'],
            \ 'c': ['make', 'clang'],
            \ 'cpp': ['make', 'clang++'],
            \ 'sh': ['language_server'],
            \ }
let g:ale_fixers = {
            \ 'python': ['isort'],
            \ 'go': ['goimports', 'gofmt'],
            \ }
let g:ale_completion_enabled = 1
let g:ale_set_highlights=0
let g:ale_lint_delay=0
let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed='never'
let g:ale_set_balloons=1
let g:ale_hover_to_preview=0

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
