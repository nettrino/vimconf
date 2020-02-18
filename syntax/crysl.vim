" Vim syntax file
" Heavily based on yara.vim syntax file
" Language:         CrySL
" Maintainer:       Theofilos Petsios
" Last Change:      February 18, 2020

" Quit when a syntax file was already loaded	{{{
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif
"}}}

" syn match cryslNonTerminal "<\a\w*>" contained
syn region cryslProduction start="^\a" end="::="me=e-3 contained
syn match cryslOr "|" contained
syn match cryslSeperator ":=" contained
syntax keyword cryslKeyword SPEC OBJECTS EVENTS ORDER CONSTRAINTS REQUIRES ENSURES

syn match cryslEvent '[a-zA-Z0-9]\+:'
syn match cryslEventCombination '[a-zA-Z0-9]\+\s:=.*;'

" Strings
syntax region cryslStringText start=/"/ end=/"/ skip=/\(\\\\\|\\"\)/ contains=cryslStringTextFormat
syntax match cryslStringTextFormat /\(\\"\|\\\\\|\\t\|\\n\|\\x[0-9a-fA-F]\{2\}\)/ contained
syntax match cryslStringHex /{\([-0-9a-fA-F \t()\[\]|?]\|\n\)\+[-0-9a-fA-F()\[\]|?]\([-0-9a-fA-F \t()\[\]|?]\|\n\)\+}/ contains=cryslStringHexFormat
syntax match cryslStringHexFormat /[-()\[\]|?]/ contained
syntax region cryslStringRegex start=/\// end=/\// skip=/\(\\\\\|\\\/\)/
syntax match cryslStringRegexModifiers /\/\@<=[is]\+\>/

" Numbers
syntax match cryslNumberInt /\<\([0-9]\+\|0x[0-9a-fA-F]\+\)\>/
syntax match cryslNumberFloat /\<[0-9]\+\.[0-9]\+\>/
syntax match cryslNumberSize /\<\([0-9]\+\|0x[0-9a-fA-F]\+\)\(MB\|KB\)\>/

" Comments
syntax match cryslCommentInline /\/\/.*/
syntax region cryslCommentBlock start=/\/\*/ end=/\*\//

highlight default link cryslKeyword Keyword
highlight default link cryslOr Delimiter
highlight default link cryslSeperator Delimiter
highlight default link cryslStringText String
highlight default link cryslStringTextFormat Special
highlight default link cryslStringHex String
highlight default link cryslStringHexFormat Special
highlight default link cryslStringRegex String
highlight default link cryslStringRegexModifiers Special
highlight default link cryslNumberInt Number
highlight default link cryslNumberFloat Number
highlight default link cryslNumberSize Number
highlight default link cryslCommentInline Comment
highlight default link cryslCommentBlock Comment
hi def link cryslEvent Identifier
hi cryslEventCombination guifg=cyan ctermfg=cyan
