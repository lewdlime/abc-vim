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
syn case match
syn keyword fmtKeyword contained abc2pscompat alignbars aligncomposer annotationfont autoclef barnumbers barsperstaff breaklimit breakoneoln beginps beginsvg bgcolor botmargin bstemdown cancelkey comball combinevoices composerfont composerspace contbarnb continueall custos dateformat deco decoration dblrepbar dynalign dynamic encoding flatbeams font footer footerfont format gchord gchordbox gchordfont graceslurs gracespace gstemdir header headerfont historyfont hyphencont indent infofont infoline infoname infospace keywarn landscape leftmargin linebreak lineskipfac linewarn maxshrink maxstaffsep maxsysstaffsep measurebox measurefirst measurefont measurenb micronewps musiconly musicspace notespacingfactor oneperpage ornament pageheight pagewidth pango parskipfac partsbox partsfont partsspace pdfmark postscript repeatfont rightmargin scale setdefl setfont-1 setfont-2 setfont-3 setfont-4 shiftunison slurheight splittune squarebreve stafflines staffnonote staffscale staffsep staffwidth stemdir stemheight straightflags stretchlast stretchstaff subtitlefont subtitlespace sysstaffsep tempofont textfont textoption textspace timewarn titlecaps titlefont titleformat titleleft titlespace titletrim topmargin topspace tuplets user vocal vocalabove vocalfont vocalspace voicefont voicescale volume wordsfont wordsspace writefields begintext center clef EPS endtext multicol newpage repbra repeat score sep setbarnb staff staffbreak staves tablature text transpose vskip break clip select tune voice
syn keyword fmtArgument contained box obeylines ragged fill center skip right
syn match fmtArgument contained / [^ %\t\r\n]*$/
syn match fmtDirective /^\I\i*/ contains=fmtKeyword nextgroup=fmtArgument skipwhite
syn match fmtComment /%.*$/
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
    hi Comment         term=italic ctermfg=1 gui=italic guifg=#93A1A1
    hi Statement       ctermfg=6 guifg=#719E07
    hi PreProc         ctermfg=5 guifg=#CB4B16
  " else use molokai colors for dark background
  else 
    hi Normal         guifg=#F8F8F2 guibg=#1B1D1E
    hi Comment        term=bold ctermfg=11 guifg=#465457
    hi Statement      term=bold ctermfg=14 gui=bold guifg=#F92672
    hi PreProc        term=underline ctermfg=9 guifg=#A6E22E
  endif
  HiLink fmtComment     Comment
  HiLink fmtDirective   PreProc
  HiLink fmtArgument    Statement
  delcommand HiLink
endif
" }}}
let b:current_syntax = 'fmt'
" vim: ts=4
