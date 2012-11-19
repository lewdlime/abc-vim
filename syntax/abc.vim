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
syn match abcSpecialChar /\\.\{,2}/ contained
syn match abcSpecialChar /\\u\x\{4}/ contained
syn match abcSpecialChar /\\U\x\{8}/ contained
syn match abcSpecialChar /&#\=\d*;/ contained
syn match abcSpecialChar /&\I\i*;/ contained
" Code {{{
syn match abcOperator '[()#$&-/;-@^-`{}~\\]' contained
syn match abcString /"[^"%]*"/ contained contains=abcSpecialChar
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
syn match abcMacro /~\I\i\{1,31}/ contained
syn region abcChord matchgroup=abcOperator start=/\[\(\a:\|\d*\|:*\)\@<!/ skip=/[^%\]]*/ end=/\]/ keepend contained
syn region abcGrace matchgroup=abcOperator start=/{\/\=/ skip=/[^}]*/ end=/}/ keepend contained
syn region abcSlur matchgroup=abcOperator start=/(\(\d*\)\@<!/ skip=/\\)/ end=/)/ keepend contained
" }}}
syn cluster abcCode contains=abcOperator,abcString,abcRest,abcSpacer,abcNote,abcBar,abcTuple,abcSymbol,abcMacro,abcChord,abcGrace,abcSlur
" Fields {{{
syn match abcFieldIdentifier /^[\a+]:/ contained
syn match abcInlineIdentifier /\[\a:/ contained
syn region abcInlineField matchgroup=abcInlineIdentifier start=/\[[IK-NP-RUVmr]:/ skip=/[^%\]]/ matchgroup=abcOperator end=/\]/ keepend contained contains=abcSpecialChar
syn match abcContinueField /^+:.*$/ contained contains=abcFieldIdentifier,abcSpecialChar
syn match abcBodyField excludenl /^[IK-NP-RTU-Wmrsw]:.*$/ contained contains=abcFieldIdentifier,abcSpecialChar
syn match abcFileField excludenl /^[A-DF-IL-ORSUZmr]:.*$/ contained contains=abcFieldIdentifier,abcSpecialChar
syn match abcHeaderField excludenl /^[A-DF-IK-XZmr]:/ contained contains=abcFieldIdentifier,abcSpecialChar
" }}}
" Toplevel {{{
syn region abcTuneHeader matchgroup=abcHeaderField start=/^X:/ end=/^K:.*$/ keepend contains=abcHeaderField,abcDirective,abcComment,abcTypeset
syn region abcTuneBody start=/\%(\_^X:.*\_$\)\(\%(\_^\s*\_$\)*\)\@<!\%(\_^K:.*\_$\)\zs\1\@<!/ end=/^\s*$/ keepend transparent contains=@abcCode,abcInlineField,abcBodyField
syn region abcTune matchgroup=abcTuneHeader start=/^X:/ matchgroup=NONE end=/^\s*$/ keepend contains=@abcCode,abcInlineField,abcBodyField

