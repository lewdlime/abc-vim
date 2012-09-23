" Vim syntax file
" Language: abc music notation includes
" Maintainer: Lee Savide <laughingman182@gmail.com>
" Last Change: 18 August 2012
" GetLatestVimScripts: ### ### abc-vim.vmb
" License:
" {{{
"   Copyright 2012 Lee Savide
" 
"   Licensed under the Apache License, Version 2.0 (the "License");
"   you may not use this file except in compliance with the License.
"   You may obtain a copy of the License at
" 
"       http://www.apache.org/licenses/LICENSE-2.0
" 
"   Unless required by applicable law or agreed to in writing, software
"   distributed under the License is distributed on an "AS IS" BASIS,
"   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"   See the License for the specific language governing permissions and
"   limitations under the License.
" }}}
" Note - for abc files that include a BOM (byte order mark),
" the setting to remove it in Vim is ':set nobomb'.
" Startup {{{
if !exists('main_syntax')
    if version < 600
        syntax clear " Clear the syntax highlighting
    elseif has('b:current_syntax=1')
        finish
    endif
    " Inclusions
    syn include texAccent,texLigature syntax/tex.vim
    syn include syntax/xml.vim
    syn include after/syntax/svg.vim
    syn include after/syntax/xhtml.vim
    syn include cFormat syntax/c.vim
    syn include syntax/postscr.vim " abc is extended from PostScript syntax
    " Variables
    let main_syntax = 'abc'
    let g:abc_utf = 1
    let g:abc_chars = 1
    endif
endif

set iskeyword="32-126"
" Includes all printable ASCII characters but tab, line feed, vertical tab, and
" form feed
syn case ignore
syn cluster abcXML contains=xmlTodo,xmlTag,xmlTagName,xmlEndTag,xmlNamespace,xmlEntity,xmlEntityPunct,xmlAttribPunct,xmlAttrib,xmlString,xmlComment,xmlCommentPart,xmlCommentError,xmlError,xmlProcessingDelim,xmlProcessing,xmlCdata,xmlCdataCdata,xmlCdataStart,xmlCdataEnd,xmlDocTypeDecl,xmlDocTypeKeyword,xmlInlineDTD
syn cluster abcPS contains=postscrComment,postscrConstant,postscrString,postscrNumber,postscrFloat,postscrBoolean,postscrIdentifier,postscrProcedure,postscrName,postscrConditional,postscrRepeat,postscrOperator,postscrDSCComment,postscrSpecialChar,postscrTodo,postscrError,postscrGSOperator,postscrGSMathOperator
syn keyword abcKeyModes contained m[inor] maj[or] ion[ian] aeo[lian] mix[olydian] dor[ian] phr[ygian] lyd[ian] loc[rian]
" abcKeyModes is the only case independant part of abc syntax.
" }}}
syn case match
" Syncing {{{
" sy[ntax] sync [ccomment [group-name] | minlines={N} | ...]
syn sync linecont '\\\s*$'
" Set syncing on line continuation character
syn sync ccomment abcComment
" Set syncing on comments
syn sync region abcGraceNotesRegion start='{\/\=' end='}'
syn sync region abcChordSync start='\[' end='\]'
syn sync region abcRemarkSync start='\[r:' end='\]' fold
syn sync match abcGraceNotesSync grouphere abcGraceNotesRegion '{'
syn sync match abcGraceNotesSync groupthere abcGraceNotesRegion '}'
syn sync match abcChordSync grouphere abcChord '\['
syn sync match abcChordSync groupthere abcChord '\]'
syn sync match abcRemarkSync grouphere abcRemarkIdentifier '\['
syn sync match abcRemarkSync groupthere abcRemarkIdentifier '\]'
syn sync match abcFieldContinueSync
    \ groupthere abcFieldStatement '^+:[^%]*'

