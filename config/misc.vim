" ========================= INDENT & OTHER HACKS ==============================

" This file is the last that will be called before users' scripts so any
" attempt to salvage the situation and make a correction is be made here

augroup UglyHacks
    autocmd!
    " in makefiles, don't expand tabs to spaces, since actual tab characters
    " are needed, and have indentation at 8 chars to be sure that all indents
    " are tabs (despite the mappings later):
    autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

    " ensure normal tabs in assembly files and set to NASM syntax highlighting
    autocmd FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm

    " prevent # from going to start of line in python
    autocmd BufRead *.py inoremap # X<c-h>#

    " rtl
    autocmd BufNewFile,BufRead *.c.* set filetype=rtl

    " bnf
    autocmd BufNewFile,BufRead *.bnf set filetype=bnf

    " antlr
    autocmd BufRead,BufNewFile *.g3 set filetype=antlr3
    autocmd BufRead,BufNewFile *.g4 set filetype=antlr4

    " Fix spell check for tex
    autocmd FileType plaintex,tex,latex syntax spell toplevel

    " Xdebug syntax
    autocmd BufNewFile,BufRead *.xt  set filetype=xt

    " SMT solvers
    autocmd BufNewFile,BufRead *.smt* set nowrap filetype=smt

    " don't hide special characters in markdown
    autocmd BufNewFile,BufRead *.md set filetype=text
augroup END

" hack because of color issues in windows
if (has('win32') || has ('win64'))
    let loaded_matchparen = 0
endif
