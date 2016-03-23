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

"Java
function! GetJavaIndent_improved()
    let theIndent = GetJavaIndent()
    let lnum = prevnonblank(v:lnum - 1)
    let line = getline(lnum)
    if line =~ '^\s*@.*$'
        let theIndent = indent(lnum)
    endif

    return theIndent
endfunction
setlocal indentexpr=GetJavaIndent_improved()

" prevent # from going to start of line in python
au BufRead *.py inoremap # X<c-h>#

au BufNewFile,BufRead *.c.* setf rtl

"bnf
au BufNewFile,BufRead *.bnf set ft=bnf

" Uncomment the following for permanent addition
" Project-specific identation
" augroup ProjectSetup
  " au BufRead,BufEnter /path/to/project1/* set et sts=2 cindent cinoptions=..
  " au BufRead,BufEnter /path/to/project2/* set noet sts=4 cindent ...
" augroup END
