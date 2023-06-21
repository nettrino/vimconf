" Vim syntax file
" Language:         Con4m
" Maintainer:       Theofilos Petsios
" Last Change:      January 17, 2023

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax keyword con4mOperatorKeyword if elif else return break continue callback export var

" Indentifier
syntax match con4mIdentifier '\v<[a-zA-Z0-9_]+>'
syntax match con4mQualifiedClassName '\v<([a-zA-Z0-9_]+\.)*[A-Z0-9][a-zA-Z0-9_]+>'
syntax keyword con4mPrimitiveType bool int string float void typespec list dict tuple func

" Literals
syntax region con4mString start='"' end='"' skip='\v(\\\\|\\")' oneline
syntax match con4mInteger '\v<\d+(\^\d+)?>'
syntax keyword con4mBoolean true false True False
syntax keyword con4mOther '<<.*>>'

" Comments
syntax match con4mCommentInline /\/\/.*/
syntax match con4mCommentInline /#.*$/
syntax region con4mCommentBlock start=/\/\*/ end=/\*\//
syntax region con4mStringMultiline start=+[bB]\="""+ skip=+\\"+ end=+"""+ keepend

" Default Highlighting
highlight default link con4mConfigKeyword Keyword
highlight default link con4mOperatorKeyword Operator
highlight default link con4mIdentifier Identifier
highlight default link con4mQualifiedClassName Type
highlight default link con4mPrimitiveType Type
highlight default link con4mString String
highlight default link con4mInteger Number
highlight default link con4mBoolean Constant
highlight default link con4mOther Constant
highlight default link con4mCommentInline Comment
highlight default link con4mStringMultiline String
highlight default link con4mCommentBlock Comment

let b:current_syntax = 'conform'