" }}}
" Set comments to be ignored
" Datatypes & Keywords {{{
" Fonts {{{
syn keyword abcFontKeyword contained nextgroup=abcFontSize AlbertusMT AlbertusMT-Italic AlbertusMT-Light Apple-Chancery Apple-ChanceryCE
syn keyword abcFontKeyword contained nextgroup=abcFontSize AntiqueOlive-Roman AntiqueOlive-Italic AntiqueOlive-Bold AntiqueOlive-Compact
syn keyword abcFontKeyword contained nextgroup=abcFontSize AntiqueOliveCE-Roman AntiqueOliveCE-Italic AntiqueOliveCE-Bold AntiqueOliveCE-Compact
syn keyword abcFontKeyword contained nextgroup=abcFontSize ArialMT Arial-ItalicMT Arial-LightMT Arial-BoldMT Arial-BoldItalicMT
syn keyword abcFontKeyword contained nextgroup=abcFontSize ArialCE ArialCE-Italic ArialCE-Light ArialCE-Bold ArialCE-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize AvantGarde-Book AvantGarde-BookOblique AvantGarde-Demi AvantGarde-DemiOblique
syn keyword abcFontKeyword contained nextgroup=abcFontSize AvantGardeCE-Book AvantGardeCE-BookOblique AvantGardeCE-Demi AvantGardeCE-DemiOblique
syn keyword abcFontKeyword contained nextgroup=abcFontSize Bodoni Bodoni-Italic Bodoni-Bold Bodoni-BoldItalic Bodoni-Poster Bodoni-PosterCompressed
syn keyword abcFontKeyword contained nextgroup=abcFontSize BodoniCE BodoniCE-Italic BodoniCE-Bold BodoniCE-BoldItalic BodoniCE-Poster BodoniCE-PosterCompressed
syn keyword abcFontKeyword contained nextgroup=abcFontSize Bookman-Light Bookman-LightItalic Bookman-Demi Bookman-DemiItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize BookmanCE-Light BookmanCE-LightItalic BookmanCE-Demi BookmanCE-DemiItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize Carta Chicago ChicagoCE Clarendon Clarendon-Light Clarendon-Bold
syn keyword abcFontKeyword contained nextgroup=abcFontSize ClarendonCE ClarendonCE-Light ClarendonCE-Bold CooperBlack CooperBlack-Italic
syn keyword abcFontKeyword contained nextgroup=abcFontSize Copperplate-ThirtyTwoBC CopperPlate-ThirtyThreeBC Coronet-Regular CoronetCE-Regular
syn keyword abcFontKeyword contained nextgroup=abcFontSize CourierCE CourierCE-Oblique CourierCE-Bold CourierCE-BoldOblique
syn keyword abcFontKeyword contained nextgroup=abcFontSize Eurostile Eurostile-Bold Eurostile-ExtendedTwo Eurostile-BoldExtendedTwo
syn keyword abcFontKeyword contained nextgroup=abcFontSize Eurostile EurostileCE-Bold EurostileCE-ExtendedTwo EurostileCE-BoldExtendedTwo
syn keyword abcFontKeyword contained nextgroup=abcFontSize Geneva GenevaCE GillSans GillSans-Italic GillSans-Bold GillSans-BoldItalic GillSans-BoldCondensed
syn keyword abcFontKeyword contained nextgroup=abcFontSize GillSans-Light GillSans-LightItalic GillSans-ExtraBold
syn keyword abcFontKeyword contained nextgroup=abcFontSize GillSansCE-Roman GillSansCE-Italic GillSansCE-Bold GillSansCE-BoldItalic GillSansCE-BoldCondensed
syn keyword abcFontKeyword contained nextgroup=abcFontSize GillSansCE-Light GillSansCE-LightItalic GillSansCE-ExtraBold
syn keyword abcFontKeyword contained nextgroup=abcFontSize Goudy Goudy-Italic Goudy-Bold Goudy-BoldItalic Goudy-ExtraBould
syn keyword abcFontKeyword contained nextgroup=abcFontSize HelveticaCE HelveticaCE-Oblique HelveticaCE-Bold HelveticaCE-BoldOblique
syn keyword abcFontKeyword contained nextgroup=abcFontSize Helvetica-Condensed Helvetica-Condensed-Oblique Helvetica-Condensed-Bold Helvetica-Condensed-BoldObl
syn keyword abcFontKeyword contained nextgroup=abcFontSize HelveticaCE-Condensed HelveticaCE-Condensed-Oblique HelveticaCE-Condensed-Bold
syn keyword abcFontKeyword contained nextgroup=abcFontSize HelveticaCE-Condensed-BoldObl Helvetica-Narrow Helvetica-Narrow-Oblique Helvetica-Narrow-Bold
syn keyword abcFontKeyword contained nextgroup=abcFontSize Helvetica-Narrow-BoldOblique HelveticaCE-Narrow HelveticaCE-Narrow-Oblique HelveticaCE-Narrow-Bold
syn keyword abcFontKeyword contained nextgroup=abcFontSize HelveticaCE-Narrow-BoldOblique HoeflerText-Regular HoeflerText-Italic HoeflerText-Black
syn keyword abcFontKeyword contained nextgroup=abcFontSize HoeflerText-BlackItalic HoeflerText-Ornaments HoeflerTextCE-Regular HoeflerTextCE-Italic
syn keyword abcFontKeyword contained nextgroup=abcFontSize HoeflerTextCE-Black HoeflerTextCE-BlackItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize JoannaMT JoannaMT-Italic JoannaMT-Bold JoannaMT-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize JoannaMTCE JoannaMTCE-Italic JoannaMTCE-Bold JoannaMTCE-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize LetterGothic LetterGothic-Slanted LetterGothic-Bold LetterGothic-BoldSlanted
syn keyword abcFontKeyword contained nextgroup=abcFontSize LetterGothicCE LetterGothicCE-Slanted LetterGothicCE-Bold LetterGothicCE-BoldSlanted
syn keyword abcFontKeyword contained nextgroup=abcFontSize LubalinGraph-Book LubalinGraph-BookOblique LubalinGraph-Demi LubalinGraph-DemiOblique
syn keyword abcFontKeyword contained nextgroup=abcFontSize LubalinGraphCE-Book LubalinGraphCE-BookOblique LubalinGraphCE-Demi LubalinGraphCE-DemiOblique
syn keyword abcFontKeyword contained nextgroup=abcFontSize Marigold Monaco MonacoCE MonaLisa-Recut Oxford Symbol Tekton
syn keyword abcFontKeyword contained nextgroup=abcFontSize NewCennturySchlbk-Roman NewCenturySchlbk-Italic NewCenturySchlbk-Bold NewCenturySchlbk-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize NewCenturySchlbkCE-Roman NewCenturySchlbkCE-Italic NewCenturySchlbkCE-Bold
syn keyword abcFontKeyword contained nextgroup=abcFontSize NewCenturySchlbkCE-BoldItalic NewYork NewYorkCE
syn keyword abcFontKeyword contained nextgroup=abcFontSize Optima Optima-Italic Optima-Bold Optima-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize OptimaCE OptimaCE-Italic OptimaCE-Bold OptimaCE-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize Palatino-Roman Palatino-Italic Palatino-Bold Palatino-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize PalatinoCE-Roman PalatinoCE-Italic PalatinoCE-Bold PalatinoCE-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize StempelGaramond-Roman StempelGaramond-Italic StempelGaramond-Bold StempelGaramond-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize StempelGaramondCE-Roman StempelGaramondCE-Italic StempelGaramondCE-Bold StempelGaramondCE-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize TimesCE-Roman TimesCE-Italic TimesCE-Bold TimesCE-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize TimesNewRomanPSMT TimesNewRomanPS-ItalicMT TimesNewRomanPS-BoldMT TimesNewRomanPS-BoldItalicMT
syn keyword abcFontKeyword contained nextgroup=abcFontSize TimesNewRomanCE TimesNewRomanCE-Italic TimesNewRomanCE-Bold TimesNewRomanCE-BoldItalic
syn keyword abcFontKeyword contained nextgroup=abcFontSize Univers Univers-Oblique Univers-Bold Univers-BoldOblique
syn keyword abcFontKeyword contained nextgroup=abcFontSize UniversCE-Medium UniversCE-Oblique UniversCE-Bold UniversCE-BoldOblique
syn keyword abcFontKeyword contained nextgroup=abcFontSize Univers-Light Univers-LightOblique UniversCE-Light UniversCE-LightOblique
syn keyword abcFontKeyword contained nextgroup=abcFontSize Univers-Condensed Univers-CondensedOblique Univers-CondensedBold Univers-CondensedBoldOblique
syn keyword abcFontKeyword contained nextgroup=abcFontSize UniversCE-Condensed UniversCE-CondensedOblique UniversCE-CondensedBold UniversCE-CondensedBoldOblique
syn keyword abcFontKeyword contained nextgroup=abcFontSize Univers-Extended Univers-ExtendedObl Univers-BoldExt Univers-BoldExtObl
syn keyword abcFontKeyword contained nextgroup=abcFontSize UniversCE-Extended UniversCE-ExtendedObl UniversCE-BoldExt UniversCE-BoldExtObl
syn keyword abcFontKeyword contained nextgroup=abcFontSize Wingdings-Regular ZapfChancery-MediumItalic ZapfChanceryCE-MediumItalic ZapfDingBats

