" Vim syntax file
" Language: abc music notation
" Maintainer: Lee Savide <laughingman182@yahoo.com>
" License: http://apache.org/licenses/LICENSE-2.0.txt

if version < 600
    syn clear
    syn sync clear
elseif exists('b:current_syntax')
    finish
endif

syn match abcOperator '[<>$&.`/\\-]' contained
syn match abcGroupOperator '[(){}\[\]]' contained
syn match abcCharEscape '\<\\\P\{2}\>' contained
syn match abcCharEscape '\<\\u\x\{4}\>' contained
syn match abcCharEscape '\<&\w\{2,};\>' contained
syn match abcCharEscape '\<&#\x\{4};\>' contained
syn region abcString start='"' skip='\\["%]' end='"' keepend oneline contained contains=abcCharEscape,abcFontSpecifier
syn match abcRest '\<[xz][1-9]*\d*/*\>' contained
syn match abcRest '\<[xz][1-9]*[0-9]*\%(/[1-9]*\d*\)\=\>' contained
syn match abcSpacer '\<[yY]\d*\.\d\+\>' contained
syn match abcNote '\<[=_^]\{,2}[a-gA-G][,']*[1-9]*\d*/*\>' contained
syn match abcNote '\<[=_^]\{,2}[a-gA-G][,']*[1-9]*\d*\%(/[1-9]*\d*\)\=\>' contained
syn match abcBar '\<[|\[\]]\%([1-9]\%([,-]\d\)*\)\=\>' contained
syn match abcBar '\<[:|][:|]\>' contained
syn match abcBar '\<:\+[|\[\]]\%([1-9]\%([,-]\d\)*\)\=\>' contained
syn region abcChord matchgroup=abcGroupOperator start='\[' end='\]' keepend oneline contained contains=abcOperator,abcNote,abcRest
syn region abcGrace matchgroup=abcGroupOperator start='{' end='}' keepend oneline contained contains=abcOperator,abcNote,abcRest
syn region abcSlur matchgroup=abcGroupOperator start='(' end=')' keepend transparent contained 
syn match abcTuple '\<([1-9]\+\%(:\=\d*\)\{,2}\>' contained
syn match abcMacro '\<~\w\{2,31}\>' contained
syn match abcSymbol '![a-zA-Z0-9.+<>]*[()]\=!' contained
syn match abcFileField '^[A-DF-IL-ORSUZmr]:.*' contained nextgroup=abcContinueField skipnl
syn match abcHeaderField '^[A-DF-IK-TVWXZmr]:.*$' contained nextgroup=abcContinueField skipnl
syn match abcBodyField '^[IK-NP-RTU-Wmrsw]:.*$' contained nextgroup=abcContinueField skipnl
syn match abcContinueField '^+:.$' contained nextgroup=abcContinueField skipnl
syn region abcInlineField start='\[[IK-NP-RUVmr]:' skip='\\[%\]]' end='\]' keepend oneline contained contains=abcCharEscape,abcFontSpecifier
syn region abcHeader matchgroup=abcHeaderField start='^X:' end='^K:.*$' keepend contained contains=abcHeaderField,abcDirective,abcComment
syn region abcTune matchgroup=abcHeader start='^X:' matchgroup=NONE end='^\s*$' keepend contains=abcString,abcBar,abcNote,abcRest,abcSpacer,abcBodyField,abcInlineField,abcChord,abcSlur,abcGrace,abcTuple,abcSymbol,abcMacro,abcOperator,abcComment
syn match abcComment '%.*$'
syn match abcDirective '%%.*$'
syn match abcSpecialComment '\%^%abc\%(-\d\.\d\)\=' contained
syn region abcFileHeader start='\%^' end='^\s*$' fold keepend contains=abcSpecialComment,abcFileField,abcDirective,abcComment

syn sync match abcInlineFieldSync grouphere abcInlineField '\[[IK-NP-RUVmr]:'
syn sync match abcInlineFieldSync groupthere abcInlineField '\]'
syn sync match abcSlurSync grouphere abcSlur '('
syn sync match abcSlurSync groupthere abcSlur ')'
syn sync match abcTupletSync '\<([1-9]\+\%(:\=\d*\)\{,2}\>'
syn sync match abcBarSync '\<[|\[\]]\%([1-9]\%([,-]\d\)*\)\=\>'
syn sync match abcBarSync '\<[:|][:|]\>'
syn sync match abcBarSync '\<:\+[|\[\]]\%([1-9]\%([,-]\d\)*\)\=\>'
syn sync match abcSymbolSync grouphere '!'
syn sync match abcSymbolSync groupthere '!'
syn sync match abcStringSync grouphere '"'
syn sync match abcStringSync groupthere '"'
syn sync match abcHeaderSync grouphere abcHeader '^X:'
syn sync match abcHeaderSync groupthere abcHeader '^K:.*$'
syn sync match abcBodySync grouphere abcHeaderField '^K:*.$'
syn sync match abcBodySync groupthere NONE '^\s*$'

if version >= 508 || !exists("did_abc_syn_inits")
  if version < 508
    let did_abc_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink abcComment         Comment
  HiLink abcDirective       PreProc
  HiLink abcCharEscape      Character
  HiLink abcString          String
  HiLink abcFileField       Type
  HiLink abcHeadField       Type
  HiLink abcBodyField       Special
  HiLink abcBar             Delimiter
  HiLink abcTuple           Statement
  HiLink abcGroupOperator   Operator
  HiLink abcOperator        Operator
  HiLink abcChord           Identifier
  HiLink abcNote            Constant
  HiLink abcRest            Constant
  HiLink abcSpacer          Constant
  HiLink abcMacro           Macro

  delcommand HiLink
endif

let b:current_syntax = 'abc'
" vim: ts=4
