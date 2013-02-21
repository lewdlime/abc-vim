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
" Characters
syn case ignore
syn keyword abcTodo contained todo volatile fixme
syn case match
" Special Characters & Comments {{{
syn match abcSpecialChar /$[0-4]/ contained
syn match abcSpecialChar /\\.\{,2}/ contained
syn match abcSpecialChar /\\u\x\{4}/ contained
syn match abcSpecialChar /\\U\x\{8}/ contained
syn match abcSpecialChar /&#\=\d*;/ contained
syn match abcSpecialChar /&\I\i*;/ contained

syn match abcComment /%.*$/ extend
syn match abcSpecialComment /^%abc\%(-\d\.\d\)\=/ contained
syn match abcDirective /%%.*$/ extend
" }}}
" Fields {{{
syn match abcFieldIdentifier /^[\a+]:/ contained
syn match abcInlineIdentifier /\[\a:/ contained
syn region abcInlineField matchgroup=abcInlineIdentifier start=/\[[IK-NP-RUVmr]:/ skip=/[^%\]]/ matchgroup=abcOperator end=/\]/ keepend contained contains=abcSpecialChar

syn match abcContinueField /^+:.*$/ contained contains=abcFieldIdentifier,abcSpecialChar nextgroup=abcContinueField,abcComment,abcDirective skipnl
syn match abcBodyField excludenl /^[IK-NP-RTU-Wmrsw]:.*$/ contained contains=abcFieldIdentifier,abcSpecialChar nextgroup=abcContinueField,abcComment,abcDirective skipwhite skipnl
syn match abcFileField excludenl /^[A-DF-IL-ORSUZmr]:.*$/ contained contains=abcFieldIdentifier,abcSpecialChar nextgroup=abcContinueField,abcComment,abcDirective skipwhite skipnl
syn match abcHeaderField excludenl /^[A-DF-IK-XZmr]:.*$/ contained contains=abcFieldIdentifier,abcSpecialChar nextgroup=abcContinueField,abcComment,abcDirective skipwhite skipnl
" }}}
" Code {{{
syn match abcOperator '[()#$&-/;-@^-`{}~\\]' contained
syn match abcString /"[^"%\r\n]*"/ contained contains=abcSpecialChar
syn match abcRest /[xzXZ][1-9]*\d*\/*/ contained
syn match abcRest /[xz][1-9]*\d*\%(\/[1-9]*\d*\)\=/ contained
syn match abcSpacer /[yY]\(\d*\.\d*\)\=/ contained
syn match abcNote /[=_^]\{,2}[a-gA-G][,']*[1-9]*\d*\/*/ contained
syn match abcNote /[=_^]\{,2}[a-gA-G][,']*[1-9]*\d*\%(\/[1-9]*\d*\)\=/ contained
syn match abcBar /[|\[\]]/ contained
syn match abcBar /[:|]\{,1}/ contained
syn match abcBar /[|\[\]]\%([1-9]\%([,-]\d*\)*\)\=/ contained
syn match abcBar /:*[|\[\]]\%([1-9]\%([,-]\d*\)*\)\=/ contained
syn match abcTuple /([1-9]\d*\%(:\d*\)\{,2}/ contained
syn match abcSymbol /![a-zA-Z.-]*[()]\=!/ contained
syn match abcSymbol /![.+]!/ contained
syn match abcSymbol /![<>][()]\=!/ contained
syn match abcSymbol /[~HLMOPSTuv]/ contained
syn match abcMacro /\~\I\i\{1,31}/ contained
syn region abcChord matchgroup=abcOperator start=/\[\(\a:\|\d*\|:*\)\@<!/ skip=/[^%\]]*/ end=/\]/ keepend contained
syn region abcGrace matchgroup=abcOperator start=/{\/\=/ skip=/[^}\r\n]*/ end=/}/ keepend contained
syn region abcSlur matchgroup=abcOperator start=/(\(\d*\)\@<!/ skip=/\\)/ end=/)/ keepend contained