syn match abcFontDefault "\*" contained
syn keyword abcFontEncKeyword contained utf-8 us-ascii native
" }}}
syn keyword abcEncKeyword contained us-ascii utf-8 iso-8859-1 latin1 iso-8859-2 latin2 iso-8859-3 latin3 iso-8859-4 latin4 iso-8859-9 latin5 iso-8859-10 latin6
syn keyword abcBoolean contained 1 0 true false yes no on off
syn match abcHex '\<\x\{2,}\>' contained
syn match abcInteger '\<[+-]\=\d\+\>' contained
syn match abcFloat '\<[+-]\=\d\+\.\d*\>' contained
syn cluster abcNumber contains=abcInteger,abcFloat
syn keyword abcUnitKeyword contained in mm cm pt
syn match abcUnit '\d\+\%(\.\d*\)\=\%(in\|mm\|cm\|pt\)' contains=@abcNumber,abcUnitKeyword
" }}}
" Ignore & Comments {{{
syn keyword abcTodo contained TODO Todo ToDo todo NOTE Note note VOLATILE Volatile volatile VOCAL[S] Vocal[s] vocal[s] PERCUSSION Percussion percussion 
syn match abcComment excludenl '%\{1}.*$' extend display contains=abcTodo
" Comments extend any containing item that's normally set with keepend, and are
" unconditionally displayed as comments
syn keyword abcRemarkIdentifier contained r:
syn region abcComment
    \ matchgroup=abcRemarkIdentifier start='^r:'
    \ matchgroup=NONE skip='[^%]*'
    \ excludenl end='$' keepend oneline fold
