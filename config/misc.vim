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
