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
syn match abcSpecialChar /$[0-4]/ contained
syn match abcSpecialChar /\\.\{1,2}/ contained
syn match abcSpecialChar /\\u\x\{4}/ contained
syn match abcSpecialChar /\\U\x\{8}/ contained
syn match abcSpecialChar /&[#[:alnum:]]*;/ contained
syn region abcTypeset matchgroup=abcDirective start=/%%begin\(\I\i*\)/ end=/%%end\z1/ contains=abcSpecialChar transparent
" Abc Code Constructs
syn match abcOperator '[#$&-/;-@\[-`{}~]' contained
syn match abcString /"[^"%]*"/ contained contains=abcSpecialChar
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
syn region abcChord matchgroup=abcOperator start=/\[\(\a:\)\@!/ skip=/[^%\]]*/ end=/\]/ keepend contained transparent contains=abcOperator,abcRest,abcSpacer,abcNote
syn region abcGrace matchgroup=abcOperator start=/{\/\=/ skip=/[^}]*/ end=/}/ keepend contained transparent contains=abcOperator,abcRest,abcSpacer,abcNote
syn region abcSlur matchgroup=abcOperator start=/(\d\@!/ skip=/[^)]*/ end=/)/ keepend contained transparent contains=@abcCode
syn match abcSymbol /![<>.+[:alnum:]]*[()]\=!/ contained

syn cluster abcCode contains=abcOperator,abcString,abcRest,abcSpacer,abcNote,abcBar,abcTuple,abcMacro,abcChord,abcGrace,abcSlur,abcSymbol
" Fields
syn match abcFieldIdentifier /\[\a:/ms=s+1 contained
syn match abcInlineString /:[^\]]*\]/ms=s+1,me=e-1 contained contains=abcSpecialChar
syn region abcInlineField matchgroup=abcFieldIdentifier start=/\[[IK-NP-RUVmr]:/ skip=/[^%\]]/ matchgroup=abcOperator end=/\]/ keepend oneline transparent contained contains=abcInlineString

syn match abcFieldIdentifier /^[\a+]:/ contained
syn match abcFieldString /:.*$/ms=s+1 contained contains=abcSpecialChar nextgroup=abcContinueField skipnl
syn region abcContinueField matchgroup=abcFieldIdentifier start=/^+:/ end=/$/ keepend oneline contained transparent contains=abcFieldString
syn region abcFileField matchgroup=abcFieldIdentifier start=/^[A-DF-IL-ORSUZmr]:/ end=/$/ keepend oneline transparent contained contains=abcFieldString
syn region abcHeaderField matchgroup=abcFieldIdentifier start=/^[A-DF-IK-TVWXZmr]:/ end=/$/ keepend oneline transparent contained contains=abcFieldString
syn region abcBodyField matchgroup=abcFieldIdentifier start=/^[IK-NP-RTU-Wmrsw]:/ end=/$/ keepend oneline transparent contained contains=abcFieldString
" Toplevel
syn region abcTuneHeader matchgroup=abcHeaderField start=/^X:/ end=/^K:.*$/ keepend transparent contained contains=abcHeaderField,abcDirective,abcComment,abcTypeset
syn region abcTune matchgroup=abcTuneHeader start=/^X:/ matchgroup=NONE end=/^\s*$/ keepend transparent contains=@abcCode,abcBodyField,abcInlineField,abcComment,abcDirective,abcTypeset