syn region abcComment
    \ matchgroup=abcRemarkIdentifier start='\[r:' 
    \ matchgroup=NONE skip='[^%]*'
    \ end='\]' keepend contained fold
syn match abcSpecialComment '%abc\%(-[1-9]\.\d\)\='
" }}}
" Special Comments & Directives {{{
syn match abcPreProc '%%\<\K\k*\>'
    \ contains=abcDirectiveKeyword nextgroup=@abcDirectiveParam skipwhite
syn region abcPreProc matchgroup=@abcFieldIdentifier start='^I:'
    \ skip='\<\K\k*\>' excludenl end='$'
    \ contains=abcDirectiveKeyword,@abcDirectiveParam
syn keyword abcInstructionKeyword contained abc2pscompat alignbars
    \ aligncomposer annotationfont autoclef
    \ barnumbers barsperstaff beginps beginsvg
    \ breakoneoln bgcolor botmargin bstemdown
    \ comball combinevoices composerfont composerspace
    \ contbarnb continueall custos dateformat deco
    \ decoration dynalign dynamic encoding endps endsvg
    \ flatbeams font footer footerfont format gchord
    \ gchordbox gchordfont graceslurs gracespace gstemdir
    \ header headerfont historyfont hyphencont indent
    \ infofont infoline infoname infospace landscape
    \ leftmargin linebreak lineskipfac linewarn maxshrink
    \ maxstaffsep maxsysstaffsep measurebox measurefirst
    \ measurefont measurenb musiconly musicspace
    \ notespacingfactor oneperpage ornament pageheight
    \ pagewidth pango parskipfac partsbox partsfont
    \ partsspace pdfmark postscript repeatfont rightmargin
    \ scale setdefl setfont-1 setfont-2 setfont-3 setfont-4
    \ shiftunisson slurheight splittune squarebreve
    \ staffnonote staffsep staffwidth stemdir stemheight
    \ straightflags stretchlast stretchstaff subtitlefont
    \ subtitlefont subtitlespace  sysstaffsep tempofont
    \ textfont textoption textspace timewarn titlecaps
    \ titlefont titleformat titleleft titlespace titletrim
    \ topmargin topspace tuplets vocal vocalabove vocalfont
    \ vocalspace voicefont volume wordsfont wordsspace writefields
syn keyword abcDirectiveKeyword contained begintext beginps beginsvg
    \ center clef EPS endtext multicol newpage repbra repeat
    \ score sep setbarnb staff staffbreak staves tablature text
    \ transpose vskip
