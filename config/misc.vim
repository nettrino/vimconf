" ========================= INDENT HACKS ==================================

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
au FileType make set noexpandtab shiftwidth=8 softtabstop=0

" ensure normal tabs in assembly files
" and set to NASM syntax highlighting
au FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm

" prevent # from going to start of line in python
au BufRead *.py inoremap # X<c-h>#

" rtl
au BufNewFile,BufRead *.c.* setf rtl

"bnf
au BufNewFile,BufRead *.bnf set ft=bnf

"antlr
au BufRead,BufNewFile *.g3 set filetype=antlr3
au BufRead,BufNewFile *.g4 set filetype=antlr4

" Fix spell check for tex
au FileType plaintex,tex,latex syntax spell toplevel

" Xdebug syntax
au BufNewFile,BufRead *.xt  setf xt

au BufNewFile,BufRead *.smt* set nowrap filetype=smt

" Uncomment the following for permanent addition
" Project-specific identation
" augroup ProjectSetup
  " au BufRead,BufEnter /path/to/project1/* set et sts=2 cindent cinoptions=..
  " au BufRead,BufEnter /path/to/project2/* set noet sts=4 cindent ...
" augroup END

" hack because of color issues in windows
 if (has('win32') || has ('win64'))
     let loaded_matchparen = 0
 endif
