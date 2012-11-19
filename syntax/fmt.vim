" Vim syntax file
" Language: abc format file
" Maintainer: Lee Savide <laughingman182@gmail.com>
" License: http://apache.org/licenses/LICENSE-2.0.txt
" Last Change: Nov 19 2012

" A format file contains lines giving the parameters values, format:
"
"	parameter [parameter list]
"In a format file, empty lines and lines starting with '%' are ignored.
if !exists('main_syntax')
    if version < 600
        syntax clear
    elseif has('b:current_syntax=1')
        finish
    endif
    let main_syntax = 'fmt'
endif
syn sync clear

syn case ignore
" PostScript syntax items {{{
syn match fmtHex "\<\x\{2,}\>"
" Integers
syn match fmtInteger "\<[+-]\=\d\+\>"
" Radix
syn match fmtRadix "\d\+#\x\+\>"
" Reals - upper and lower case e is allowed
syn match fmtFloat "[+-]\=\d\+\.\>" contained
syn match fmtFloat "[+-]\=\d\+\.\d*\(e[+-]\=\d\+\)\=\>" contained
syn match fmtFloat "[+-]\=\.\d\+\(e[+-]\=\d\+\)\=\>" contained
syn match fmtFloat "[+-]\=\d\+e[+-]\=\d\+\>" contained
syn cluster fmtNumber contains=fmtInteger,fmtRadix,fmtFloat
" }}}
syn case match

syn match fmtSpecialChar /\$[0-4]/ contained
syn match fmtSpecialChar /&#\=[:alnum:]]*;/ contained
syn match fmtSpecialChar /\\.\{,2}/ contained

syn match fmtString /"[^"]*"/hs=s+1,he=e-1 contained
syn match fmtOperator /[(){}\[\]<>:;',*+=_^#@$&!?|\/\\-]/ contained

syn keyword fmtBoolean true false on off yes no
syn keyword fmtSize in cm mm pt
syn keyword fmtEncoding utf-8 us-ascii iso-8859-1 iso-8859-2 iso-8859-3 iso-8859-4 iso-8859-5 iso-8859-6 iso-8859-7 iso-8859-8 iso-8859-9 iso-8859-10
syn keyword fmtLock contained lock
syn keyword fmtFontEncoding contained utf-8 us-ascii native
" Boolean directives
syn keyword fmtDirective contained abc2pscompat autoclef breakoneoln 






" vim:ts=4:sw=4:fdm=marker:fdc=3