" }}}
" Special Characters & Strings {{{
" Special Characters {{{
if has("g:abc_chars == 1")
    syn match abcSpecial /\C\\`A\|&Agrave;/  contained conceal cchar=À
    syn match abcSpecial /\C\\`a\|&agrave;/  contained conceal cchar=à
    syn match abcSpecial /\C\\`E\|&Egrave;/  contained conceal cchar=È
    syn match abcSpecial /\C\\`e\|&egrave;/  contained conceal cchar=è
    syn match abcSpecial /\C\\`I\|&Igrave;/  contained conceal cchar=Ì
    syn match abcSpecial /\C\\`i\|&igrave;/  contained conceal cchar=ì
    syn match abcSpecial /\C\\`O\|&Ograve;/  contained conceal cchar=Ò
    syn match abcSpecial /\C\\`o\|&ograve;/  contained conceal cchar=ò
    syn match abcSpecial /\C\\`U\|&Ugrave;/  contained conceal cchar=Ù
    syn match abcSpecial /\C\\`u\|&ugrave;/  contained conceal cchar=ù
    syn match abcSpecial /\C\\'A\|&Aacute;/  contained conceal cchar=Á
    syn match abcSpecial /\C\\'a\|&aacute;/  contained conceal cchar=á
    syn match abcSpecial /\C\\'E\|&Eacute;/  contained conceal cchar=É
    syn match abcSpecial /\C\\'e\|&eacute;/  contained conceal cchar=é
    syn match abcSpecial /\C\\'I\|&Iacute;/  contained conceal cchar=Í
    syn match abcSpecial /\C\\'i\|&iacute;/  contained conceal cchar=í
    syn match abcSpecial /\C\\'O\|&Oacute;/  contained conceal cchar=Ó
    syn match abcSpecial /\C\\'o\|&oacute;/  contained conceal cchar=ó
    syn match abcSpecial /\C\\'U\|&Uacute;/  contained conceal cchar=Ú
    syn match abcSpecial /\C\\'u\|&uacute;/  contained conceal cchar=ú
    syn match abcSpecial /\C\\'Y\|&Yacute;/  contained conceal cchar=Ý
    syn match abcSpecial /\C\\'y\|&yacute;/  contained conceal cchar=ý
    syn match abcSpecial /\C\\^A\|&Acirc;/   contained conceal cchar=Â
    syn match abcSpecial /\C\\^a\|&acirc;/   contained conceal cchar=â
    syn match abcSpecial /\C\\^E\|&Ecirc;/   contained conceal cchar=Ê
    syn match abcSpecial /\C\\^e\|&ecirc;/   contained conceal cchar=ê
    syn match abcSpecial /\C\\^I\|&Icirc;/   contained conceal cchar=Î
    syn match abcSpecial /\C\\^i\|&icirc;/   contained conceal cchar=î
    syn match abcSpecial /\C\\^O\|&Ocirc;/   contained conceal cchar=Ô
    syn match abcSpecial /\C\\^o\|&ocirc;/   contained conceal cchar=ô
    syn match abcSpecial /\C\\^U\|&Ucirc;/   contained conceal cchar=Û
    syn match abcSpecial /\C\\^u\|&ucirc;/   contained conceal cchar=û
    syn match abcSpecial /\C\\^Y\|&Ycirc;/   contained conceal cchar=Ŷ
    syn match abcSpecial /\C\\^y\|&ycirc;/   contained conceal cchar=ŷ
    syn match abcSpecial /\C\\~A\|&Atilde;/  contained conceal cchar=Ã
    syn match abcSpecial /\C\\~a\|&atilde;/  contained conceal cchar=ã
    syn match abcSpecial /\C\\~N\|&Ntilde;/  contained conceal cchar=Ñ
    syn match abcSpecial /\C\\~n\|&ntilde;/  contained conceal cchar=ñ
    syn match abcSpecial /\C\\~O\|&Otilde;/  contained conceal cchar=Õ
    syn match abcSpecial /\C\\~o\|&otilde;/  contained conceal cchar=õ
    syn match abcSpecial /\C\\"A\|&Auml;/    contained conceal cchar=Ä
    syn match abcSpecial /\C\\"a\|&auml;/    contained conceal cchar=ä
    syn match abcSpecial /\C\\"E\|&Euml;/    contained conceal cchar=Ë
    syn match abcSpecial /\C\\"e\|&euml;/    contained conceal cchar=ë
    syn match abcSpecial /\C\\"I\|&Iuml;/    contained conceal cchar=Ï
    syn match abcSpecial /\C\\"i\|&iuml;/    contained conceal cchar=ï
    syn match abcSpecial /\C\\"O\|&Ouml;/    contained conceal cchar=Ö
    syn match abcSpecial /\C\\"o\|&ouml;/    contained conceal cchar=ö
    syn match abcSpecial /\C\\"U\|&Uuml;/    contained conceal cchar=Ü
    syn match abcSpecial /\C\\"u\|&uuml;/    contained conceal cchar=ü
    syn match abcSpecial /\C\\"Y\|&Yuml;/    contained conceal cchar=Ÿ
    syn match abcSpecial /\C\\"y\|&yuml;/    contained conceal cchar=ÿ
    syn match abcSpecial /\C\\cC\|&Ccedil;/  contained conceal cchar=Ç
    syn match abcSpecial /\C\\cc\|&ccedil;/  contained conceal cchar=ç
    syn match abcSpecial /\C\\AA\|&Aring;/   contained conceal cchar=Å
    syn match abcSpecial /\C\\aa\|&aring;/   contained conceal cchar=å
    syn match abcSpecial /\C\\\/O\|&Oslash;/ contained conceal cchar=Ø
    syn match abcSpecial /\C\\\/o\|&oslash;/ contained conceal cchar=ø
    syn match abcSpecial /\C\\uA\|&Abreve;/  contained conceal cchar=Ă
    syn match abcSpecial /\C\\ua\|&abreve;/  contained conceal cchar=ă
    syn match abcSpecial /\C\\uE/            contained conceal cchar=Ĕ
    syn match abcSpecial /\C\\ue/            contained conceal cchar=ĕ
    syn match abcSpecial /\C\\vS\|&Scaron;/  contained conceal cchar=Š
    syn match abcSpecial /\C\\vs\|&scaron;/  contained conceal cchar=š
    syn match abcSpecial /\C\\vZ\|&Zcaron;/  contained conceal cchar=Ž
    syn match abcSpecial /\C\\vz\|&zcaron;/  contained conceal cchar=ž
    syn match abcSpecial /\C\\HO/            contained conceal cchar=Ő
    syn match abcSpecial /\C\\Ho/            contained conceal cchar=ő
    syn match abcSpecial /\C\\HU/            contained conceal cchar=Ű
    syn match abcSpecial /\C\\Hu/            contained conceal cchar=ű
    syn match abcSpecial /\C\\AE\|&AElig;/   contained conceal cchar=Æ
    syn match abcSpecial /\C\\ae\|&aelig;/   contained conceal cchar=æ
    syn match abcSpecial /\C\\OE\|&OElig;/   contained conceal cchar=Œ
    syn match abcSpecial /\C\\oe\|&oelig;/   contained conceal cchar=œ
    syn match abcSpecial /\C\\ss\|&szlig;/   contained conceal cchar=ß
    syn match abcSpecial /\C\\DH\|&ETH;/     contained conceal cchar=Ð
    syn match abcSpecial /\C\\dh\|&eth;/     contained conceal cchar=ð
    syn match abcSpecial /\C\\TH\|&THORN;/   contained conceal cchar=Þ
    syn match abcSpecial /\C\\th\|&thorn;/   contained conceal cchar=þ
    syn match abcSpecial /\C&copy;/          contained conceal cchar=©
    syn match abcSpecial /\c&266d;/          contained conceal cchar=♭
    syn match abcSpecial /\c&266e;/          contained conceal cchar=♮
    syn match abcSpecial /\c&266f;/          contained conceal cchar=♯
    syn match abcSpecial /\C&quot;/          contained conceal cchar="