syn region abcTypeset matchgroup=abcDirective start=/%%begin\(\I\i*\)/ end=/%%end\z1/ contains=abcSpecialChar transparent
syn match abcComment /%.*$/ extend
syn match abcSpecialComment /^%abc\%(-\d\.\d\)\=/ contained
syn match abcDirective /%%.*$/ extend
syn region abcFileHeader matchgroup=abcSpecialComment start=/\%^\%(%abc\%(-[1-9]\.\d\)\=\)\=/ matchgroup=NONE end=/^\s*$/ keepend contains=abcFileField,abcDirective,abcComment,abcTypeset
" }}}
" }}}
" Syncing {{{
syn sync fromstart
syn sync ccomment abcComment
syn sync match abcTypesetSync grouphere abcTypeset /%%begin\I\i*/
syn sync match abcTypesetSync groupthere abcTypeset /%%end\I\i*/
syn sync linecont /\\$/
syn sync match abcChordSync grouphere abcChord /\[\(\a:\|\d*\|:*\)\@<!/
syn sync match abcChordSync groupthere abcChord /\]/
syn sync match abcGraceSync grouphere abcGrace /{\/\=/
syn sync match abcGraceSync groupthere abcGrace /}/
syn sync match abcSlurSync grouphere abcSlur /(\(\d*\)\@<!/
syn sync match abcSlurSync groupthere abcSlur /)/
syn sync match abcInlineFieldSync grouphere abcInlineField /\[\a:/
syn sync match abcInlineFieldSync groupthere abcInlineField /\]/
syn sync linecont /^+:/
syn sync match abcFieldSync grouphere abcFileField /^[A-DF-IL-ORSUZmr]:/
syn sync match abcFieldSync grouphere abcHeaderField /^[A-DF-IK-TVWXZmr]:/
syn sync match abcFieldSync grouphere abcBodyField /^[IK-NP-RTU-Wmrsw]:/
syn sync match abcFieldSync groupthere NONE /$/
syn sync match abcTuneHeaderSync grouphere abcTuneHeader /^X:/
syn sync match abcTuneHeaderSync groupthere abcTuneHeader /^K:.*$/
syn sync match abcTuneBodySync grouphere abcTuneBody /\%(\_^X:.*\_$\)\(\%(\_^\s*\_$\)*\)\@<!\%(\_^K:.*\_$\)\zs\1/
syn sync match abcTuneBodySync groupthere NONE /^\s*$/
syn sync match abcTuneSync grouphere abcTune /^X:/
syn sync match abcTuneSync groupthere NONE /^\s*$/
syn sync match abcFileHeaderSync grouphere abcFileHeader /\%^/
syn sync match abcFileHeaderSync groupthere NONE /^\s*$/
" }}}
" Highlighting {{{
if version >= 508 || !exists("did_abc_syn_inits")
  if version < 508
    let did_abc_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  " Use Solarized colors for main groups, then use molokai
  hi Todo cterm=standout ctermfg=#000000 ctermbg=#ffff00 gui=standout guifg=#000000 guibg=#ffff00
  hi Error cterm=standout,bold ctermfg=#ffffff ctermbg=#ff0000 gui=standout,bold guifg=#ffffff guibg=#ff0000
  hi Comment cterm=italic ctermfg=#0000ff ctermbg=bg gui=italic guifg=#0000ff guibg=bg
  hi SpecialComment cterm=italic ctermfg=#ff00ff ctermbg=bg gui=bold guifg=#ff00ff guibg=bg
  hi SpecialChar ctermfg=#b03060 ctermbg=bg gui=bold guifg=#b03060 guibg=bg
  hi Operator ctermfg=#6495ed ctermbg=bg gui=bold guifg=#6495ed guibg=bg
  hi String ctermfg=#006400 ctermbg=bg gui=italic guifg=#006400 guibg=bg
  hi Statement ctermfg=#7fffd4 ctermbg=bg gui=bold guifg=#7fffd4 guibg=bg
  hi Constant ctermfg=#ff69b4 ctermbg=bg gui=bold guifg=#ff69b4 guibg=bg
  hi Delimiter ctermfg=#228b22 ctermbg=bg gui=bold guifg=#228b22 guibg=bg
  hi Macro cterm=bold ctermfg=#da70d6 ctermbg=bg gui=none guifg=#da70d6 guibg=bg
  hi Type ctermfg=#dc143c ctermbg=bg gui=none guifg=#dc143c guibg=bg
  hi PreProc cterm=bold ctermfg=#ff00ff ctermbg=bg gui=bold guifg=#ff00ff guibg=bg
  hi Identifier ctermfg=#ff7f50 ctermbg=bg gui=bold guifg=#ff7f50 guibg=bg
  hi Special ctermfg=#b22222 ctermbg=bg gui=bold guifg=#b22222 guibg=bg
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
endif
" }}}
let b:current_syntax = 'abc'
" vim: ts=4
