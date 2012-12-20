" Vim syntax file
" Language: abc music header 
" Maintainer: Lee Savide <laughingman182@yahoo.com>
" License: http://apache.org/licenses/LICENSE-2.0.txt
" Last Change: Nov 01 2012

if version < 600
  syn clear
elseif exists('b:current_syntax')
  finish
endif
syn sync clear

syn case ignore
syn keyword abhTodo contained todo fixme volatile
syn case match
syn match abhSpecialChar /$[0-4]/ contained
syn match abhSpecialChar /\\.\{,2}/ contained
syn match abhSpecialChar /\\u\x\{4}/ contained
syn match abhSpecialChar /\\U\x\{8}/ contained
syn match abhSpecialChar /&#\=\d*;/ contained
syn match abhSpecialChar /&\I\i*;/ contained
syn match abhFieldIdentifier /^[\a+]:/ contained
syn match abhContinueField /^+:.*$/ contained contains=abcFieldIdentifier,abcSpecialChar
syn match abhField /^[A-DF-IL-ORSUZmr]:.*$/ contained contains=abcFieldIdentifier,abcSpecialChar
syn match abhComment /%.*$/ extend contains=abhTodo
syn match abhDirective /%%.*$/ extend
syn region abhTypeset matchgroup=abcDirective start=/%%begin\(\I\i*\)/ end=/%%end\z1/ contains=abcSpecialChar transparent
if has('b:abh_sync' == 1)
    exe "syn sync match abhTypesetSync grouphere abcTypeset /%%begin/"
    exe "syn sync match abhTypesetSync groupthere abcTypeset /%%end/"
else
    exe "syn sync ccomment abhComment"
endif
" Highlighting {{{
if version >= 508 || !exists('did_abc_syn_inits')
  if version < 508
    let did_abc_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  " if light background, use solarized colors
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
  HiLink abhTodo            Todo
  HiLink abhError           Error
  HiLink abhComment         Comment
  HiLink abhSpecialChar     SpecialChar
  HiLink abhOperator        Operator
  HiLink abhString          String
  HiLink abhField           String
  HiLink abhSpecialComment  SpecialComment
  HiLink abhDirective       PreProc
  HiLink abhFieldIdentifier Identifier
  delcommand HiLink
endif
" }}}
let b:abh_sync = 0
let b:current_syntax = 'abh'
" vim: ts=4
