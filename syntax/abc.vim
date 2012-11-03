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
syn match abcOperator /[#@;*?<>$&.`/\\-]*/ contained
syn match abcGroupStart /[({\[]/ contained
syn match abcGroupEnd /[)}\]]/ contained

syn match abcEscape /$[0-4]/ contained
syn match abcEscape /\\["%\[\]]/ contained
syn match abcEscape /\\[`'"^~/A-Za-z][A-Za-z]/ contained
syn match abcEscape /\\u\x\{4}/ contained
syn match abcEscape /&\h\w*;/ contained
syn match abcEscape /&#\d*;/ contained
syn match abcEscape /&#x\x\{4};/ contained

syn match abcString /"[^"]*"/ contained contains=abcCharacter
syn match abcRest /[xz][1-9]*\d*\/*/ contained
syn match abcRest /[xz][1-9]*\d*\%(\/[1-9]*\d*\)\=/ contained
syn match abcSpacer /[yY]\d*\.\d\+/ contained
syn match abcNote /[=_^]\{,2}[a-gA-G][,']*[1-9]*\d*\/*/ contained
syn match abcNote /[=_^]\{,2}[a-gA-G][,']*[1-9]*\d*\%(\/[1-9]*\d*\)\=/ contained
syn match abcBar /[:|][:|]/ contained
syn match abcBar /[|\[\]]\%([1-9]\%([,-]\d\)*\)\=/ contained
syn match abcBar /:\+[|\[\]]\%([1-9]\%([,-]\d\)*\)\=/ contained
syn match abcTuple /([1-9]\d*\%(:\d*\)\{,2}/ contained
syn match abcMacro /~\w\{2,31}/ contained
syn match abcSymbol /![<>.+[:alnum:]]*[()]\=!/ contained

syn match abcFieldIdentifier /^+:/ contained
syn match abcFieldIdentifier /^\a:/ contained
syn match abcFieldIdentifier /\[\a:/ contained

syn match abcFieldContents /:[^%]*$/ms=s+2,hs=s+2,he=e contained
syn match abcInlineContents /:[^%\]]*\]/ms=s+1,me=e-1,hs=s+1,he=e-1 contains=abcCharacter

syn match abcFileField /^[A-DF-IL-ORSUZmr]:/ contains=abcFieldContents,abcDirective,abcComment contained nextgroup=abcContinueField skipnl
syn match abcHeaderField /^[A-DF-IK-TVWXZmr]:/ contains=abcFieldContents,abcDirective,abcComment contained nextgroup=abcContinueField skipnl
syn match abcBodyField /^[IK-NP-RTU-Wmrsw]:/ contains=abcFieldContents,abcDirective,abcComment contained nextgroup=abcContinueField skipnl
syn match abcContinueField /^+:/ contained contains=abcFieldContents,abcDirective,abcComment nextgroup=abcContinueField skipnl

syn region abcInlineField matchgroup=abcFieldIdentifier start=/\[[IK-NP-RUVmr]:/ skip=/\\["%\[\]]/ end=/\]/ keepend contained contains=abcInlineContents

syn cluster abcCode contains=abcString,abcRest,abcSpacer,abcNote,abcBar,abcTuple,abcMacro,abcSymbol,abcInlineField,abcOperator

syn region abcChord matchgroup=abcGroupStart start=/\[/ matchgroup=abcGroupEnd end=/\]/ contains=@abcCode keepend contained concealends
syn region abcGrace matchgroup=abcGroupStart start=/{/ matchgroup=abcGroupEnd end=/}/ contains=@abcCode keepend contained concealends
syn region abcSlur matchgroup=abcGroupStart start=/(/ matchgroup=abcGroupEnd end=/)/ contains=@abcCode keepend contained

syn region abcTuneHeader matchgroup=abcHeaderField start=/^X:/ end=/^K:.*$/ keepend contained contains=abcHeaderField,abcDirective,abcComment
syn region abcTune matchgroup=abcHeader start=/^X:/ matchgroup=NONE end=/^\s*$/ keepend contains=@abcCode,abcChord,abcSlur,abcGrace,,abcBodyField,abcComment,abcDirective

syn match abcComment /%.*$/ extend
syn match abcDirective /%%.*$/ extend
syn match abcSpecialComment /^%abc\%(-\d\.\d\)\=/ contained
syn region abcFileHeader matchgroup=abcSpecialComment start=/\%^\%(%abc\%(-[1-9]\.\d\)\=\)\=/ matchgroup=NONE end=/^\s*$/ keepend contains=abcFileField,abcDirective,abcComment
" }}}
" Syncing {{{
syn sync match abcTuneSync grouphere abcTuneHeader /^X:/
syn sync match abcTuneSync groupthere NONE /^\s*$/

syn sync match abcTuneHeaderSync grouphere abcTuneHeader /^X:/
syn sync match abcTuneHeaderSync groupthere abcTuneHeader /^K:.*$/

syn sync match abcTuneBodySync grouphere abcTuneHeader /^K:*.$/
syn sync match abcTuneBodySync groupthere NONE /^\s*$/

syn sync match abcFileHeaderSync grouphere abcFileHeader /\%^/
syn sync match abcFileHeaderSync groupthere NONE /^\s*$/
syn sync match abcInlineFieldSync grouphere abcInlineField /\[[IK-NP-RUVmr]:/
syn sync match abcInlineFieldSync groupthere abcInlineField /\]/

syn sync match abcTupleSync /([1-9]\d*\%(:\d*\)\{,2}/
syn sync match abcSlurSync grouphere abcSlur /(/
syn sync match abcSlurSync groupthere abcSlur /)/
syn sync match abcGraceSync grouphere abcGrace /{/
syn sync match abcGraceSync groupthere abcGrace /}/
syn sync match abcBracketSync grouphere abcChord /\[/
syn sync match abcBracketSync grouphere abcInlineField /\[\a:/
syn sync match abcBracketSync groupthere abcChord /\]/
syn sync match abcBracketSync groupthere abcInlineField /\]/

syn sync match abcStringSync /"[^"]*"/
syn sync match abcBarSync /[:|][:|]/
syn sync match abcBarSync /[|\[\]]\%([1-9]\%([,-]\d\)*\)\=/
syn sync match abcBarSync /:\+[|\[\]]\%([1-9]\%([,-]\d\)*\)\=/
syn sync match abcNoteSync /[=_^]\{,2}[a-gA-G][,']*[1-9]*\d*/ contained

syn sync linecont /\\/
syn sync ccomment abcComment
" }}}
" Highlighting {{{
if &background == 'light'
    hi String guibg=bg guifg=magenta gui=none
    hi Comment guibg=bg guifg=ForestGreen gui=italic
    hi SpecialComment guibg=bg guifg=HotPink gui=none
    hi Constant guibg=bg guifg=orange gui=none
    hi Error guibg=red guifg=white gui=undercurl
    hi Debug guibg=bg guifg=#d3a901 gui=undercurl
    hi Identifier guibg=bg guifg=#0e7c6b gui=none
    hi Ignore guibg=bg guifg=bg gui=none
    hi PreProc guibg=bg guifg=#a33243 gui=none
    hi Special guibg=bg guifg=#844631 gui=none
    hi Statement guibg=bg guifg=#2239a8 gui=bold
    hi Todo guibg=#fedc56 guifg=#512b1e gui=bold
    hi Type guibg=bg guifg=#1d318d gui=bold
else
    hi String guibg=bg guifg=magenta gui=none
    hi Comment guibg=bg guifg=#77be21 gui=italic
    hi SpecialComment guibg=bg guifg=#ff66cc gui=none
    hi Constant guibg=bg guifg=#dc8511 gui=none
    hi Error guibg=red guifg=white gui=undercurl
    hi Debug guibg=yellow guifg=red gui=undercurl
    hi Identifier guibg=bg guifg=#16c9ae gui=none
    hi Ignore guibg=bg guifg=bg gui=none
    hi PreProc guibg=bg guifg=#e09ea8 gui=none
    hi Special guibg=bg guifg=#d3a901 gui=none
    hi Statement guibg=bg guifg=#a7b4ed gui=bold
    hi Todo guibg=#fedc56 guifg=#512b1e gui=bold
    hi Type guibg=bg guifg=#95a4ea gui=bold
endif
if version >= 508 || !exists("did_abc_syn_inits")
  if version < 508
    let did_abc_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink abcComment         Comment
  HiLink abcSpecialComment  SpecialComment
  HiLink abcDirective       PreProc
  HiLink abcEscape          SpecialChar
  HiLink abcOperator        Operator
  HiLink abcGroupStart      Operator
  HiLink abcGroupEnd        Operator
  HiLink abcFieldIdentifier Identifier
  HiLink abcString          String
  HiLink abcFieldContents   String
  HiLink abcInlineContents  String
  HiLink abcInlineField     Special
  HiLink abcBar             Delimiter
  HiLink abcTuple           Statement
  HiLink abcNote            Constant
  HiLink abcRest            Constant
  HiLink abcSpacer          Constant
  HiLink abcMacro           Macro

  delcommand HiLink
endif
" }}}
let b:current_syntax = 'abc'
" vim: ts=4