syn match abcComment /%.*$/ extend
syn match abcSpecialComment /^%abc\%(-\d\.\d\)\=/ contained
syn match abcDirective /%%.*$/ extend
syn region abcFileHeader matchgroup=abcSpecialComment start=/\%^\%(%abc\%(-[1-9]\.\d\)\=\)\=/ matchgroup=NONE end=/^\s*$/ keepend transparent contains=abcFileField,abcDirective,abcComment,abcTypeset
" }}}
" Syncing {{{
syn sync ccomment abcComment
syn sync linecont /\\$/
"syn sync match abcTypesetSync grouphere abcTypeset /%%begin\I\i*/
"syn sync match abcTypesetSync groupthere abcTypeset /%%end\I\i*/
"syn sync match abcOperatorSync '[#$&-/;-@\[-`{}~]'
"syn sync match abcBarSync /[:|][:|]/
"syn sync match abcBarSync /[|\[\]]\%([1-9]\%([,-]\d\)*\)\=/
"syn sync match abcBarSync /:*[|\[\]]\%([1-9]\%([,-]\d\)*\)\=/
"syn sync match abcTuple /([1-9]\d*\%(:\d*\)\{,2}/
"
"syn sync match abcChordSync grouphere abcChord /\[\(\a:\)\@!/
"syn sync match abcChordSync groupthere abcChord /\]/
"
"syn sync match abcGraceSync grouphere abcGrace /{/
"syn sync match abcGraceSync groupthere abcGrace /}/
"
"syn sync match abcSlurSync grouphere abcSlur /(\d\@!/
"syn sync match abcSlurSync groupthere abcSlur /)/
"
"syn sync match abcInlineFieldSync grouphere abcInlineField /\[\a:/
"syn sync match abcInlineFieldSync groupthere abcInlineField /\]/
"
"syn sync match abcFieldSync grouphere abcFileField /^[A-DF-IL-ORSUZmr]:/
"syn sync match abcFieldSync grouphere abcHeaderField /^[A-DF-IK-TVWXZmr]:/
"syn sync match abcFieldSync grouphere abcBodyField /^[IK-NP-RTU-Wmrsw]:/
"syn sync match abcFieldSync groupthere NONE /$/
"
"syn sync match abcTuneHeaderSync grouphere abcTuneHeader /^X:/
"syn sync match abcTuneHeaderSync groupthere abcTuneHeader /^K:.*$/
"syn sync match abcTuneSync grouphere abcTune /^X:/
"syn sync match abcTuneSync groupthere NONE /^\s*$/
"
"syn sync match abcFileHeaderSync grouphere abcFileHeader /\%^%abc/
"syn sync match abcFileHeaderSync groupthere NONE /^\s*$/
" }}}
" Highlighting {{{
if version >= 508 || !exists("did_abc_syn_inits")
  if version < 508
    let did_abc_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  hi Error term=standout,bold cterm=standout,bold ctermfg=white ctermbg=red gui=standout,bold guifg=white guibg=red
  hi Todo term=standout cterm=standout ctermfg=black ctermbg=yellow gui=standout guifg=black guibg=yellow
  hi Comment term=italic cterm=italic ctermfg=darkgreen ctermbg=bg gui=italic guifg=darkgreen guibg=bg
  hi SpecialChar term=underline cterm=bold ctermfg=magenta ctermbg=bg gui=bold guifg=magenta guibg=bg
  hi Operator term=bold cterm=bold ctermfg=darkcyan ctermbg=bg gui=bold guifg=DodgerBlue guibg=bg
  hi String term=italic cterm=italic ctermfg=green ctermbg=bg gui=italic guifg=green guibg=bg
  hi Statement term=underline,bold cterm=bold ctermfg=lightcyan ctermbg=bg gui=bold guifg=LightSeaGreen guibg=bg
  hi Constant term=underline,bold cterm=bold ctermfg=darkyellow ctermbg=bg gui=bold guifg=ForestGreen guibg=bg
  hi Delimiter term=bold cterm=bold ctermfg=darkyellow ctermbg=bg gui=bold guifg=orange guibg=bg
  hi Macro term=none cterm=none ctermfg=darkmagenta ctermbg=bg gui=none guifg=DarkViolet guibg=bg
  hi Type term=none cterm=none ctermfg=lightred ctermbg=bg gui=none guifg=firebrick guibg=bg
  hi SpecialComment term=bold cterm=bold ctermfg=magenta ctermbg=bg gui=bold guifg=magenta guibg=bg
  hi PreProc term=bold cterm=bold ctermfg=magenta ctermbg=bg gui=bold guifg=magenta
  hi Identifier term=none cterm=bold ctermfg=lightgreen ctermbg=bg gui=bold guifg=LimeGreen guibg=bg
  hi Special term=none cterm=none ctermfg=cyan ctermbg=bg gui=bold guifg=cyan guibg=bg
  HiLink abcError           Error
  HiLink abcTodo            Todo
  HiLink abcNormal          Normal
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
  HiLink abcComment         Comment
  HiLink abcSpecialComment  SpecialComment
  HiLink abcDirective       PreProc
  HiLink abcFieldIdentifier Identifier
  HiLink abcFieldString     String
  HiLink abcInlineString    String
  HiLink abcInlineField     Special
  delcommand HiLink
endif
" }}}
let b:current_syntax = 'abc'
" vim: ts=4