endif
if has("g:abc_utf == 1")
    " Literal character code in matches to be explicit
    syn match abcSpecial '\\\%x7500c0\|\\\%x7500C0' contained conceal cchar=À
    syn match abcSpecial '\\\%x7500e0\|\\\%x7500E0' contained conceal cchar=à
    syn match abcSpecial '\\\%x7500c8\|\\\%x7500C8' contained conceal cchar=È
    syn match abcSpecial '\\\%x7500e8\|\\\%x7500E8' contained conceal cchar=è
    syn match abcSpecial '\\\%x7500cc\|\\\%x7500CC' contained conceal cchar=Ì
    syn match abcSpecial '\\\%x7500ec' contained conceal cchar=ì
    syn match abcSpecial '\\\%x7500d2' contained conceal cchar=Ò
    syn match abcSpecial '\\\%x7500f2' contained conceal cchar=ò
    syn match abcSpecial '\\\%x7500d9' contained conceal cchar=Ù
    syn match abcSpecial '\\\%x7500f9' contained conceal cchar=ù
    syn match abcSpecial '\\\%x7500c1' contained conceal cchar=Á
    syn match abcSpecial '\\\%x7500e1' contained conceal cchar=á
    syn match abcSpecial '\\\%x7500c9' contained conceal cchar=É
    syn match abcSpecial '\\\%x7500e9' contained conceal cchar=é
    syn match abcSpecial '\\\%x7500cd' contained conceal cchar=Í
    syn match abcSpecial '\\\%x7500ed' contained conceal cchar=í
    syn match abcSpecial '\\\%x7500d3' contained conceal cchar=Ó
    syn match abcSpecial '\\\%x7500f3' contained conceal cchar=ó
    syn match abcSpecial '\\\%x7500da' contained conceal cchar=Ú
    syn match abcSpecial '\\\%x7500fa' contained conceal cchar=ú
    syn match abcSpecial '\\\%x7500dd' contained conceal cchar=Ý
    syn match abcSpecial '\\\%x7500fd' contained conceal cchar=ý
    syn match abcSpecial '\\\%x7500c2' contained conceal cchar=Â
    syn match abcSpecial '\\\%x7500e2' contained conceal cchar=â
    syn match abcSpecial '\\\%x7500ca' contained conceal cchar=Ê
    syn match abcSpecial '\\\%x7500ea' contained conceal cchar=ê
    syn match abcSpecial '\\\%x7500ce' contained conceal cchar=Î
    syn match abcSpecial '\\\%x7500ee' contained conceal cchar=î
    syn match abcSpecial '\\\%x7500d4' contained conceal cchar=Ô
    syn match abcSpecial '\\\%x7500f4' contained conceal cchar=ô
    syn match abcSpecial '\\\%x7500db' contained conceal cchar=Û
    syn match abcSpecial '\\\%x7500fb' contained conceal cchar=û
    syn match abcSpecial '\\\%x750176' contained conceal cchar=Ŷ
    syn match abcSpecial '\\\%x750177' contained conceal cchar=ŷ
    syn match abcSpecial '\\\%x7500c3' contained conceal cchar=Ã
    syn match abcSpecial '\\\%x7500e3' contained conceal cchar=ã
    syn match abcSpecial '\\\%x7500d1' contained conceal cchar=Ñ
    syn match abcSpecial '\\\%x7500f1' contained conceal cchar=ñ
    syn match abcSpecial '\\\%x7500d5' contained conceal cchar=Õ
    syn match abcSpecial '\\\%x7500f5' contained conceal cchar=õ
    syn match abcSpecial '\\\%x7500c4' contained conceal cchar=Ä
    syn match abcSpecial '\\\%x7500e4' contained conceal cchar=ä
    syn match abcSpecial '\\\%x7500cb' contained conceal cchar=Ë
    syn match abcSpecial '\\\%x7500eb' contained conceal cchar=ë
    syn match abcSpecial '\\\%x7500cf' contained conceal cchar=Ï
    syn match abcSpecial '\\\%x7500ef' contained conceal cchar=ï
    syn match abcSpecial '\\\%x7500d6' contained conceal cchar=Ö
    syn match abcSpecial '\\\%x7500f6' contained conceal cchar=ö
    syn match abcSpecial '\\\%x7500dc' contained conceal cchar=Ü
    syn match abcSpecial '\\\%x7500fc' contained conceal cchar=ü
    syn match abcSpecial '\\\%x750178' contained conceal cchar=Ÿ
    syn match abcSpecial '\\\%x7500ff' contained conceal cchar=ÿ
    syn match abcSpecial '\\\%x7500c7' contained conceal cchar=Ç
    syn match abcSpecial '\\\%x7500e7' contained conceal cchar=ç
    syn match abcSpecial '\\\%x7500c5' contained conceal cchar=Å
    syn match abcSpecial '\\\%x7500e5' contained conceal cchar=å
    syn match abcSpecial '\\\%x7500d8' contained conceal cchar=Ø
    syn match abcSpecial '\\\%x7500f8' contained conceal cchar=ø
    syn match abcSpecial '\\\%x750102' contained conceal cchar=Ă
    syn match abcSpecial '\\\%x750103' contained conceal cchar=ă
    syn match abcSpecial '\\\%x750114' contained conceal cchar=Ĕ
    syn match abcSpecial '\\\%x750115' contained conceal cchar=ĕ
    syn match abcSpecial '\\\%x750160' contained conceal cchar=Š
    syn match abcSpecial '\\\%x750161' contained conceal cchar=š
    syn match abcSpecial '\\\%x75017d' contained conceal cchar=Ž
    syn match abcSpecial '\\\%x75017e' contained conceal cchar=ž
    syn match abcSpecial '\\\%x750150' contained conceal cchar=Ő
    syn match abcSpecial '\\\%x750151' contained conceal cchar=ő
    syn match abcSpecial '\\\%x750170' contained conceal cchar=Ű
    syn match abcSpecial '\\\%x750171' contained conceal cchar=ű
    syn match abcSpecial '\\\%x7500c6' contained conceal cchar=Æ
    syn match abcSpecial '\\\%x7500e6' contained conceal cchar=æ
    syn match abcSpecial '\\\%x750152' contained conceal cchar=Œ
    syn match abcSpecial '\\\%x750153' contained conceal cchar=œ
    syn match abcSpecial '\\\%x7500df' contained conceal cchar=ß
    syn match abcSpecial '\\\%x7500d0' contained conceal cchar=Ð
    syn match abcSpecial '\\\%x7500f0' contained conceal cchar=ð
    syn match abcSpecial '\\\%x7500de' contained conceal cchar=Þ
    syn match abcSpecial '\\\%x7500fe' contained conceal cchar=þ
    syn match abcSpecial '\\\%x7500a9' contained conceal cchar=©
    syn match abcSpecial '\\\%x75266d' contained conceal cchar=♭
    syn match abcSpecial '\\\%x75266e' contained conceal cchar=♮
    syn match abcSpecial '\\\%x75266f' contained conceal cchar=♯
    syn match abcSpecial '\\\%x750022' contained conceal cchar="