syn cluster abcCode contains=abcOperator,abcString,abcRest,abcSpacer,abcNote,abcBar,abcTuple,abcSymbol,abcMacro,abcChord,abcGrace,abcSlur,abcComment,abcDirective
" }}}
" Toplevel {{{
syn region abcTuneHeader matchgroup=abcHeaderField start=/^X:/ end=/^K:.*$/ keepend contains=abcHeaderField,abcDirective,abcComment,abcTypeset
syn region abcTuneBody start=/\%(\_^X:.*\_$\)\(\%(\_^\s*\_$\)*\)\@<!\%(\_^K:.*\_$\)\zs\1\@<!/ end=/^\s*$/ keepend transparent contains=@abcCode,abcInlineField,abcBodyField
syn region abcTune matchgroup=abcTuneHeader start=/^X:/ matchgroup=NONE end=/^\s*$/ keepend contains=@abcCode,abcInlineField,abcBodyField

syn region abcTypeset matchgroup=abcDirective start=/%%begin\(\I\i*\)/ end=/%%end\z1/ contains=abcSpecialChar transparent
syn region abcFileHeader matchgroup=abcSpecialComment start=/\%^\%(%abc\%(-[1-9]\.\d\)\=\)\=/ matchgroup=NONE end=/^\s*$/ keepend contains=abcFileField,abcDirective,abcComment,abcTypeset
" }}}
" }}}
" Syncing {{{
if has('b:abc_sync' == 1)
    exe "syn sync match abcTypesetSync grouphere abcTypeset /%%begin\I\i*/"
    exe "syn sync match abcTypesetSync groupthere abcTypeset /%%end\I\i*/"
    exe "syn sync linecont /\\$/"
    exe "syn sync match abcChordSync grouphere abcChord /\[\(\a:\|\d*\|:*\)\@<!/"
    exe "syn sync match abcChordSync groupthere abcChord /\]/"
    exe "syn sync match abcGraceSync grouphere abcGrace /{\/\=/"
    exe "syn sync match abcGraceSync groupthere abcGrace /}/"
    exe "syn sync match abcSlurSync grouphere abcSlur /(\(\d*\)\@<!/"
    exe "syn sync match abcSlurSync groupthere abcSlur /)/"
    exe "syn sync match abcInlineFieldSync grouphere abcInlineField /\[\a:/"
    exe "syn sync match abcInlineFieldSync groupthere abcInlineField /\]/"
    exe "syn sync match abcFieldSync grouphere abcFileField /^[A-DF-IL-ORSUZmr]:/"
    exe "syn sync match abcFieldSync grouphere abcHeaderField /^[A-DF-IK-TVWXZmr]:/"
    exe "syn sync match abcFieldSync grouphere abcBodyField /^[IK-NP-RTU-Wmrsw]:/"
    exe "syn sync match abcFieldSync groupthere NONE /^\s*$/"
    exe "syn sync match abcTuneSync grouphere abcTune /^X:/"
    exe "syn sync match abcTuneSync groupthere NONE /^\s*$/"
    exe "syn sync match abcFileHeaderSync grouphere abcFileHeader /\%^/"
    exe "syn sync match abcFileHeaderSync groupthere NONE /^\s*$/"
else
    exe "syn sync ccomment abcComment"
endif
" }}}
" Highlighting {{{
if version >= 508 || !exists('did_abc_syn_inits')
  if version < 508
    let did_abc_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  " Linking {{{
  HiLink abcTodo            Todo
  HiLink abcError           Error
  HiLink abcComment         Comment
  HiLink abcSpecialChar     SpecialChar
  HiLink abcOperator        Operator
  HiLink abcString          String
  HiLink abcRest            Statement
  HiLink abcSpacer          Statement
  HiLink abcNote            Constant
  HiLink abcBar             Delimiter
  HiLink abcTuple           Operator
  HiLink abcMacro           Macro
  HiLink abcSymbol          Type
  HiLink abcSpecialComment  SpecialComment
  HiLink abcDirective       PreProc
  HiLink abcFieldIdentifier Identifier
  HiLink abcInlineField     Special
  delcommand HiLink
  " }}}
endif
" }}}
let b:abc_sync = 0
let b:current_syntax = 'abc'
" vim: ts=4
