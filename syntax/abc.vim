" Vim syntax file
" Language: abc music notation
" Maintainer: Lee Savide <laughingman182@yahoo.com>
" License: http://apache.org/licenses/LICENSE-2.0.txt

if version < 600
    syn clear
elseif exists('b:current_syntax')
    finish
endif
syn sync clear

" Groups {{{
syn match abcOperator '[#@;*?<>$&.`/\\-]*' contained
syn match abcGroupOperator '[(){}\[\]]' contained

syn match abcCharacter '\<$[0-4]\>' contained
syn match abcCharacter '\<\\["%\[\]]\>' contained
syn match abcCharacter '\<\\[`'"^~/A-Za-z][A-Za-z]\>' contained
syn match abcCharacter '\<\\u\x\{4}\>' contained
syn match abcCharacter '\<&\h\w*;\>' contained
syn match abcCharacter '\<&#\d*;\>' contained
syn match abcCharacter '\<&#x\x\{4};\>' contained

syn region abcString start='"' skip='\\["%]' end='"' keepend oneline contained contains=abcCharEscape,abcFontSpecifier
syn match abcRest '\<[xz][1-9]*\d*/*\>' contained
syn match abcRest '\<[xz][1-9]*[0-9]*\%(/[1-9]*\d*\)\=\>' contained
syn match abcSpacer '\<[yY]\d*\.\d\+\>' contained
syn match abcNote '\<[=_^]\{,2}[a-gA-G][,']*[1-9]*\d*/*\>' contained
syn match abcNote '\<[=_^]\{,2}[a-gA-G][,']*[1-9]*\d*\%(/[1-9]*\d*\)\=\>' contained
syn match abcBar '\<[|\[\]]\%([1-9]\%([,-]\d\)*\)\=\>' contained
syn match abcBar '\<[:|][:|]\>' contained
syn match abcBar '\<:\+[|\[\]]\%([1-9]\%([,-]\d\)*\)\=\>' contained
syn region abcChord matchgroup=abcGroupOperator start='\[' end='\]' keepend transparent contained concealends
syn region abcGrace matchgroup=abcGroupOperator start='{' end='}' keepend oneline transparent contained concealends
syn region abcSlur matchgroup=abcGroupOperator start='(' end=')' keepend transparent contained 
syn match abcTuple '\<([1-9]\d*\%(:\d*\)\{,2}\>' contained
syn match abcMacro '\<~\w\{2,31}\>' contained
syn match abcSymbol '![a-zA-Z0-9.+<>]*[()]\=!' contained

syn match abcFileField '^[A-DF-IL-ORSUZmr]:.*' contained nextgroup=abcDirective,abcComment,abcContinueField skipnl skipwhite
syn match abcHeaderField '^[A-DF-IK-TVWXZmr]:.*$' contained nextgroup=abcDirective,abcComment,abcContinueField skipnl skipwhite
syn match abcBodyField '^[IK-NP-RTU-Wmrsw]:.*$' contained nextgroup=abcDirective,abcComment,abcContinueField skipnl skipwhite
syn match abcContinueField '^+:.$' contained nextgroup=abcDirective,abcComment,abcContinueField skipnl skipwhite
syn region abcInlineField start='\[[IK-NP-RUVmr]:' skip='\\["%\[\]]' end='\]' keepend oneline contained contains=abcCharacter

syn region abcTuneHeader matchgroup=abcHeaderField start='^X:' end='^K:.*$' keepend contained contains=abcHeaderField,abcDirective,abcComment
syn region abcTuneBody matchgroup=abcHeaderField start='^K:.*$' end='^\s*$' keepend contained contains=abcString,abcBar,abcNote,abcRest,abcSpacer,abcChord,abcSlur,abcGrace,abcTuple,abcSymbol,abcMacro,abcOperator,abcBodyField,abcInlineField,abcComment,abcDirective
syn region abcTune matchgroup=abcHeader start='^X:' matchgroup=NONE end='^\s*$' keepend contains=abcTuneBody

syn match abcComment '%.*$' extend
syn match abcDirective '%%.*$' extend
syn match abcSpecialComment '^%abc\%(-\d\.\d\)\=' contained
syn region abcFileHeader matchgroup=abcSpecialComment,abcComment,abcDirective,abcFileField start='\%^' end='^\s*$' keepend contains=abcSpecialComment,abcFileField,abcDirective,abcComment
" }}}
" Syncing {{{
syn sync linecont '\\'
syn sync ccomment abcComment,abcDirective
syn sync match abcTupleSync '\<([1-9]\d*\%(:\d*\)\{,2}\>'
syn sync match abcStringSync grouphere '"'
syn sync match abcStringSync groupthere '"'
syn sync match abcInlineFieldSync grouphere abcInlineField '\[[IK-NP-RUVmr]:'
syn sync match abcInlineFieldSync groupthere abcInlineField '\]'
syn sync match abcSlurSync grouphere abcSlur '('
syn sync match abcSlurSync groupthere abcSlur ')'
syn sync match abcBarSync '\<[|\[\]]\%([1-9]\%([,-]\d\)*\)\=\>'
syn sync match abcBarSync '\<[:|][:|]\>'
syn sync match abcBarSync '\<:\+[|\[\]]\%([1-9]\%([,-]\d\)*\)\=\>'
syn sync match abcSymbolSync grouphere '\<!'
syn sync match abcSymbolSync groupthere '!\>'
syn sync match abcHeaderSync grouphere abcHeader '^X:'
syn sync match abcHeaderSync groupthere abcHeader '^K:.*$'
syn sync match abcBodySync grouphere abcHeaderField '^K:*.$'
syn sync match abcBodySync groupthere NONE '^\s*$'
" }}}
" Highlighting {{{
if version >= 508 || !exists("did_abc_syn_inits")
  if version < 508
    let did_abc_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  hi Comment 
  "----
  hi Constant 
  hi String
  hi Character
  hi Number
  hi Boolean
  hi Float
  "----
  hi Special
  hi Tag
  hi SpecialChar
  hi Delimiter
  hi SpecialComment
  hi Debug
  "----
  hi Identifier
  hi Function
  "----
  hi Statement
  hi Conditional
  hi Repeat
  hi Label
  hi Operator
  hi Keyword
  hi Exception
  "----
  hi PreProc
  hi Include
  hi Define
  hi Macro
  hi PreCondit
  "----
  hi Type
  hi StorageClass
  hi Structure
  hi Typedef
  "----
  HiLink abcComment        Comment
  HiLink abcSpecialComment PreCondit
  HiLink abcDirective      PreProc
  HiLink abcCharacter      Character
  HiLink abcOperator       Operator
  HiLink abcGroupOperator  Operator
  HiLink abcString         String
  HiLink abcFileField      Type
  HiLink abcHeadField      Type
  HiLink abcBodyField      Special
  HiLink abcInlineField    Special
  HiLink abcBar            Delimiter
  HiLink abcTuple          Statement
  HiLink abcNote           Constant
  HiLink abcRest           Constant
  HiLink abcSpacer         Constant
  HiLink abcMacro          Macro

  delcommand HiLink
endif
" }}}
let b:current_syntax = 'abc'
" vim: ts=4