endif
syn match abcSpecialChar '\\%'
syn match abcSpecialChar '\\\\'
syn match abcSpecialChar '\\\&'
syn match abcSpecialChar '\$[0-4]'
" }}}
" Strings {{{
syn cluster abcSpecialChars contains=abcSpecialChar,abcSpecial
" Chord Symbols
syn match abcChordNote '[A-G]\%(b\|#\)\=' contained
syn keyword abcChordType contained m[in] maj dim aug + sus nextgroup=abcChordBass
syn match abcChordType '\d\+' contained contains=abcInteger nextgroup=abcChordBass
syn match abcChordBass '\/[A-G]' contained
syn match abcChordSymbol /"[A-G]\%(b\|#\)\=/ contained contains=abcChordNote nextgroup=abcChordType
syn match abcAnnotation /"\%(^\|_\|<\|>\|@\)/ contained
syn region abcString matchgroup=abcChordSymbol start=/"/
    \ matchgroup=NONE skip=/[^%]*/
    \ end=/"/ keepend oneline contains=abcLineCont
syn region abcString matchgroup=abcAnnotation start=/"/
    \ matchgroup=NONE skip=/[^%]*/
    \ end=/"/ keepend oneline contains=@abcPS,@abcSpecialChars
" }}}
" }}}
" Statements {{{
" Fields {{{
syn keyword abcStringFieldIdentifier contained A: B: C: D: F: G: H: N: O: R: S: Z:
syn keyword abcInstructionIdentifier contained I:
syn keyword abcLengthIdentifier contained L:
syn keyword abcMacroIdentifier contained m:
syn keyword abcMeterIdentifier contained M:
syn keyword abcPartsIdentifier contained P:
syn keyword abcTempoIdentifier contained Q:
syn keyword abcSymbolsIdentifier contained s:
syn keyword abcUserdefIdentifier contained U:
syn keyword abcVoiceIdentifier contained V:
syn keyword abcLyricsIdentifier contained w:
syn keyword abcWordsIdentifier contained W:
syn keyword abcTitleIdentifier contained T:
syn keyword abcIndexIdentifier contained X:
syn keyword abcKeyIdentifier contained K:
syn keyword abcFieldContIdentifier contained +:

