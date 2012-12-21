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
  " Color Schemes {{{
  " if background is light, use solarized colors
  if &background == 'light'
    hi Normal          guifg=#657B83 guibg=#FDF6E3
    hi Error           term=bold ctermfg=15 ctermbg=12 gui=bold guifg=#DC322F
    hi Comment         term=italic ctermfg=1 gui=italic guifg=#93A1A1
    hi Constant        ctermfg=4 guifg=#2AA198
    hi Special         ctermfg=5 guifg=#DC322F
    hi Identifier      ctermfg=3 guifg=#268BD2
    hi Statement       ctermfg=6 guifg=#719E07
    hi PreProc         ctermfg=5 guifg=#CB4B16
    hi Type            ctermfg=2 guifg=#B58900
    hi Underlined      cterm=underline ctermfg=5 guifg=#6C71C4
    hi Ignore          ctermfg=15
    hi Todo            term=bold ctermfg=0 ctermbg=14 gui=bold guifg=#D33682

    hi Boolean         guifg=#AE81FF
    hi Character       guifg=#E6DB74
    hi Number          guifg=#AE81FF
    hi String          guifg=#E6DB74
    hi Conditional     guifg=#F92672               gui=bold
    hi Debug           guifg=#BCA3A3               gui=bold
    hi Define          guifg=#66D9EF
    hi Delimiter       guifg=#8F8F8F
    hi Exception       guifg=#A6E22E               gui=bold
    hi Float           guifg=#AE81FF
    hi Function        guifg=#A6E22E
    hi Keyword         guifg=#F92672               gui=bold
    hi Label           guifg=#E6DB74               gui=none
    hi Macro           guifg=#C4BE89               gui=italic
    hi Operator        guifg=#F92672
    hi PreCondit       guifg=#A6E22E               gui=bold
    hi Repeat          guifg=#F92672               gui=bold
    hi SpecialChar     guifg=#F92672               gui=bold
    hi SpecialComment  guifg=#465457               gui=bold
    hi StorageClass    guifg=#FD971F               gui=italic
    hi Structure       guifg=#66D9EF
    hi Tag             guifg=#F92672               gui=italic
    hi Typedef         guifg=#66D9EF
    if has('spell')
      hi SpellBad   term=undercurl ctermbg=12 gui=undercurl guisp=#DC322F
      hi SpellCap   term=undercurl ctermbg=9 gui=undercurl guisp=#6C71C4
      hi SpellRare  term=undercurl ctermbg=13 gui=undercurl guisp=#2AA198
      hi SpellLocal term=undercurl ctermbg=11 gui=undercurl guisp=#B58900
    endif
  " else use molokai colors for dark background
  else 
    hi SpecialKey     term=bold ctermfg=9 gui=italic guifg=#465457
    hi ErrorMsg       term=standout ctermfg=15 ctermbg=4 gui=bold guifg=#F92672 guibg=#232526
    hi Normal         guifg=#F8F8F2 guibg=#1B1D1E
    hi Error          term=reverse ctermfg=15 ctermbg=12 guifg=#960050 guibg=#1E0010
    hi Comment        term=bold ctermfg=11 guifg=#465457
    hi Constant       term=underline ctermfg=13 gui=bold guifg=#AE81FF
    hi Special        term=bold ctermfg=12 gui=italic guifg=#66D9EF guibg=bg
    hi Identifier     term=underline cterm=bold ctermfg=11 guifg=#FD971F
    hi Statement      term=bold ctermfg=14 gui=bold guifg=#F92672
    hi PreProc        term=underline ctermfg=9 guifg=#A6E22E
    hi Type           term=underline ctermfg=10 guifg=#66D9EF
    hi Underlined     term=underline cterm=underline ctermfg=9 gui=underline guifg=#808080
    hi Ignore         ctermfg=0 guifg=#808080 guibg=bg
    hi Todo           term=standout ctermfg=0 ctermbg=14 gui=bold guifg=#FFFFFF guibg=bg

    hi String         guifg=#E6DB74
    hi Character      guifg=#E6DB74
    hi Number         guifg=#AE81FF
    hi Boolean        guifg=#AE81FF
    hi Float          guifg=#AE81FF
    hi Function       guifg=#A6E22E
    hi Conditional    gui=bold guifg=#F92672
    hi Repeat         gui=bold guifg=#F92672
    hi Label          guifg=#E6DB74
    hi Operator       guifg=#F92672
    hi Keyword        gui=bold guifg=#F92672
    hi Exception      gui=bold guifg=#A6E22E
    hi Include        links to PreProc
    hi Define         guifg=#66D9EF
    hi Macro          gui=italic guifg=#C4BE89
    hi PreCondit      gui=bold guifg=#A6E22E
    hi StorageClass   gui=italic guifg=#FD971F
    hi Structure      guifg=#66D9EF
    hi Typedef        guifg=#66D9EF
    hi Tag            gui=italic guifg=#F92672
    hi SpecialChar    gui=bold guifg=#F92672
    hi Delimiter      guifg=#8F8F8F
    hi SpecialComment gui=bold guifg=#465457
    hi Debug          gui=bold guifg=#BCA3A3
    if has('spell')
      hi SpellBad   term=undercurl ctermbg=12 gui=undercurl guisp=#DC322F
      hi SpellCap   term=undercurl ctermbg=9 gui=undercurl guisp=#6C71C4
      hi SpellRare  term=undercurl ctermbg=13 gui=undercurl guisp=#2AA198
      hi SpellLocal term=undercurl ctermbg=11 gui=undercurl guisp=#B58900
    endif
  endif
  " }}}
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