syn region abcStringField
    \ matchgroup=abcStringFieldIdentifier start='^[A-DF-HNORSZ]:'
    \ skip='[^%]*' excludenl end='$'

syn cluster abcFieldIdentifier
    \ contains=abcStringFieldIdentifier,abcInstructionIdentifier,abcLengthIdentifier,abcMacroIdentifier,abcMeterIdentifier,abcPartsIdentifier,abcTempoIdentifier,abcSymbolsIdentifier,abcUserdefIdentifier,abcVoiceIdentifier,abcLyricsIdentifier,abcWordsIdentifier,abcTitleIdentifier,abcIndexIdentifier,abcKeyIdentifier,abcFieldContinueIdentifier
syn region abcFieldStatement matchgroup=@abcFieldIdentifier start='^\a:'
    \ matchgroup=NONE skip='[^%]*' excludenl end='$'
" }}}
" Code {{{
" Operators & Delimiters {{{

syn keyword abcOperator contained ! $ ^ _ ( ) { }
syn match abcLineCont excludenl '\\\s*$' contained
" }}}
" Repeats {{{

" }}}
" Voices {{{

" }}}
" Parts {{{

" }}}
" Note Operators & Decorations {{{
" Grace Notes
syn region abcGraceNotes start='{\/\=' end='}' contained
    \ contains= keepend oneline


" }}}
" Notes & Rests {{{

" }}}
" }}}
" }}}
" Blocks {{{
" Typeset Text {{{
syn region abcTypesetText start='^%%beginps' end='^%%endps' fold contains=@abcPS
syn region abcTypesetText start='^%%beginsvg' end='^%%endsvg' fold contains=@abcXML

syn region abcTypesetText start='^%%begintext \%(obeylines\|align\|justify\|ragged\|fill\|center\|skip\|right\)\=' end='^%%endtext' fold
" }}}
" File Header {{{
syn region abcFileHeader start='' end='' contains=
" }}}
" Tune {{{
" Header
syn region abcTuneHeader start='\%(^X:.*$\)\{1}\%(T:.*$\)*' excludenl skip='^\%([A-DF-IL-SU-WZm]:\|%\{1}\).*$'
    \ excludenl end='^K:.*$' keepend
" Body
syn region abcTuneBody start='\%(^K:.$\)\zs' excludenl end='^\s*$' keepend fold contains=abcLineCont
" }}}
" Note Groups {{{

" NOTE-ELEMENT order:
" (<grace notes>?, <chord symbols>*, (<annotations>|<decorations>)*,
" <accidentals>*, <note>, <octave>*, <note length>?), <tie>?, <beam>*

" Slur Group order:
" <chord symbols>, '(', <NOTE-ELEMENT>+, ')'?

" Chord/Unison Group order:
" <chord symbols>, '[', (<NOTE-ELEMENT>+ | (<NOTE-ELEMENT>, <overlay>,
" <NOTE-ELEMENT>)*), ']', <note length>?, (<tie>|<beam>)?

" }}}
" }}}
" Highlighting {{{
if version >= 508 || !exists("did_abc_syntax_inits")
    if version < 508
        let did_abc_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif
    " TODO
hi link abcTypesetText 
hi link abcFontKeyword Label
hi link abcBoolean Boolean
hi link abcHex Number
hi link abcInteger Number
hi link abcFloat Float
hi link abcTodo Todo
hi link abcComment Comment
hi link abcDirective PreProc
hi link abcUnit Constant
hi link abcTitle Title
hi link abcSpecialComment PreCondit
hi link abcInstructionField PreProc
hi link abcFieldIdentifier Identifier

hi link abcStringField String

      "HiLink <group> <hiGroup>
      delcommand HiLink
endif
" }}}
" Title*
" ErrorMsg*
" WarningMsg*
" SpellBad*
" SpellCap*
" SpellRare*
" SpellLocal*
" Constant* String Character Number Boolean Float
" Special* Tag SpecialChar Delimiter SpecialComment Debug
" Identifier* Function Subtitle
" Statement* Conditional Repeat Label Operator Keyword Exception
" PreProc* Include Define Macro PreCondit
" Type* StorageClass Structure Typedef
" Underlined*
" Error*
" Todo*
" vimPatRegion*
let b:current_syntax = 'abc'
"vim:ts=4
