" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
./autoload/abc.vim	[[[1
11
" Vim completion script
" Language: abc music programming language
" Maintainer: Lee Savide <leesavide@gmail.com>
" Version: 0.1
" Last Change: 2012-05-09 Wed 08:42 PM
" License: http://www.apache.org/licenses/LICENSE-2.0.html
" See Also: http://www.ietf.org/rfc/rfc2119.txt
" GetLatestScript:


" vim:set foldmethod=marker:
./ftplugin/abc.vim	[[[1
20
" Vim ftplugin file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
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

./plugin/abc-plugin.vim	[[[1
71
" Author: Lee Savide <laughingman182@gmail.com>
" Version: 0.1
" GetLatestVimScripts: 
" Description: {{{
" Note: 
"
" }}}
"
" License: {{{
"    Copyright 2012 Lee Savide

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
"
" }}}

if v:version < 700
  finish
endif

let s:save_cpo=&cpo
set cpo&vim

" Global Variables {{{

  if !exists("g:AbcDefaultVersion")
    let g:AbcDefaultVersion = "2.1"
  endif

  if !exists("g:AbcErrors")
    let g:AbcErrors = ""
  endif

  if !exists("g:AbcWarnings")
    let g:AbcWarnings = ""
  endif

" }}}

" Script Variables {{{
  let s:abcHelp =
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ "" .
    \ ""

  let s:types = ""
  let s:modes = ''
" }}}
./syntax/abc.vim	[[[1
363
" Vim syntax file
" Language: abc music notation includes
" Maintainer: Lee Savide <laughingman182@gmail.com>
" Last Change: 2012-06-28 Thu 11:05 PM
" GetLatestVimScripts: ### ### yourscriptname
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
" Load PostScript and SVG syntax. PostScript is native to abc code, SVG is to
" support SVG content. HTML code is technically supported this way, for XHTML.


if !exists("main_syntax")
    runtime! syntax/postscr.vim
    unlet b:current_syntax
    runtime! syntax/svg.vim
    unlet b:current_syntax
    if version < 600
        syntax clear " Clear the syntax
        syntax sync clear " Clear the syntax syncing
    elseif has("b:current_syntax=1")
        finish
    endif
    let main_syntax = "abh"
endif

" Take the priority for PostScript datatypes & primitives
syn case ignore
syn match abcHex "\<\x\{2,}\>"
" Integers
syn match abcInteger "\<[+-]\=\d\+\>"
" Radix
syn match abcRadix "\d\+#\x\+\>"
" Reals - upper and lower case e is allowed
syn match abcFloat "[+-]\=\d\+\.\>" contained
syn match abcFloat "[+-]\=\d\+\.\d*\(e[+-]\=\d\+\)\=\>" contained
syn match abcFloat "[+-]\=\.\d\+\(e[+-]\=\d\+\)\=\>" contained
syn match abcFloat "[+-]\=\d\+e[+-]\=\d\+\>" contained
syn cluster abcNumber contains=abcInteger,abcRadix,abcFloat
" }}}
syn case match
" Free text has least priority
syn region abcFreeText start="^\s*$" excludenl skip="\_.$" excludenl end="^\s*$" contains=abcEscapeChar,abcEntity
" Comments {{{
" Remark fields should be treated as abc's form of multiline comments. For
" normal comments, you ought to use the single percent sign, '%', but for
" multiline comments, it ought to be accepted that any form of comment in abc is
" meant to be ignored by parsers. Whether the remark, either as a normal or
" inline field, is continued, the parser won't care. It's a comment, and it's
" not important to the code...it's for the composer's convienience.}}}
syn region abcRemark start="^r:" excludenl end="$" oneline keepend nextgroup=abcFieldContinue skipwhite skipnl fold
syn region abcRemark start="\[r:[^%]*" end="\]" contained keepend fold
" BOM Markers {{{
" EF BB BF
"   utf-8
" FE FF
" utf-16 big endian
" FF FE
" utf-16 little endian
" 00 00 FE FF
" utf-32 big endian
" FF FE 00 00
" utf-32 little endian
" }}}
" External syntax clusters {{{
" abcPostScript contains all toplevel PostScript items
syn cluster abcPostScript contains=postscrComment,postscrConstant,postscrString,postscrNumber,postscrFloat,postscrBoolean,postscrIdentifier,postscrProcedure,postscrName,postscrConditional,postscrRepeat,postscrOperator,postscrDSCComment,postscrSpecialChar,postscrTodo,postscrError,postscrGSOperator,postscrGSMathOperator
" abcXML contains all toplevel XML syntax items
syn cluster abcXML contains=xmlTodo,xmlTag,xmlTagName,xmlEndTag,xmlNamespace,xmlEntity,xmlEntityPunct,xmlAttribPunct,xmlAttrib,xmlString,xmlComment,xmlCommentPart,xmlCommentError,xmlError,xmlProcessingDelim,xmlProcessing,xmlCdata,xmlCdataCdata,xmlCdataStart,xmlCdataEnd,xmlDocTypeDecl,xmlDocTypeKeyword,xmlInlineDTD
" }}}
" Entities {{{
" NOTE: Even though the Unicode C string sequences ought to allow mixed case for
" the hexadecimal characters, the initial '\u' is required to be lowercase, or
" the sequence would represent a 16-bit Unicode character. So case preserving it
" is.
syn match abcEntity "\C\\`A\|&Agrave;\|\\u00c0"  contained conceal cchar=À
syn match abcEntity "\C\\`a\|&agrave;\|\\u00e0"  contained conceal cchar=à
syn match abcEntity "\C\\`E\|&Egrave;\|\\u00c8"  contained conceal cchar=È
syn match abcEntity "\C\\`e\|&egrave;\|\\u00e8"  contained conceal cchar=è
syn match abcEntity "\C\\`I\|&Igrave;\|\\u00cc"  contained conceal cchar=Ì
syn match abcEntity "\C\\`i\|&igrave;\|\\u00ec"  contained conceal cchar=ì
syn match abcEntity "\C\\`O\|&Ograve;\|\\u00d2"  contained conceal cchar=Ò
syn match abcEntity "\C\\`o\|&ograve;\|\\u00f2"  contained conceal cchar=ò
syn match abcEntity "\C\\`U\|&Ugrave;\|\\u00d9"  contained conceal cchar=Ù
syn match abcEntity "\C\\`u\|&ugrave;\|\\u00f9"  contained conceal cchar=ù
syn match abcEntity "\C\\'A\|&Aacute;\|\\u00c1"  contained conceal cchar=Á
syn match abcEntity "\C\\'a\|&aacute;\|\\u00e1"  contained conceal cchar=á
syn match abcEntity "\C\\'E\|&Eacute;\|\\u00c9"  contained conceal cchar=É
syn match abcEntity "\C\\'e\|&eacute;\|\\u00e9"  contained conceal cchar=é
syn match abcEntity "\C\\'I\|&Iacute;\|\\u00cd"  contained conceal cchar=Í
syn match abcEntity "\C\\'i\|&iacute;\|\\u00ed"  contained conceal cchar=í
syn match abcEntity "\C\\'O\|&Oacute;\|\\u00d3"  contained conceal cchar=Ó
syn match abcEntity "\C\\'o\|&oacute;\|\\u00f3"  contained conceal cchar=ó
syn match abcEntity "\C\\'U\|&Uacute;\|\\u00da"  contained conceal cchar=Ú
syn match abcEntity "\C\\'u\|&uacute;\|\\u00fa"  contained conceal cchar=ú
syn match abcEntity "\C\\'Y\|&Yacute;\|\\u00dd"  contained conceal cchar=Ý
syn match abcEntity "\C\\'y\|&yacute;\|\\u00fd"  contained conceal cchar=ý
syn match abcEntity "\C\\^A\|&Acirc;\|\\u00c2"   contained conceal cchar=Â
syn match abcEntity "\C\\^a\|&acirc;\|\\u00e2"   contained conceal cchar=â
syn match abcEntity "\C\\^E\|&Ecirc;\|\\u00ca"   contained conceal cchar=Ê
syn match abcEntity "\C\\^e\|&ecirc;\|\\u00ea"   contained conceal cchar=ê
syn match abcEntity "\C\\^I\|&Icirc;\|\\u00ce"   contained conceal cchar=Î
syn match abcEntity "\C\\^i\|&icirc;\|\\u00ee"   contained conceal cchar=î
syn match abcEntity "\C\\^O\|&Ocirc;\|\\u00d4"   contained conceal cchar=Ô
syn match abcEntity "\C\\^o\|&ocirc;\|\\u00f4"   contained conceal cchar=ô
syn match abcEntity "\C\\^U\|&Ucirc;\|\\u00db"   contained conceal cchar=Û
syn match abcEntity "\C\\^u\|&ucirc;\|\\u00fb"   contained conceal cchar=û
syn match abcEntity "\C\\^Y\|&Ycirc;\|\\u0176"   contained conceal cchar=Ŷ
syn match abcEntity "\C\\^y\|&ycirc;\|\\u0177"   contained conceal cchar=ŷ
syn match abcEntity "\C\\~A\|&Atilde;\|\\u00c3"  contained conceal cchar=Ã
syn match abcEntity "\C\\~a\|&atilde;\|\\u00e3"  contained conceal cchar=ã
syn match abcEntity "\C\\~N\|&Ntilde;\|\\u00d1"  contained conceal cchar=Ñ
syn match abcEntity "\C\\~n\|&ntilde;\|\\u00f1"  contained conceal cchar=ñ
syn match abcEntity "\C\\~O\|&Otilde;\|\\u00d5"  contained conceal cchar=Õ
syn match abcEntity "\C\\~o\|&otilde;\|\\u00f5"  contained conceal cchar=õ
syn match abcEntity /\C\\"A\|&Auml;\|\\u00c4/    contained conceal cchar=Ä
syn match abcEntity /\C\\"a\|&auml;\|\\u00e4/    contained conceal cchar=ä
syn match abcEntity /\C\\"E\|&Euml;\|\\u00cb/    contained conceal cchar=Ë
syn match abcEntity /\C\\"e\|&euml;\|\\u00eb/    contained conceal cchar=ë
syn match abcEntity /\C\\"I\|&Iuml;\|\\u00cf/    contained conceal cchar=Ï
syn match abcEntity /\C\\"i\|&iuml;\|\\u00ef/    contained conceal cchar=ï
syn match abcEntity /\C\\"O\|&Ouml;\|\\u00d6/    contained conceal cchar=Ö
syn match abcEntity /\C\\"o\|&ouml;\|\\u00f6/    contained conceal cchar=ö
syn match abcEntity /\C\\"U\|&Uuml;\|\\u00dc/    contained conceal cchar=Ü
syn match abcEntity /\C\\"u\|&uuml;\|\\u00fc/    contained conceal cchar=ü
syn match abcEntity /\C\\"Y\|&Yuml;\|\\u0178/    contained conceal cchar=Ÿ
syn match abcEntity /\C\\"y\|&yuml;\|\\u00ff/    contained conceal cchar=ÿ
syn match abcEntity "\C\\cC\|&Ccedil;\|\\u00c7"  contained conceal cchar=Ç
syn match abcEntity "\C\\cc\|&ccedil;\|\\u00e7"  contained conceal cchar=ç
syn match abcEntity "\C\\AA\|&Aring;\|\\u00c5"   contained conceal cchar=Å
syn match abcEntity "\C\\aa\|&aring;\|\\u00e5"   contained conceal cchar=å
syn match abcEntity "\C\\\/O\|&Oslash;\|\\u00d8" contained conceal cchar=Ø
syn match abcEntity "\C\\\/o\|&oslash;\|\\u00f8" contained conceal cchar=ø
syn match abcEntity "\C\\uA\|&Abreve;\|\\u0102"  contained conceal cchar=Ă
syn match abcEntity "\C\\ua\|&abreve;\|\\u0103"  contained conceal cchar=ă
syn match abcEntity "\C\\uE\|\\u0114"            contained conceal cchar=Ĕ
syn match abcEntity "\C\\ue\|\\u0115"            contained conceal cchar=ĕ
syn match abcEntity "\C\\vS\|&Scaron;\|\\u0160"  contained conceal cchar=Š
syn match abcEntity "\C\\vs\|&scaron;\|\\u0161"  contained conceal cchar=š
syn match abcEntity "\C\\vZ\|&Zcaron;\|\\u017d"  contained conceal cchar=Ž
syn match abcEntity "\C\\vz\|&zcaron;\|\\u017e"  contained conceal cchar=ž
syn match abcEntity "\C\\HO\|\\u0150"            contained conceal cchar=Ő
syn match abcEntity "\C\\Ho\|\\u0151"            contained conceal cchar=ő
syn match abcEntity "\C\\HU\|\\u0170"            contained conceal cchar=Ű
syn match abcEntity "\C\\Hu\|\\u0171"            contained conceal cchar=ű
syn match abcEntity "\C\\AE\|&AElig;\|\\u00c6"   contained conceal cchar=Æ
syn match abcEntity "\C\\ae\|&aelig;\|\\u00e6"   contained conceal cchar=æ
syn match abcEntity "\C\\OE\|&OElig;\|\\u0152"   contained conceal cchar=Œ
syn match abcEntity "\C\\oe\|&oelig;\|\\u0153"   contained conceal cchar=œ
syn match abcEntity "\C\\ss\|&szlig;\|\\u00df"   contained conceal cchar=ß
syn match abcEntity "\C\\DH\|&ETH;\|\\u00d0"     contained conceal cchar=Ð
syn match abcEntity "\C\\dh\|&eth;\|\\u00f0"     contained conceal cchar=ð
syn match abcEntity "\C\\TH\|&THORN;\|\\u00de"   contained conceal cchar=Þ
syn match abcEntity "\C\\th\|&thorn;\|\\u00fe"   contained conceal cchar=þ
syn match abcEntity "\C&copy;\|\\u00a9"          contained conceal cchar=©
syn match abcEntity "\c&266d;\|\\u266d"          contained conceal cchar=♭
syn match abcEntity "\c&266e;\|\\u266e"          contained conceal cchar=♮
syn match abcEntity "\c&266f;\|\\u266f"          contained conceal cchar=♯
syn match abcEntity "\C&quot;\|\\u0022" contained conceal cchar="
" }}}
syn match abcEscapeChar "\\%" contained
syn match abcEscapeChar "\\\\" contained
syn match abcEscapeChar "\\\&" contained

syn match abcSetFontChar "\$[0-4]" contained

syn match abcQuoteChar /"/ contained
syn match abcReservedChar "#\|\*\|;\|?\|@" contained
syn match abcBarChar "\%(|\|\[\|\]\)\{1,2}" contained

" abc Comments = PostScript Comments (postscrComment)

syn keyword abcBoolean contained true false on off yes no
syn match abcBoolean contained "1\|0"

syn keyword abcSize contained in cm pt
syn keyword abcEncoding contained us-ascii utf-8 iso-8859-1 latin1 iso-8859-2 latin2 iso-8859-3 latin3 iso-8859-4 latin4 iso-8859-9 latin5 iso-8859-10 latin6
"syn keyword abcDirectiveLock contained lock
" Lock Keyword {{{
" 'lock' is allowed in all directives, and must set that a setting is no longer
" able to be set any where else in the same tune. If contained on a global, it
" sets that the directive is unsettable in all tunes.
" }}}
" Fonts {{{
syn keyword abcFont contained AlbertusMT AlbertusMT-Italic AlbertusMT-Light Apple-Chancery Apple-ChanceryCE
syn keyword abcFont contained AntiqueOlive-Roman AntiqueOlive-Italic AntiqueOlive-Bold AntiqueOlive-Compact
syn keyword abcFont contained AntiqueOliveCE-Roman AntiqueOliveCE-Italic AntiqueOliveCE-Bold AntiqueOliveCE-Compact
syn keyword abcFont contained ArialMT Arial-ItalicMT Arial-LightMT Arial-BoldMT Arial-BoldItalicMT
syn keyword abcFont contained ArialCE ArialCE-Italic ArialCE-Light ArialCE-Bold ArialCE-BoldItalic
syn keyword abcFont contained AvantGarde-Book AvantGarde-BookOblique AvantGarde-Demi AvantGarde-DemiOblique
syn keyword abcFont contained AvantGardeCE-Book AvantGardeCE-BookOblique AvantGardeCE-Demi AvantGardeCE-DemiOblique
syn keyword abcFont contained Bodoni Bodoni-Italic Bodoni-Bold Bodoni-BoldItalic Bodoni-Poster Bodoni-PosterCompressed
syn keyword abcFont contained BodoniCE BodoniCE-Italic BodoniCE-Bold BodoniCE-BoldItalic BodoniCE-Poster BodoniCE-PosterCompressed
syn keyword abcFont contained Bookman-Light Bookman-LightItalic Bookman-Demi Bookman-DemiItalic
syn keyword abcFont contained BookmanCE-Light BookmanCE-LightItalic BookmanCE-Demi BookmanCE-DemiItalic
syn keyword abcFont contained Carta Chicago ChicagoCE Clarendon Clarendon-Light Clarendon-Bold
syn keyword abcFont contained ClarendonCE ClarendonCE-Light ClarendonCE-Bold CooperBlack CooperBlack-Italic
syn keyword abcFont contained Copperplate-ThirtyTwoBC CopperPlate-ThirtyThreeBC Coronet-Regular CoronetCE-Regular
syn keyword abcFont contained CourierCE CourierCE-Oblique CourierCE-Bold CourierCE-BoldOblique
syn keyword abcFont contained Eurostile Eurostile-Bold Eurostile-ExtendedTwo Eurostile-BoldExtendedTwo
syn keyword abcFont contained Eurostile EurostileCE-Bold EurostileCE-ExtendedTwo EurostileCE-BoldExtendedTwo
syn keyword abcFont contained Geneva GenevaCE GillSans GillSans-Italic GillSans-Bold GillSans-BoldItalic GillSans-BoldCondensed
syn keyword abcFont contained GillSans-Light GillSans-LightItalic GillSans-ExtraBold
syn keyword abcFont contained GillSansCE-Roman GillSansCE-Italic GillSansCE-Bold GillSansCE-BoldItalic GillSansCE-BoldCondensed
syn keyword abcFont contained GillSansCE-Light GillSansCE-LightItalic GillSansCE-ExtraBold
syn keyword abcFont contained Goudy Goudy-Italic Goudy-Bold Goudy-BoldItalic Goudy-ExtraBould
syn keyword abcFont contained HelveticaCE HelveticaCE-Oblique HelveticaCE-Bold HelveticaCE-BoldOblique
syn keyword abcFont contained Helvetica-Condensed Helvetica-Condensed-Oblique Helvetica-Condensed-Bold Helvetica-Condensed-BoldObl
syn keyword abcFont contained HelveticaCE-Condensed HelveticaCE-Condensed-Oblique HelveticaCE-Condensed-Bold
syn keyword abcFont contained HelveticaCE-Condensed-BoldObl Helvetica-Narrow Helvetica-Narrow-Oblique Helvetica-Narrow-Bold
syn keyword abcFont contained Helvetica-Narrow-BoldOblique HelveticaCE-Narrow HelveticaCE-Narrow-Oblique HelveticaCE-Narrow-Bold
syn keyword abcFont contained HelveticaCE-Narrow-BoldOblique HoeflerText-Regular HoeflerText-Italic HoeflerText-Black
syn keyword abcFont contained HoeflerText-BlackItalic HoeflerText-Ornaments HoeflerTextCE-Regular HoeflerTextCE-Italic
syn keyword abcFont contained HoeflerTextCE-Black HoeflerTextCE-BlackItalic
syn keyword abcFont contained JoannaMT JoannaMT-Italic JoannaMT-Bold JoannaMT-BoldItalic
syn keyword abcFont contained JoannaMTCE JoannaMTCE-Italic JoannaMTCE-Bold JoannaMTCE-BoldItalic
syn keyword abcFont contained LetterGothic LetterGothic-Slanted LetterGothic-Bold LetterGothic-BoldSlanted
syn keyword abcFont contained LetterGothicCE LetterGothicCE-Slanted LetterGothicCE-Bold LetterGothicCE-BoldSlanted
syn keyword abcFont contained LubalinGraph-Book LubalinGraph-BookOblique LubalinGraph-Demi LubalinGraph-DemiOblique
syn keyword abcFont contained LubalinGraphCE-Book LubalinGraphCE-BookOblique LubalinGraphCE-Demi LubalinGraphCE-DemiOblique
syn keyword abcFont contained Marigold Monaco MonacoCE MonaLisa-Recut Oxford Symbol Tekton
syn keyword abcFont contained NewCennturySchlbk-Roman NewCenturySchlbk-Italic NewCenturySchlbk-Bold NewCenturySchlbk-BoldItalic
syn keyword abcFont contained NewCenturySchlbkCE-Roman NewCenturySchlbkCE-Italic NewCenturySchlbkCE-Bold
syn keyword abcFont contained NewCenturySchlbkCE-BoldItalic NewYork NewYorkCE
syn keyword abcFont contained Optima Optima-Italic Optima-Bold Optima-BoldItalic
syn keyword abcFont contained OptimaCE OptimaCE-Italic OptimaCE-Bold OptimaCE-BoldItalic
syn keyword abcFont contained Palatino-Roman Palatino-Italic Palatino-Bold Palatino-BoldItalic
syn keyword abcFont contained PalatinoCE-Roman PalatinoCE-Italic PalatinoCE-Bold PalatinoCE-BoldItalic
syn keyword abcFont contained StempelGaramond-Roman StempelGaramond-Italic StempelGaramond-Bold StempelGaramond-BoldItalic
syn keyword abcFont contained StempelGaramondCE-Roman StempelGaramondCE-Italic StempelGaramondCE-Bold StempelGaramondCE-BoldItalic
syn keyword abcFont contained TimesCE-Roman TimesCE-Italic TimesCE-Bold TimesCE-BoldItalic
syn keyword abcFont contained TimesNewRomanPSMT TimesNewRomanPS-ItalicMT TimesNewRomanPS-BoldMT TimesNewRomanPS-BoldItalicMT
syn keyword abcFont contained TimesNewRomanCE TimesNewRomanCE-Italic TimesNewRomanCE-Bold TimesNewRomanCE-BoldItalic
syn keyword abcFont contained Univers Univers-Oblique Univers-Bold Univers-BoldOblique
syn keyword abcFont contained UniversCE-Medium UniversCE-Oblique UniversCE-Bold UniversCE-BoldOblique
syn keyword abcFont contained Univers-Light Univers-LightOblique UniversCE-Light UniversCE-LightOblique
syn keyword abcFont contained Univers-Condensed Univers-CondensedOblique Univers-CondensedBold Univers-CondensedBoldOblique
syn keyword abcFont contained UniversCE-Condensed UniversCE-CondensedOblique UniversCE-CondensedBold UniversCE-CondensedBoldOblique
syn keyword abcFont contained Univers-Extended Univers-ExtendedObl Univers-BoldExt Univers-BoldExtObl
syn keyword abcFont contained UniversCE-Extended UniversCE-ExtendedObl UniversCE-BoldExt UniversCE-BoldExtObl
syn keyword abcFont contained Wingdings-Regular ZapfChancery-MediumItalic ZapfChanceryCE-MediumItalic ZapfDingBats

syn keyword abcFontEncoding contained utf-8 us-ascii native
" }}}


syn match abcBeginText "^%%begintext \%(justify\|\)" contained
syn region abcTypesetText start="^%%begintext\%( \%(obeylines\|align\|justify\|ragged\|fill\|center\|skip\|right\)\)\=" end="^%%endtext" contains=abcTextOption




syn region abcPSDirective start="%%beginps" end="%%endps" contains=@abcPostScript
syn region abcSVGDirective start="" end="" contains=@abcXML

syn region abcDirective start="^\%(I:\|%%\)\h[\w\d-]*" excludenl end=" " contains=abcBoolDirective,abcFontDirective,abcUnitDirective,abcIntDirective,abcTextDirective,abcFloatDirective,abcMiscDirective
syn match abcDirective "^%%repbra" nextgroup=abcBoolean skipwhite
syn match abcDirective "%%tuplets" nextgroup=abcInteger,abcInteger,abcInteger skipwhite
syn match abcDirective "^%%\%(newpage\|setbarnb\)" nextgroup=abcInteger

syn keyword abcBoolDirective abc2pscompat autoclef breakoneoln bstemdown comball combinevoices contbarnb continueall custos dynalign gchordbox graceslurs hyphencont infoline landscape linewarn measurebox musiconly oneperpage pango partsbox setdefl shiftunisson splittune squarebreve staffnonote straightflags stretchlast stretchstaff timewarn titleleft titletrim  vocalabove contained nextgroup=abcBoolean

syn keyword abcIntDirective alignbars aligncomposer barnumbers dynamic gchord measurefirst measurenb ornament pdfmark textoption vocal volume
"'encoding' allows for integer arguments
syn match abcDirective "^%%staff" nextgroup=abcInteger skipwhite " the integer must be signed
syn match abcDirective "transpose" " REQUIRES an integer, and can include an optional '#' or 'b'
"'tablature' includes an integer

" TODO - float directives
"lineskipfac maxshrink notespacingfactor parskipfac scale slurheight stemheight 
"'gracespace' uses 3 floats




syn match abcRepeatEnd "\%(|\|\[\)\%([1-9]\%([,-][2-9]\)*\)\=" contained



syn match abcString "[^%]*" contains=abcSetFont,abcEntity,abcEscapeChar contained
syn region abcString contains=abcSetFont,abcEntity,abcEscapeChar matchgroup=abcQuoteChar start=/"/ end=/"/ matchgroup=abcFieldIdentifier start=/^[A-DGHNO+]:\zs[^%]*/ matchgroup=NONE excludenl end=/$/
syn region abcString start="^F:\zs[^#]*" excludenl end="$" oneline contains=abcEscapeChar


syn match abcFieldID "^[^r]:"













syn match abcFieldContinue "^+:" contained extend









syn region abcRepeat start="\z(|\|\[\|\]\)\z(:\+\)" skip="::\|:|:\|:||:\|\z1[1-9]\%([,-][2-9]\)*" end="\z2\z1" keepend contains=BarChar,RepeatBarChar,RepeatEnd
" containedin=abcCodeLine

" COMPLETED {{{
syn region abcTune matchgroup=TuneStart start="^X:" excludenl end="^\s*$" contains=TuneHeader,TuneBody,TypesetText fold
syn match abcVersion "%abc\%(-[1-9]\.\d\)\=" nextgroup=Comment,FileHeader skipwhite skipnl
syn region abcFile start="\%^" matchgroup=abcVersion start="^%abc" matchgroup=NONE end="\%$" contains=ALL
" }}}


if version >= 508 || !exists("did_abc_syntax_inits")
    if version < 508
        let did_abc_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif
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

      "HiLink <group> <hiGroup>
      delcommand HiLink
endif

let b:current_syntax = "abc"

"vim:ts=4
./syntax/abh.vim	[[[1
44
" Vim syntax file
" Language: abc music notation includes
" Maintainer: Lee Savide <laughingman182@gmail.com>
" Last Change:
" GetLatestVimScripts: ### ### yourscriptname
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

if version > 600
    syntax clear
elseif has("b:current_syntax=1")
    finish
endif










" Directives specific for external formatting
"break clip select tune voice 
" The above directives all use 'vimPatRegion' for highlighting. It's preloaded
" from starting Vim, and it includes all the proper highlights for regular
" expressions.

"vim:ts=4:sw=4:fdm=marker:fdc=3
./syntax/fmt.vim	[[[1
228
" Vim syntax file
" Language: abc format file
" Maintainer: Lee Savide <laughingman182@gmail.com>
" Last Change:
" GetLatestVimScripts: ### ### yourscriptname
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

if !exists("main_syntax")
    if version < 600
        syntax clear " Clear the syntax
    elseif has("b:current_syntax=1")
        finish
    endif
    let main_syntax = "abh"
endif

" Take the priority for PostScript datatypes & primitives.
syn case ignore
" PostScript syntax items {{{
syn match abcfmtHex "\<\x\{2,}\>"
" Integers
syn match abcfmtInteger "\<[+-]\=\d\+\>"
" Radix
syn match abcfmtRadix "\d\+#\x\+\>"
" Reals - upper and lower case e is allowed
syn match abcfmtFloat "[+-]\=\d\+\.\>" contained
syn match abcfmtFloat "[+-]\=\d\+\.\d*\(e[+-]\=\d\+\)\=\>" contained
syn match abcfmtFloat "[+-]\=\.\d\+\(e[+-]\=\d\+\)\=\>" contained
syn match abcfmtFloat "[+-]\=\d\+e[+-]\=\d\+\>" contained
syn cluster abcfmtNumber contains=abcfmtInteger,abcfmtRadix,abcfmtFloat
" }}}
syn case match

" Entities {{{
" NOTE: Even though the Unicode C string sequences ought to allow mixed case for
" the hexadecimal characters, the initial '\u' is required to be lowercase, or
" the sequence would represent a 16-bit Unicode character. So case preserving it
" is.
syn match abcfmtEntity /\C\\`A\|&Agrave;\|\\u00c0/  contained conceal cchar=À
syn match abcfmtEntity /\C\\`a\|&agrave;\|\\u00e0/  contained conceal cchar=à
syn match abcfmtEntity /\C\\`E\|&Egrave;\|\\u00c8/  contained conceal cchar=È
syn match abcfmtEntity /\C\\`e\|&egrave;\|\\u00e8/  contained conceal cchar=è
syn match abcfmtEntity /\C\\`I\|&Igrave;\|\\u00cc/  contained conceal cchar=Ì
syn match abcfmtEntity /\C\\`i\|&igrave;\|\\u00ec/  contained conceal cchar=ì
syn match abcfmtEntity /\C\\`O\|&Ograve;\|\\u00d2/  contained conceal cchar=Ò
syn match abcfmtEntity /\C\\`o\|&ograve;\|\\u00f2/  contained conceal cchar=ò
syn match abcfmtEntity /\C\\`U\|&Ugrave;\|\\u00d9/  contained conceal cchar=Ù
syn match abcfmtEntity /\C\\`u\|&ugrave;\|\\u00f9/  contained conceal cchar=ù
syn match abcfmtEntity /\C\\'A\|&Aacute;\|\\u00c1/  contained conceal cchar=Á
syn match abcfmtEntity /\C\\'a\|&aacute;\|\\u00e1/  contained conceal cchar=á
syn match abcfmtEntity /\C\\'E\|&Eacute;\|\\u00c9/  contained conceal cchar=É
syn match abcfmtEntity /\C\\'e\|&eacute;\|\\u00e9/  contained conceal cchar=é
syn match abcfmtEntity /\C\\'I\|&Iacute;\|\\u00cd/  contained conceal cchar=Í
syn match abcfmtEntity /\C\\'i\|&iacute;\|\\u00ed/  contained conceal cchar=í
syn match abcfmtEntity /\C\\'O\|&Oacute;\|\\u00d3/  contained conceal cchar=Ó
syn match abcfmtEntity /\C\\'o\|&oacute;\|\\u00f3/  contained conceal cchar=ó
syn match abcfmtEntity /\C\\'U\|&Uacute;\|\\u00da/  contained conceal cchar=Ú
syn match abcfmtEntity /\C\\'u\|&uacute;\|\\u00fa/  contained conceal cchar=ú
syn match abcfmtEntity /\C\\'Y\|&Yacute;\|\\u00dd/  contained conceal cchar=Ý
syn match abcfmtEntity /\C\\'y\|&yacute;\|\\u00fd/  contained conceal cchar=ý
syn match abcfmtEntity /\C\\^A\|&Acirc;\|\\u00c2/   contained conceal cchar=Â
syn match abcfmtEntity /\C\\^a\|&acirc;\|\\u00e2/   contained conceal cchar=â
syn match abcfmtEntity /\C\\^E\|&Ecirc;\|\\u00ca/   contained conceal cchar=Ê
syn match abcfmtEntity /\C\\^e\|&ecirc;\|\\u00ea/   contained conceal cchar=ê
syn match abcfmtEntity /\C\\^I\|&Icirc;\|\\u00ce/   contained conceal cchar=Î
syn match abcfmtEntity /\C\\^i\|&icirc;\|\\u00ee/   contained conceal cchar=î
syn match abcfmtEntity /\C\\^O\|&Ocirc;\|\\u00d4/   contained conceal cchar=Ô
syn match abcfmtEntity /\C\\^o\|&ocirc;\|\\u00f4/   contained conceal cchar=ô
syn match abcfmtEntity /\C\\^U\|&Ucirc;\|\\u00db/   contained conceal cchar=Û
syn match abcfmtEntity /\C\\^u\|&ucirc;\|\\u00fb/   contained conceal cchar=û
syn match abcfmtEntity /\C\\^Y\|&Ycirc;\|\\u0176/   contained conceal cchar=Ŷ
syn match abcfmtEntity /\C\\^y\|&ycirc;\|\\u0177/   contained conceal cchar=ŷ
syn match abcfmtEntity /\C\\~A\|&Atilde;\|\\u00c3/  contained conceal cchar=Ã
syn match abcfmtEntity /\C\\~a\|&atilde;\|\\u00e3/  contained conceal cchar=ã
syn match abcfmtEntity /\C\\~N\|&Ntilde;\|\\u00d1/  contained conceal cchar=Ñ
syn match abcfmtEntity /\C\\~n\|&ntilde;\|\\u00f1/  contained conceal cchar=ñ
syn match abcfmtEntity /\C\\~O\|&Otilde;\|\\u00d5/  contained conceal cchar=Õ
syn match abcfmtEntity /\C\\~o\|&otilde;\|\\u00f5/  contained conceal cchar=õ
syn match abcfmtEntity /\C\\"A\|&Auml;\|\\u00c4/    contained conceal cchar=Ä
syn match abcfmtEntity /\C\\"a\|&auml;\|\\u00e4/    contained conceal cchar=ä
syn match abcfmtEntity /\C\\"E\|&Euml;\|\\u00cb/    contained conceal cchar=Ë
syn match abcfmtEntity /\C\\"e\|&euml;\|\\u00eb/    contained conceal cchar=ë
syn match abcfmtEntity /\C\\"I\|&Iuml;\|\\u00cf/    contained conceal cchar=Ï
syn match abcfmtEntity /\C\\"i\|&iuml;\|\\u00ef/    contained conceal cchar=ï
syn match abcfmtEntity /\C\\"O\|&Ouml;\|\\u00d6/    contained conceal cchar=Ö
syn match abcfmtEntity /\C\\"o\|&ouml;\|\\u00f6/    contained conceal cchar=ö
syn match abcfmtEntity /\C\\"U\|&Uuml;\|\\u00dc/    contained conceal cchar=Ü
syn match abcfmtEntity /\C\\"u\|&uuml;\|\\u00fc/    contained conceal cchar=ü
syn match abcfmtEntity /\C\\"Y\|&Yuml;\|\\u0178/    contained conceal cchar=Ÿ
syn match abcfmtEntity /\C\\"y\|&yuml;\|\\u00ff/    contained conceal cchar=ÿ
syn match abcfmtEntity /\C\\cC\|&Ccedil;\|\\u00c7/  contained conceal cchar=Ç
syn match abcfmtEntity /\C\\cc\|&ccedil;\|\\u00e7/  contained conceal cchar=ç
syn match abcfmtEntity /\C\\AA\|&Aring;\|\\u00c5/   contained conceal cchar=Å
syn match abcfmtEntity /\C\\aa\|&aring;\|\\u00e5/   contained conceal cchar=å
syn match abcfmtEntity /\C\\\/O\|&Oslash;\|\\u00d8/ contained conceal cchar=Ø
syn match abcfmtEntity /\C\\\/o\|&oslash;\|\\u00f8/ contained conceal cchar=ø
syn match abcfmtEntity /\C\\uA\|&Abreve;\|\\u0102/  contained conceal cchar=Ă
syn match abcfmtEntity /\C\\ua\|&abreve;\|\\u0103/  contained conceal cchar=ă
syn match abcfmtEntity /\C\\uE\|\\u0114/            contained conceal cchar=Ĕ
syn match abcfmtEntity /\C\\ue\|\\u0115/            contained conceal cchar=ĕ
syn match abcfmtEntity /\C\\vS\|&Scaron;\|\\u0160/  contained conceal cchar=Š
syn match abcfmtEntity /\C\\vs\|&scaron;\|\\u0161/  contained conceal cchar=š
syn match abcfmtEntity /\C\\vZ\|&Zcaron;\|\\u017d/  contained conceal cchar=Ž
syn match abcfmtEntity /\C\\vz\|&zcaron;\|\\u017e/  contained conceal cchar=ž
syn match abcfmtEntity /\C\\HO\|\\u0150/            contained conceal cchar=Ő
syn match abcfmtEntity /\C\\Ho\|\\u0151/            contained conceal cchar=ő
syn match abcfmtEntity /\C\\HU\|\\u0170/            contained conceal cchar=Ű
syn match abcfmtEntity /\C\\Hu\|\\u0171/            contained conceal cchar=ű
syn match abcfmtEntity /\C\\AE\|&AElig;\|\\u00c6/   contained conceal cchar=Æ
syn match abcfmtEntity /\C\\ae\|&aelig;\|\\u00e6/   contained conceal cchar=æ
syn match abcfmtEntity /\C\\OE\|&OElig;\|\\u0152/   contained conceal cchar=Œ
syn match abcfmtEntity /\C\\oe\|&oelig;\|\\u0153/   contained conceal cchar=œ
syn match abcfmtEntity /\C\\ss\|&szlig;\|\\u00df/   contained conceal cchar=ß
syn match abcfmtEntity /\C\\DH\|&ETH;\|\\u00d0/     contained conceal cchar=Ð
syn match abcfmtEntity /\C\\dh\|&eth;\|\\u00f0/     contained conceal cchar=ð
syn match abcfmtEntity /\C\\TH\|&THORN;\|\\u00de/   contained conceal cchar=Þ
syn match abcfmtEntity /\C\\th\|&thorn;\|\\u00fe/   contained conceal cchar=þ
syn match abcfmtEntity /\C&copy;\|\\u00a9/          contained conceal cchar=©
syn match abcfmtEntity /\c&266d;\|\\u266d/          contained conceal cchar=♭
syn match abcfmtEntity /\c&266e;\|\\u266e/          contained conceal cchar=♮
syn match abcfmtEntity /\c&266f;\|\\u266f/          contained conceal cchar=♯
syn match abcfmtEntity /\C&quot;\|\\u0022/ contained conceal cchar="
" }}}
syn match abcfmtEscapeChar /\\%/ contained
syn match abcfmtEscapeChar /\\\\/ contained
syn match abcfmtEscapeChar /\\\&/ contained

syn match abcfmtSetFontChar /\$[0-4]/ contained

syn match abcfmtQuoteChar /"/ contained
syn match abcfmtReservedChar /#\|\*\|;\|?\|@/ contained
syn match abcfmtBarChar /\%(|\|\[\|\]\)\{1,2}/ contained


syn keyword abcfmtBoolean contained true false on off yes no
syn keyword abcfmtSize contained in cm pt
syn keyword abcfmtEncoding contained utf-8 us-ascii iso-8859-1 iso-8859-2 iso-8859-3 iso-8859-4 iso-8859-5 iso-8859-6 iso-8859-7 iso-8859-8 iso-8859-9 iso-8859-10
syn keyword abcfmtEncoding contained utf-8 us-ascii native
syn keyword abcfmtDirectiveLock contained lock
" Lock Keyword {{{ 'lock' is allowed in all directives, and must set that a setting is no longer
" able to be set any where else in the same tune. If contained on a global, it
" sets that the directive is unsettable in all tunes.
" }}}
" PostScript Fonts {{{
syn keyword abcfmtFont contained AlbertusMT AlbertusMT-Italic AlbertusMT-Light Apple-Chancery Apple-ChanceryCE
syn keyword abcfmtFont contained AntiqueOlive-Roman AntiqueOlive-Italic AntiqueOlive-Bold AntiqueOlive-Compact
syn keyword abcfmtFont contained AntiqueOliveCE-Roman AntiqueOliveCE-Italic AntiqueOliveCE-Bold AntiqueOliveCE-Compact
syn keyword abcfmtFont contained ArialMT Arial-ItalicMT Arial-LightMT Arial-BoldMT Arial-BoldItalicMT
syn keyword abcfmtFont contained ArialCE ArialCE-Italic ArialCE-Light ArialCE-Bold ArialCE-BoldItalic
syn keyword abcfmtFont contained AvantGarde-Book AvantGarde-BookOblique AvantGarde-Demi AvantGarde-DemiOblique
syn keyword abcfmtFont contained AvantGardeCE-Book AvantGardeCE-BookOblique AvantGardeCE-Demi AvantGardeCE-DemiOblique
syn keyword abcfmtFont contained Bodoni Bodoni-Italic Bodoni-Bold Bodoni-BoldItalic Bodoni-Poster Bodoni-PosterCompressed
syn keyword abcfmtFont contained BodoniCE BodoniCE-Italic BodoniCE-Bold BodoniCE-BoldItalic BodoniCE-Poster BodoniCE-PosterCompressed
syn keyword abcfmtFont contained Bookman-Light Bookman-LightItalic Bookman-Demi Bookman-DemiItalic
syn keyword abcfmtFont contained BookmanCE-Light BookmanCE-LightItalic BookmanCE-Demi BookmanCE-DemiItalic
syn keyword abcfmtFont contained Carta Chicago ChicagoCE Clarendon Clarendon-Light Clarendon-Bold
syn keyword abcfmtFont contained ClarendonCE ClarendonCE-Light ClarendonCE-Bold CooperBlack CooperBlack-Italic
syn keyword abcfmtFont contained Copperplate-ThirtyTwoBC CopperPlate-ThirtyThreeBC Coronet-Regular CoronetCE-Regular
syn keyword abcfmtFont contained CourierCE CourierCE-Oblique CourierCE-Bold CourierCE-BoldOblique
syn keyword abcfmtFont contained Eurostile Eurostile-Bold Eurostile-ExtendedTwo Eurostile-BoldExtendedTwo
syn keyword abcfmtFont contained Eurostile EurostileCE-Bold EurostileCE-ExtendedTwo EurostileCE-BoldExtendedTwo
syn keyword abcfmtFont contained Geneva GenevaCE GillSans GillSans-Italic GillSans-Bold GillSans-BoldItalic GillSans-BoldCondensed
syn keyword abcfmtFont contained GillSans-Light GillSans-LightItalic GillSans-ExtraBold
syn keyword abcfmtFont contained GillSansCE-Roman GillSansCE-Italic GillSansCE-Bold GillSansCE-BoldItalic GillSansCE-BoldCondensed
syn keyword abcfmtFont contained GillSansCE-Light GillSansCE-LightItalic GillSansCE-ExtraBold
syn keyword abcfmtFont contained Goudy Goudy-Italic Goudy-Bold Goudy-BoldItalic Goudy-ExtraBould
syn keyword abcfmtFont contained HelveticaCE HelveticaCE-Oblique HelveticaCE-Bold HelveticaCE-BoldOblique
syn keyword abcfmtFont contained Helvetica-Condensed Helvetica-Condensed-Oblique Helvetica-Condensed-Bold Helvetica-Condensed-BoldObl
syn keyword abcfmtFont contained HelveticaCE-Condensed HelveticaCE-Condensed-Oblique HelveticaCE-Condensed-Bold
syn keyword abcfmtFont contained HelveticaCE-Condensed-BoldObl Helvetica-Narrow Helvetica-Narrow-Oblique Helvetica-Narrow-Bold
syn keyword abcfmtFont contained Helvetica-Narrow-BoldOblique HelveticaCE-Narrow HelveticaCE-Narrow-Oblique HelveticaCE-Narrow-Bold
syn keyword abcfmtFont contained HelveticaCE-Narrow-BoldOblique HoeflerText-Regular HoeflerText-Italic HoeflerText-Black
syn keyword abcfmtFont contained HoeflerText-BlackItalic HoeflerText-Ornaments HoeflerTextCE-Regular HoeflerTextCE-Italic
syn keyword abcfmtFont contained HoeflerTextCE-Black HoeflerTextCE-BlackItalic
syn keyword abcfmtFont contained JoannaMT JoannaMT-Italic JoannaMT-Bold JoannaMT-BoldItalic
syn keyword abcfmtFont contained JoannaMTCE JoannaMTCE-Italic JoannaMTCE-Bold JoannaMTCE-BoldItalic
syn keyword abcfmtFont contained LetterGothic LetterGothic-Slanted LetterGothic-Bold LetterGothic-BoldSlanted
syn keyword abcfmtFont contained LetterGothicCE LetterGothicCE-Slanted LetterGothicCE-Bold LetterGothicCE-BoldSlanted
syn keyword abcfmtFont contained LubalinGraph-Book LubalinGraph-BookOblique LubalinGraph-Demi LubalinGraph-DemiOblique
syn keyword abcfmtFont contained LubalinGraphCE-Book LubalinGraphCE-BookOblique LubalinGraphCE-Demi LubalinGraphCE-DemiOblique
syn keyword abcfmtFont contained Marigold Monaco MonacoCE MonaLisa-Recut Oxford Symbol Tekton
syn keyword abcfmtFont contained NewCennturySchlbk-Roman NewCenturySchlbk-Italic NewCenturySchlbk-Bold NewCenturySchlbk-BoldItalic
syn keyword abcfmtFont contained NewCenturySchlbkCE-Roman NewCenturySchlbkCE-Italic NewCenturySchlbkCE-Bold
syn keyword abcfmtFont contained NewCenturySchlbkCE-BoldItalic NewYork NewYorkCE
syn keyword abcfmtFont contained Optima Optima-Italic Optima-Bold Optima-BoldItalic
syn keyword abcfmtFont contained OptimaCE OptimaCE-Italic OptimaCE-Bold OptimaCE-BoldItalic
syn keyword abcfmtFont contained Palatino-Roman Palatino-Italic Palatino-Bold Palatino-BoldItalic
syn keyword abcfmtFont contained PalatinoCE-Roman PalatinoCE-Italic PalatinoCE-Bold PalatinoCE-BoldItalic
syn keyword abcfmtFont contained StempelGaramond-Roman StempelGaramond-Italic StempelGaramond-Bold StempelGaramond-BoldItalic
syn keyword abcfmtFont contained StempelGaramondCE-Roman StempelGaramondCE-Italic StempelGaramondCE-Bold StempelGaramondCE-BoldItalic
syn keyword abcfmtFont contained TimesCE-Roman TimesCE-Italic TimesCE-Bold TimesCE-BoldItalic
syn keyword abcfmtFont contained TimesNewRomanPSMT TimesNewRomanPS-ItalicMT TimesNewRomanPS-BoldMT TimesNewRomanPS-BoldItalicMT
syn keyword abcfmtFont contained TimesNewRomanCE TimesNewRomanCE-Italic TimesNewRomanCE-Bold TimesNewRomanCE-BoldItalic
syn keyword abcfmtFont contained Univers Univers-Oblique Univers-Bold Univers-BoldOblique
syn keyword abcfmtFont contained UniversCE-Medium UniversCE-Oblique UniversCE-Bold UniversCE-BoldOblique
syn keyword abcfmtFont contained Univers-Light Univers-LightOblique UniversCE-Light UniversCE-LightOblique
syn keyword abcfmtFont contained Univers-Condensed Univers-CondensedOblique Univers-CondensedBold Univers-CondensedBoldOblique
syn keyword abcfmtFont contained UniversCE-Condensed UniversCE-CondensedOblique UniversCE-CondensedBold UniversCE-CondensedBoldOblique
syn keyword abcfmtFont contained Univers-Extended Univers-ExtendedObl Univers-BoldExt Univers-BoldExtObl
syn keyword abcfmtFont contained UniversCE-Extended UniversCE-ExtendedObl UniversCE-BoldExt UniversCE-BoldExtObl
syn keyword abcfmtFont contained Wingdings-Regular ZapfChancery-MediumItalic ZapfChanceryCE-MediumItalic ZapfDingBats

syn keyword abcfmtFontEncoding contained utf-8 us-ascii native
" }}}
" Boolean directives
syn keyword abcfmtDirective contained abc2pscompat autoclef breakoneoln 






"vim:ts=4:sw=4:fdm=marker:fdc=3
./syntax/postscr.vim	[[[1
797
" Vim syntax file
" Language:     PostScript - all Levels, selectable
" Maintainer:   Mike Williams <mrw@eandem.co.uk>
" Filenames:    *.ps,*.eps
" Last Change:  31st October 2007
" URL:          http://www.eandem.co.uk/mrw/vim
"
" Options Flags:
" postscr_level                 - language level to use for highligting (1, 2, or 3)
" postscr_display               - include display PS operators
" postscr_ghostscript           - include GS extensions
" postscr_fonts                 - highlight standard font names (a lot for PS 3)
" postscr_encodings             - highlight encoding names (there are a lot)
" postscr_andornot_binary       - highlight and, or, and not as binary operators (not logical)
"
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" PostScript is case sensitive
syn case match

" Keyword characters - all 7-bit ASCII bar PS delimiters and ws
if version >= 600
  setlocal iskeyword=33-127,^(,^),^<,^>,^[,^],^{,^},^/,^%
else
  set iskeyword=33-127,^(,^),^<,^>,^[,^],^{,^},^/,^%
endif

" Yer trusty old TODO highlghter!
syn keyword postscrTodo contained  TODO

" Comment
syn match postscrComment        "%.*$" contains=postscrTodo,@Spell
" DSC comment start line (NB: defines DSC level, not PS level!)
syn match postscrDSCComment    	"^%!PS-Adobe-\d\+\.\d\+\s*.*$"
" DSC comment line (no check on possible comments - another language!)
syn match postscrDSCComment    	"^%%\u\+.*$" contains=@postscrString,@postscrNumber,@Spell
" DSC continuation line (no check that previous line is DSC comment)
syn match  postscrDSCComment    "^%%+ *.*$" contains=@postscrString,@postscrNumber,@Spell

" Names
syn match postscrName           "\k\+"

" Identifiers
syn match postscrIdentifierError "/\{1,2}[[:space:]\[\]{}]"me=e-1
syn match postscrIdentifier     "/\{1,2}\k\+" contains=postscrConstant,postscrBoolean,postscrCustConstant

" Numbers
syn case ignore
" In file hex data - usually complete lines
syn match postscrHex            "^[[:xdigit:]][[:xdigit:][:space:]]*$"
"syn match postscrHex            "\<\x\{2,}\>"
" Integers
syn match postscrInteger        "\<[+-]\=\d\+\>"
" Radix
syn match postscrRadix          "\d\+#\x\+\>"
" Reals - upper and lower case e is allowed
syn match postscrFloat          "[+-]\=\d\+\.\>"
syn match postscrFloat          "[+-]\=\d\+\.\d*\(e[+-]\=\d\+\)\=\>"
syn match postscrFloat          "[+-]\=\.\d\+\(e[+-]\=\d\+\)\=\>"
syn match postscrFloat          "[+-]\=\d\+e[+-]\=\d\+\>"
syn cluster postscrNumber       contains=postscrInteger,postscrRadix,postscrFloat
syn case match

" Escaped characters
syn match postscrSpecialChar    contained "\\[nrtbf\\()]"
syn match postscrSpecialCharError contained "\\[^nrtbf\\()]"he=e-1
" Escaped octal characters
syn match postscrSpecialChar    contained "\\\o\{1,3}"

" Strings
" ASCII strings
syn region postscrASCIIString   start=+(+ end=+)+ skip=+([^)]*)+ contains=postscrSpecialChar,postscrSpecialCharError,@Spell
syn match postscrASCIIStringError ")"
" Hex strings
syn match postscrHexCharError   contained "[^<>[:xdigit:][:space:]]"
syn region postscrHexString     start=+<\($\|[^<]\)+ end=+>+ contains=postscrHexCharError
syn match postscrHexString      "<>"
" ASCII85 strings
syn match postscrASCII85CharError contained "[^<>\~!-uz[:space:]]"
syn region postscrASCII85String start=+<\~+ end=+\~>+ contains=postscrASCII85CharError
syn cluster postscrString       contains=postscrASCIIString,postscrHexString,postscrASCII85String


" Set default highlighting to level 2 - most common at the moment
if !exists("postscr_level")
  let postscr_level = 2
endif


" PS level 1 operators - common to all levels (well ...)

" Stack operators
syn keyword postscrOperator     pop exch dup copy index roll clear count mark cleartomark counttomark

" Math operators
syn keyword postscrMathOperator add div idiv mod mul sub abs neg ceiling floor round truncate sqrt atan cos
syn keyword postscrMathOperator sin exp ln log rand srand rrand

" Array operators
syn match postscrOperator       "[\[\]{}]"
syn keyword postscrOperator     array length get put getinterval putinterval astore aload copy
syn keyword postscrRepeat       forall

" Dictionary operators
syn keyword postscrOperator     dict maxlength begin end def load store known where currentdict
syn keyword postscrOperator     countdictstack dictstack cleardictstack internaldict
syn keyword postscrConstant     $error systemdict userdict statusdict errordict

" String operators
syn keyword postscrOperator     string anchorsearch search token

" Logic operators
syn keyword postscrLogicalOperator eq ne ge gt le lt and not or
if exists("postscr_andornot_binaryop")
  syn keyword postscrBinaryOperator and or not
else
  syn keyword postscrLogicalOperator and not or
endif
syn keyword postscrBinaryOperator xor bitshift
syn keyword postscrBoolean      true false

" PS Type names
syn keyword postscrConstant     arraytype booleantype conditiontype dicttype filetype fonttype gstatetype
syn keyword postscrConstant     integertype locktype marktype nametype nulltype operatortype
syn keyword postscrConstant     packedarraytype realtype savetype stringtype

" Control operators
syn keyword postscrConditional  if ifelse
syn keyword postscrRepeat       for repeat loop
syn keyword postscrOperator     exec exit stop stopped countexecstack execstack quit
syn keyword postscrProcedure    start

" Object operators
syn keyword postscrOperator     type cvlit cvx xcheck executeonly noaccess readonly rcheck wcheck cvi cvn cvr
syn keyword postscrOperator     cvrs cvs

" File operators
syn keyword postscrOperator     file closefile read write readhexstring writehexstring readstring writestring
syn keyword postscrOperator     bytesavailable flush flushfile resetfile status run currentfile print
syn keyword postscrOperator     stack pstack readline deletefile setfileposition fileposition renamefile
syn keyword postscrRepeat       filenameforall
syn keyword postscrProcedure    = ==

" VM operators
syn keyword postscrOperator     save restore

" Misc operators
syn keyword postscrOperator     bind null usertime executive echo realtime
syn keyword postscrConstant     product revision serialnumber version
syn keyword postscrProcedure    prompt

" GState operators
syn keyword postscrOperator     gsave grestore grestoreall initgraphics setlinewidth setlinecap currentgray
syn keyword postscrOperator     currentlinejoin setmiterlimit currentmiterlimit setdash currentdash setgray
syn keyword postscrOperator     sethsbcolor currenthsbcolor setrgbcolor currentrgbcolor currentlinewidth
syn keyword postscrOperator     currentlinecap setlinejoin setcmykcolor currentcmykcolor

" Device gstate operators
syn keyword postscrOperator     setscreen currentscreen settransfer currenttransfer setflat currentflat
syn keyword postscrOperator     currentblackgeneration setblackgeneration setundercolorremoval
syn keyword postscrOperator     setcolorscreen currentcolorscreen setcolortransfer currentcolortransfer
syn keyword postscrOperator     currentundercolorremoval

" Matrix operators
syn keyword postscrOperator     matrix initmatrix identmatrix defaultmatrix currentmatrix setmatrix translate
syn keyword postscrOperator     concat concatmatrix transform dtransform itransform idtransform invertmatrix
syn keyword postscrOperator     scale rotate

" Path operators
syn keyword postscrOperator     newpath currentpoint moveto rmoveto lineto rlineto arc arcn arcto curveto
syn keyword postscrOperator     closepath flattenpath reversepath strokepath charpath clippath pathbbox
syn keyword postscrOperator     initclip clip eoclip rcurveto
syn keyword postscrRepeat       pathforall

" Painting operators
syn keyword postscrOperator     erasepage fill eofill stroke image imagemask colorimage

" Device operators
syn keyword postscrOperator     showpage copypage nulldevice

" Character operators
syn keyword postscrProcedure    findfont
syn keyword postscrConstant     FontDirectory ISOLatin1Encoding StandardEncoding
syn keyword postscrOperator     definefont scalefont makefont setfont currentfont show ashow
syn keyword postscrOperator     stringwidth kshow setcachedevice
syn keyword postscrOperator     setcharwidth widthshow awidthshow findencoding cshow rootfont setcachedevice2

" Interpreter operators
syn keyword postscrOperator     vmstatus cachestatus setcachelimit

" PS constants
syn keyword postscrConstant     contained Gray Red Green Blue All None DeviceGray DeviceRGB

" PS Filters
syn keyword postscrConstant     contained ASCIIHexDecode ASCIIHexEncode ASCII85Decode ASCII85Encode LZWDecode
syn keyword postscrConstant     contained RunLengthDecode RunLengthEncode SubFileDecode NullEncode
syn keyword postscrConstant     contained GIFDecode PNGDecode LZWEncode

" PS JPEG filter dictionary entries
syn keyword postscrConstant     contained DCTEncode DCTDecode Colors HSamples VSamples QuantTables QFactor
syn keyword postscrConstant     contained HuffTables ColorTransform

" PS CCITT filter dictionary entries
syn keyword postscrConstant     contained CCITTFaxEncode CCITTFaxDecode Uncompressed K EndOfLine
syn keyword postscrConstant     contained Columns Rows EndOfBlock Blacks1 DamagedRowsBeforeError
syn keyword postscrConstant     contained EncodedByteAlign

" PS Form dictionary entries
syn keyword postscrConstant     contained FormType XUID BBox Matrix PaintProc Implementation

" PS Errors
syn keyword postscrProcedure    handleerror
syn keyword postscrConstant     contained  configurationerror dictfull dictstackunderflow dictstackoverflow
syn keyword postscrConstant     contained  execstackoverflow interrupt invalidaccess
syn keyword postscrConstant     contained  invalidcontext invalidexit invalidfileaccess invalidfont
syn keyword postscrConstant     contained  invalidid invalidrestore ioerror limitcheck nocurrentpoint
syn keyword postscrConstant     contained  rangecheck stackoverflow stackunderflow syntaxerror timeout
syn keyword postscrConstant     contained  typecheck undefined undefinedfilename undefinedresource
syn keyword postscrConstant     contained  undefinedresult unmatchedmark unregistered VMerror

if exists("postscr_fonts")
" Font names
  syn keyword postscrConstant   contained Symbol Times-Roman Times-Italic Times-Bold Times-BoldItalic
  syn keyword postscrConstant   contained Helvetica Helvetica-Oblique Helvetica-Bold Helvetica-BoldOblique
  syn keyword postscrConstant   contained Courier Courier-Oblique Courier-Bold Courier-BoldOblique
endif


if exists("postscr_display")
" Display PS only operators
  syn keyword postscrOperator   currentcontext fork join detach lock monitor condition wait notify yield
  syn keyword postscrOperator   viewclip eoviewclip rectviewclip initviewclip viewclippath deviceinfo
  syn keyword postscrOperator   sethalftonephase currenthalftonephase wtranslation defineusername
endif

" PS Character encoding names
if exists("postscr_encodings")
" Common encoding names
  syn keyword postscrConstant   contained .notdef

" Standard and ISO encoding names
  syn keyword postscrConstant   contained space exclam quotedbl numbersign dollar percent ampersand quoteright
  syn keyword postscrConstant   contained parenleft parenright asterisk plus comma hyphen period slash zero
  syn keyword postscrConstant   contained one two three four five six seven eight nine colon semicolon less
  syn keyword postscrConstant   contained equal greater question at
  syn keyword postscrConstant   contained bracketleft backslash bracketright asciicircum underscore quoteleft
  syn keyword postscrConstant   contained braceleft bar braceright asciitilde
  syn keyword postscrConstant   contained exclamdown cent sterling fraction yen florin section currency
  syn keyword postscrConstant   contained quotesingle quotedblleft guillemotleft guilsinglleft guilsinglright
  syn keyword postscrConstant   contained fi fl endash dagger daggerdbl periodcentered paragraph bullet
  syn keyword postscrConstant   contained quotesinglbase quotedblbase quotedblright guillemotright ellipsis
  syn keyword postscrConstant   contained perthousand questiondown grave acute circumflex tilde macron breve
  syn keyword postscrConstant   contained dotaccent dieresis ring cedilla hungarumlaut ogonek caron emdash
  syn keyword postscrConstant   contained AE ordfeminine Lslash Oslash OE ordmasculine ae dotlessi lslash
  syn keyword postscrConstant   contained oslash oe germandbls
" The following are valid names, but are used as short procedure names in generated PS!
" a b c d e f g h i j k l m n o p q r s t u v w x y z
" A B C D E F G H I J K L M N O P Q R S T U V W X Y Z

" Symbol encoding names
  syn keyword postscrConstant   contained universal existential suchthat asteriskmath minus
  syn keyword postscrConstant   contained congruent Alpha Beta Chi Delta Epsilon Phi Gamma Eta Iota theta1
  syn keyword postscrConstant   contained Kappa Lambda Mu Nu Omicron Pi Theta Rho Sigma Tau Upsilon sigma1
  syn keyword postscrConstant   contained Omega Xi Psi Zeta therefore perpendicular
  syn keyword postscrConstant   contained radicalex alpha beta chi delta epsilon phi gamma eta iota phi1
  syn keyword postscrConstant   contained kappa lambda mu nu omicron pi theta rho sigma tau upsilon omega1
  syn keyword postscrConstant   contained Upsilon1 minute lessequal infinity club diamond heart spade
  syn keyword postscrConstant   contained arrowboth arrowleft arrowup arrowright arrowdown degree plusminus
  syn keyword postscrConstant   contained second greaterequal multiply proportional partialdiff divide
  syn keyword postscrConstant   contained notequal equivalence approxequal arrowvertex arrowhorizex
  syn keyword postscrConstant   contained aleph Ifraktur Rfraktur weierstrass circlemultiply circleplus
  syn keyword postscrConstant   contained emptyset intersection union propersuperset reflexsuperset notsubset
  syn keyword postscrConstant   contained propersubset reflexsubset element notelement angle gradient
  syn keyword postscrConstant   contained registerserif copyrightserif trademarkserif radical dotmath
  syn keyword postscrConstant   contained logicalnot logicaland logicalor arrowdblboth arrowdblleft arrowdblup
  syn keyword postscrConstant   contained arrowdblright arrowdbldown omega xi psi zeta similar carriagereturn
  syn keyword postscrConstant   contained lozenge angleleft registersans copyrightsans trademarksans summation
  syn keyword postscrConstant   contained parenlefttp parenleftex parenleftbt bracketlefttp bracketleftex
  syn keyword postscrConstant   contained bracketleftbt bracelefttp braceleftmid braceleftbt braceex euro
  syn keyword postscrConstant   contained angleright integral integraltp integralex integralbt parenrighttp
  syn keyword postscrConstant   contained parenrightex parenrightbt bracketrighttp bracketrightex
  syn keyword postscrConstant   contained bracketrightbt bracerighttp bracerightmid bracerightbt

" ISO Latin1 encoding names
  syn keyword postscrConstant   contained brokenbar copyright registered twosuperior threesuperior
  syn keyword postscrConstant   contained onesuperior onequarter onehalf threequarters
  syn keyword postscrConstant   contained Agrave Aacute Acircumflex Atilde Adieresis Aring Ccedilla Egrave
  syn keyword postscrConstant   contained Eacute Ecircumflex Edieresis Igrave Iacute Icircumflex Idieresis
  syn keyword postscrConstant   contained Eth Ntilde Ograve Oacute Ocircumflex Otilde Odieresis Ugrave Uacute
  syn keyword postscrConstant   contained Ucircumflex Udieresis Yacute Thorn
  syn keyword postscrConstant   contained agrave aacute acircumflex atilde adieresis aring ccedilla egrave
  syn keyword postscrConstant   contained eacute ecircumflex edieresis igrave iacute icircumflex idieresis
  syn keyword postscrConstant   contained eth ntilde ograve oacute ocircumflex otilde odieresis ugrave uacute
  syn keyword postscrConstant   contained ucircumflex udieresis yacute thorn ydieresis
  syn keyword postscrConstant   contained zcaron exclamsmall Hungarumlautsmall dollaroldstyle dollarsuperior
  syn keyword postscrConstant   contained ampersandsmall Acutesmall parenleftsuperior parenrightsuperior
  syn keyword postscrConstant   contained twodotenleader onedotenleader zerooldstyle oneoldstyle twooldstyle
  syn keyword postscrConstant   contained threeoldstyle fouroldstyle fiveoldstyle sixoldstyle sevenoldstyle
  syn keyword postscrConstant   contained eightoldstyle nineoldstyle commasuperior
  syn keyword postscrConstant   contained threequartersemdash periodsuperior questionsmall asuperior bsuperior
  syn keyword postscrConstant   contained centsuperior dsuperior esuperior isuperior lsuperior msuperior
  syn keyword postscrConstant   contained nsuperior osuperior rsuperior ssuperior tsuperior ff ffi ffl
  syn keyword postscrConstant   contained parenleftinferior parenrightinferior Circumflexsmall hyphensuperior
  syn keyword postscrConstant   contained Gravesmall Asmall Bsmall Csmall Dsmall Esmall Fsmall Gsmall Hsmall
  syn keyword postscrConstant   contained Ismall Jsmall Ksmall Lsmall Msmall Nsmall Osmall Psmall Qsmall
  syn keyword postscrConstant   contained Rsmall Ssmall Tsmall Usmall Vsmall Wsmall Xsmall Ysmall Zsmall
  syn keyword postscrConstant   contained colonmonetary onefitted rupiah Tildesmall exclamdownsmall
  syn keyword postscrConstant   contained centoldstyle Lslashsmall Scaronsmall Zcaronsmall Dieresissmall
  syn keyword postscrConstant   contained Brevesmall Caronsmall Dotaccentsmall Macronsmall figuredash
  syn keyword postscrConstant   contained hypheninferior Ogoneksmall Ringsmall Cedillasmall questiondownsmall
  syn keyword postscrConstant   contained oneeighth threeeighths fiveeighths seveneighths onethird twothirds
  syn keyword postscrConstant   contained zerosuperior foursuperior fivesuperior sixsuperior sevensuperior
  syn keyword postscrConstant   contained eightsuperior ninesuperior zeroinferior oneinferior twoinferior
  syn keyword postscrConstant   contained threeinferior fourinferior fiveinferior sixinferior seveninferior
  syn keyword postscrConstant   contained eightinferior nineinferior centinferior dollarinferior periodinferior
  syn keyword postscrConstant   contained commainferior Agravesmall Aacutesmall Acircumflexsmall
  syn keyword postscrConstant   contained Atildesmall Adieresissmall Aringsmall AEsmall Ccedillasmall
  syn keyword postscrConstant   contained Egravesmall Eacutesmall Ecircumflexsmall Edieresissmall Igravesmall
  syn keyword postscrConstant   contained Iacutesmall Icircumflexsmall Idieresissmall Ethsmall Ntildesmall
  syn keyword postscrConstant   contained Ogravesmall Oacutesmall Ocircumflexsmall Otildesmall Odieresissmall
  syn keyword postscrConstant   contained OEsmall Oslashsmall Ugravesmall Uacutesmall Ucircumflexsmall
  syn keyword postscrConstant   contained Udieresissmall Yacutesmall Thornsmall Ydieresissmall Black Bold Book
  syn keyword postscrConstant   contained Light Medium Regular Roman Semibold

" Sundry standard and expert encoding names
  syn keyword postscrConstant   contained trademark Scaron Ydieresis Zcaron scaron softhyphen overscore
  syn keyword postscrConstant   contained graybox Sacute Tcaron Zacute sacute tcaron zacute Aogonek Scedilla
  syn keyword postscrConstant   contained Zdotaccent aogonek scedilla Lcaron lcaron zdotaccent Racute Abreve
  syn keyword postscrConstant   contained Lacute Cacute Ccaron Eogonek Ecaron Dcaron Dcroat Nacute Ncaron
  syn keyword postscrConstant   contained Ohungarumlaut Rcaron Uring Uhungarumlaut Tcommaaccent racute abreve
  syn keyword postscrConstant   contained lacute cacute ccaron eogonek ecaron dcaron dcroat nacute ncaron
  syn keyword postscrConstant   contained ohungarumlaut rcaron uring uhungarumlaut tcommaaccent Gbreve
  syn keyword postscrConstant   contained Idotaccent gbreve blank apple
endif


" By default level 3 includes all level 2 operators
if postscr_level == 2 || postscr_level == 3
" Dictionary operators
  syn match postscrL2Operator     "\(<<\|>>\)"
  syn keyword postscrL2Operator   undef
  syn keyword postscrConstant   globaldict shareddict

" Device operators
  syn keyword postscrL2Operator   setpagedevice currentpagedevice

" Path operators
  syn keyword postscrL2Operator   rectclip setbbox uappend ucache upath ustrokepath arct

" Painting operators
  syn keyword postscrL2Operator   rectfill rectstroke ufill ueofill ustroke

" Array operators
  syn keyword postscrL2Operator   currentpacking setpacking packedarray

" Misc operators
  syn keyword postscrL2Operator   languagelevel

" Insideness operators
  syn keyword postscrL2Operator   infill ineofill instroke inufill inueofill inustroke

" GState operators
  syn keyword postscrL2Operator   gstate setgstate currentgstate setcolor
  syn keyword postscrL2Operator   setcolorspace currentcolorspace setstrokeadjust currentstrokeadjust
  syn keyword postscrL2Operator   currentcolor

" Device gstate operators
  syn keyword postscrL2Operator   sethalftone currenthalftone setoverprint currentoverprint
  syn keyword postscrL2Operator   setcolorrendering currentcolorrendering

" Character operators
  syn keyword postscrL2Constant   GlobalFontDirectory SharedFontDirectory
  syn keyword postscrL2Operator   glyphshow selectfont
  syn keyword postscrL2Operator   addglyph undefinefont xshow xyshow yshow

" Pattern operators
  syn keyword postscrL2Operator   makepattern setpattern execform

" Resource operators
  syn keyword postscrL2Operator   defineresource undefineresource findresource resourcestatus
  syn keyword postscrL2Repeat     resourceforall

" File operators
  syn keyword postscrL2Operator   filter printobject writeobject setobjectformat currentobjectformat

" VM operators
  syn keyword postscrL2Operator   currentshared setshared defineuserobject execuserobject undefineuserobject
  syn keyword postscrL2Operator   gcheck scheck startjob currentglobal setglobal
  syn keyword postscrConstant   UserObjects

" Interpreter operators
  syn keyword postscrL2Operator   setucacheparams setvmthreshold ucachestatus setsystemparams
  syn keyword postscrL2Operator   setuserparams currentuserparams setcacheparams currentcacheparams
  syn keyword postscrL2Operator   currentdevparams setdevparams vmreclaim currentsystemparams

" PS2 constants
  syn keyword postscrConstant   contained DeviceCMYK Pattern Indexed Separation Cyan Magenta Yellow Black
  syn keyword postscrConstant   contained CIEBasedA CIEBasedABC CIEBasedDEF CIEBasedDEFG

" PS2 $error dictionary entries
  syn keyword postscrConstant   contained newerror errorname command errorinfo ostack estack dstack
  syn keyword postscrConstant   contained recordstacks binary

" PS2 Category dictionary
  syn keyword postscrConstant   contained DefineResource UndefineResource FindResource ResourceStatus
  syn keyword postscrConstant   contained ResourceForAll Category InstanceType ResourceFileName

" PS2 Category names
  syn keyword postscrConstant   contained Font Encoding Form Pattern ProcSet ColorSpace Halftone
  syn keyword postscrConstant   contained ColorRendering Filter ColorSpaceFamily Emulator IODevice
  syn keyword postscrConstant   contained ColorRenderingType FMapType FontType FormType HalftoneType
  syn keyword postscrConstant   contained ImageType PatternType Category Generic

" PS2 pagedevice dictionary entries
  syn keyword postscrConstant   contained PageSize MediaColor MediaWeight MediaType InputAttributes ManualFeed
  syn keyword postscrConstant   contained OutputType OutputAttributes NumCopies Collate Duplex Tumble
  syn keyword postscrConstant   contained Separations HWResolution Margins NegativePrint MirrorPrint
  syn keyword postscrConstant   contained CutMedia AdvanceMedia AdvanceDistance ImagingBBox
  syn keyword postscrConstant   contained Policies Install BeginPage EndPage PolicyNotFound PolicyReport
  syn keyword postscrConstant   contained ManualSize OutputFaceUp Jog
  syn keyword postscrConstant   contained Bind BindDetails Booklet BookletDetails CollateDetails
  syn keyword postscrConstant   contained DeviceRenderingInfo ExitJamRecovery Fold FoldDetails Laminate
  syn keyword postscrConstant   contained ManualFeedTimeout Orientation OutputPage
  syn keyword postscrConstant   contained PostRenderingEnhance PostRenderingEnhanceDetails
  syn keyword postscrConstant   contained PreRenderingEnhance PreRenderingEnhanceDetails
  syn keyword postscrConstant   contained Signature SlipSheet Staple StapleDetails Trim
  syn keyword postscrConstant   contained ProofSet REValue PrintQuality ValuesPerColorComponent AntiAlias

" PS2 PDL resource entries
  syn keyword postscrConstant   contained Selector LanguageFamily LanguageVersion

" PS2 halftone dictionary entries
  syn keyword postscrConstant   contained HalftoneType HalftoneName
  syn keyword postscrConstant   contained AccurateScreens ActualAngle Xsquare Ysquare AccurateFrequency
  syn keyword postscrConstant   contained Frequency SpotFunction Angle Width Height Thresholds
  syn keyword postscrConstant   contained RedFrequency RedSpotFunction RedAngle RedWidth RedHeight
  syn keyword postscrConstant   contained GreenFrequency GreenSpotFunction GreenAngle GreenWidth GreenHeight
  syn keyword postscrConstant   contained BlueFrequency BlueSpotFunction BlueAngle BlueWidth BlueHeight
  syn keyword postscrConstant   contained GrayFrequency GrayAngle GraySpotFunction GrayWidth GrayHeight
  syn keyword postscrConstant   contained GrayThresholds BlueThresholds GreenThresholds RedThresholds
  syn keyword postscrConstant   contained TransferFunction

" PS2 CSR dictionaries
  syn keyword postscrConstant   contained RangeA DecodeA MatrixA RangeABC DecodeABC MatrixABC BlackPoint
  syn keyword postscrConstant   contained RangeLMN DecodeLMN MatrixLMN WhitePoint RangeDEF DecodeDEF RangeHIJ
  syn keyword postscrConstant   contained RangeDEFG DecodeDEFG RangeHIJK Table

" PS2 CRD dictionaries
  syn keyword postscrConstant   contained ColorRenderingType EncodeLMB EncodeABC RangePQR MatrixPQR
  syn keyword postscrConstant   contained AbsoluteColorimetric RelativeColorimetric Saturation Perceptual
  syn keyword postscrConstant   contained TransformPQR RenderTable

" PS2 Pattern dictionary
  syn keyword postscrConstant   contained PatternType PaintType TilingType XStep YStep

" PS2 Image dictionary
  syn keyword postscrConstant   contained ImageType ImageMatrix MultipleDataSources DataSource
  syn keyword postscrConstant   contained BitsPerComponent Decode Interpolate

" PS2 Font dictionaries
  syn keyword postscrConstant   contained FontType FontMatrix FontName FontInfo LanguageLevel WMode Encoding
  syn keyword postscrConstant   contained UniqueID StrokeWidth Metrics Metrics2 CDevProc CharStrings Private
  syn keyword postscrConstant   contained FullName Notice version ItalicAngle isFixedPitch UnderlinePosition
  syn keyword postscrConstant   contained FMapType Encoding FDepVector PrefEnc EscChar ShiftOut ShiftIn
  syn keyword postscrConstant   contained WeightVector Blend $Blend CIDFontType sfnts CIDSystemInfo CodeMap
  syn keyword postscrConstant   contained CMap CIDFontName CIDSystemInfo UIDBase CIDDevProc CIDCount
  syn keyword postscrConstant   contained CIDMapOffset FDArray FDBytes GDBytes GlyphData GlyphDictionary
  syn keyword postscrConstant   contained SDBytes SubrMapOffset SubrCount BuildGlyph CIDMap FID MIDVector
  syn keyword postscrConstant   contained Ordering Registry Supplement CMapName CMapVersion UIDOffset
  syn keyword postscrConstant   contained SubsVector UnderlineThickness FamilyName FontBBox CurMID
  syn keyword postscrConstant   contained Weight

" PS2 User paramters
  syn keyword postscrConstant   contained MaxFontItem MinFontCompress MaxUPathItem MaxFormItem MaxPatternItem
  syn keyword postscrConstant   contained MaxScreenItem MaxOpStack MaxDictStack MaxExecStack MaxLocalVM
  syn keyword postscrConstant   contained VMReclaim VMThreshold

" PS2 System paramters
  syn keyword postscrConstant   contained SystemParamsPassword StartJobPassword BuildTime ByteOrder RealFormat
  syn keyword postscrConstant   contained MaxFontCache CurFontCache MaxOutlineCache CurOutlineCache
  syn keyword postscrConstant   contained MaxUPathCache CurUPathCache MaxFormCache CurFormCache
  syn keyword postscrConstant   contained MaxPatternCache CurPatternCache MaxScreenStorage CurScreenStorage
  syn keyword postscrConstant   contained MaxDisplayList CurDisplayList

" PS2 LZW Filters
  syn keyword postscrConstant   contained Predictor

" Paper Size operators
  syn keyword postscrL2Operator   letter lettersmall legal ledger 11x17 a4 a3 a4small b5 note

" Paper Tray operators
  syn keyword postscrL2Operator   lettertray legaltray ledgertray a3tray a4tray b5tray 11x17tray

" SCC compatibility operators
  syn keyword postscrL2Operator   sccbatch sccinteractive setsccbatch setsccinteractive

" Page duplexing operators
  syn keyword postscrL2Operator   duplexmode firstside newsheet setduplexmode settumble tumble

" Device compatability operators
  syn keyword postscrL2Operator   devdismount devformat devmount devstatus
  syn keyword postscrL2Repeat     devforall

" Imagesetter compatability operators
  syn keyword postscrL2Operator   accuratescreens checkscreen pagemargin pageparams setaccuratescreens setpage
  syn keyword postscrL2Operator   setpagemargin setpageparams

" Misc compatability operators
  syn keyword postscrL2Operator   appletalktype buildtime byteorder checkpassword defaulttimeouts diskonline
  syn keyword postscrL2Operator   diskstatus manualfeed manualfeedtimeout margins mirrorprint pagecount
  syn keyword postscrL2Operator   pagestackorder printername processcolors sethardwareiomode setjobtimeout
  syn keyword postscrL2Operator   setpagestockorder setprintername setresolution doprinterrors dostartpage
  syn keyword postscrL2Operator   hardwareiomode initializedisk jobname jobtimeout ramsize realformat resolution
  syn keyword postscrL2Operator   setdefaulttimeouts setdoprinterrors setdostartpage setdosysstart
  syn keyword postscrL2Operator   setuserdiskpercent softwareiomode userdiskpercent waittimeout
  syn keyword postscrL2Operator   setsoftwareiomode dosysstart emulate setmargins setmirrorprint

endif " PS2 highlighting

if postscr_level == 3
" Shading operators
  syn keyword postscrL3Operator setsmoothness currentsmoothness shfill

" Clip operators
  syn keyword postscrL3Operator clipsave cliprestore

" Pagedevive operators
  syn keyword postscrL3Operator setpage setpageparams

" Device gstate operators
  syn keyword postscrL3Operator findcolorrendering

" Font operators
  syn keyword postscrL3Operator composefont

" PS LL3 Output device resource entries
  syn keyword postscrConstant   contained DeviceN TrappingDetailsType

" PS LL3 pagdevice dictionary entries
  syn keyword postscrConstant   contained DeferredMediaSelection ImageShift InsertSheet LeadingEdge MaxSeparations
  syn keyword postscrConstant   contained MediaClass MediaPosition OutputDevice PageDeviceName PageOffset ProcessColorModel
  syn keyword postscrConstant   contained RollFedMedia SeparationColorNames SeparationOrder Trapping TrappingDetails
  syn keyword postscrConstant   contained TraySwitch UseCIEColor
  syn keyword postscrConstant   contained ColorantDetails ColorantName ColorantType NeutralDensity TrappingOrder
  syn keyword postscrConstant   contained ColorantSetName

" PS LL3 trapping dictionary entries
  syn keyword postscrConstant   contained BlackColorLimit BlackDensityLimit BlackWidth ColorantZoneDetails
  syn keyword postscrConstant   contained SlidingTrapLimit StepLimit TrapColorScaling TrapSetName TrapWidth
  syn keyword postscrConstant   contained ImageResolution ImageToObjectTrapping ImageTrapPlacement
  syn keyword postscrConstant   contained StepLimit TrapColorScaling Enabled ImageInternalTrapping

" PS LL3 filters and entries
  syn keyword postscrConstant   contained ReusableStreamDecode CloseSource CloseTarget UnitSize LowBitFirst
  syn keyword postscrConstant   contained FlateEncode FlateDecode DecodeParams Intent AsyncRead

" PS LL3 halftone dictionary entries
  syn keyword postscrConstant   contained Height2 Width2

" PS LL3 function dictionary entries
  syn keyword postscrConstant   contained FunctionType Domain Range Order BitsPerSample Encode Size C0 C1 N
  syn keyword postscrConstant   contained Functions Bounds

" PS LL3 image dictionary entries
  syn keyword postscrConstant   contained InterleaveType MaskDict DataDict MaskColor

" PS LL3 Pattern and shading dictionary entries
  syn keyword postscrConstant   contained Shading ShadingType Background ColorSpace Coords Extend Function
  syn keyword postscrConstant   contained VerticesPerRow BitsPerCoordinate BitsPerFlag

" PS LL3 image dictionary entries
  syn keyword postscrConstant   contained XOrigin YOrigin UnpaintedPath PixelCopy

" PS LL3 colorrendering procedures
  syn keyword postscrProcedure  GetHalftoneName GetPageDeviceName GetSubstituteCRD

" PS LL3 CIDInit procedures
  syn keyword postscrProcedure  beginbfchar beginbfrange begincidchar begincidrange begincmap begincodespacerange
  syn keyword postscrProcedure  beginnotdefchar beginnotdefrange beginrearrangedfont beginusematrix
  syn keyword postscrProcedure  endbfchar endbfrange endcidchar endcidrange endcmap endcodespacerange
  syn keyword postscrProcedure  endnotdefchar endnotdefrange endrearrangedfont endusematrix
  syn keyword postscrProcedure  StartData usefont usecmp

" PS LL3 Trapping procedures
  syn keyword postscrProcedure  settrapparams currenttrapparams settrapzone

" PS LL3 BitmapFontInit procedures
  syn keyword postscrProcedure  removeall removeglyphs

" PS LL3 Font names
  if exists("postscr_fonts")
    syn keyword postscrConstant contained AlbertusMT AlbertusMT-Italic AlbertusMT-Light Apple-Chancery Apple-ChanceryCE
    syn keyword postscrConstant contained AntiqueOlive-Roman AntiqueOlive-Italic AntiqueOlive-Bold AntiqueOlive-Compact
    syn keyword postscrConstant contained AntiqueOliveCE-Roman AntiqueOliveCE-Italic AntiqueOliveCE-Bold AntiqueOliveCE-Compact
    syn keyword postscrConstant contained ArialMT Arial-ItalicMT Arial-LightMT Arial-BoldMT Arial-BoldItalicMT
    syn keyword postscrConstant contained ArialCE ArialCE-Italic ArialCE-Light ArialCE-Bold ArialCE-BoldItalic
    syn keyword postscrConstant contained AvantGarde-Book AvantGarde-BookOblique AvantGarde-Demi AvantGarde-DemiOblique
    syn keyword postscrConstant contained AvantGardeCE-Book AvantGardeCE-BookOblique AvantGardeCE-Demi AvantGardeCE-DemiOblique
    syn keyword postscrConstant contained Bodoni Bodoni-Italic Bodoni-Bold Bodoni-BoldItalic Bodoni-Poster Bodoni-PosterCompressed
    syn keyword postscrConstant contained BodoniCE BodoniCE-Italic BodoniCE-Bold BodoniCE-BoldItalic BodoniCE-Poster BodoniCE-PosterCompressed
    syn keyword postscrConstant contained Bookman-Light Bookman-LightItalic Bookman-Demi Bookman-DemiItalic
    syn keyword postscrConstant contained BookmanCE-Light BookmanCE-LightItalic BookmanCE-Demi BookmanCE-DemiItalic
    syn keyword postscrConstant contained Carta Chicago ChicagoCE Clarendon Clarendon-Light Clarendon-Bold
    syn keyword postscrConstant contained ClarendonCE ClarendonCE-Light ClarendonCE-Bold CooperBlack CooperBlack-Italic
    syn keyword postscrConstant contained Copperplate-ThirtyTwoBC CopperPlate-ThirtyThreeBC Coronet-Regular CoronetCE-Regular
    syn keyword postscrConstant contained CourierCE CourierCE-Oblique CourierCE-Bold CourierCE-BoldOblique
    syn keyword postscrConstant contained Eurostile Eurostile-Bold Eurostile-ExtendedTwo Eurostile-BoldExtendedTwo
    syn keyword postscrConstant contained Eurostile EurostileCE-Bold EurostileCE-ExtendedTwo EurostileCE-BoldExtendedTwo
    syn keyword postscrConstant contained Geneva GenevaCE GillSans GillSans-Italic GillSans-Bold GillSans-BoldItalic GillSans-BoldCondensed
    syn keyword postscrConstant contained GillSans-Light GillSans-LightItalic GillSans-ExtraBold
    syn keyword postscrConstant contained GillSansCE-Roman GillSansCE-Italic GillSansCE-Bold GillSansCE-BoldItalic GillSansCE-BoldCondensed
    syn keyword postscrConstant contained GillSansCE-Light GillSansCE-LightItalic GillSansCE-ExtraBold
    syn keyword postscrConstant contained Goudy Goudy-Italic Goudy-Bold Goudy-BoldItalic Goudy-ExtraBould
    syn keyword postscrConstant contained HelveticaCE HelveticaCE-Oblique HelveticaCE-Bold HelveticaCE-BoldOblique
    syn keyword postscrConstant contained Helvetica-Condensed Helvetica-Condensed-Oblique Helvetica-Condensed-Bold Helvetica-Condensed-BoldObl
    syn keyword postscrConstant contained HelveticaCE-Condensed HelveticaCE-Condensed-Oblique HelveticaCE-Condensed-Bold
    syn keyword postscrConstant contained HelveticaCE-Condensed-BoldObl Helvetica-Narrow Helvetica-Narrow-Oblique Helvetica-Narrow-Bold
    syn keyword postscrConstant contained Helvetica-Narrow-BoldOblique HelveticaCE-Narrow HelveticaCE-Narrow-Oblique HelveticaCE-Narrow-Bold
    syn keyword postscrConstant contained HelveticaCE-Narrow-BoldOblique HoeflerText-Regular HoeflerText-Italic HoeflerText-Black
    syn keyword postscrConstant contained HoeflerText-BlackItalic HoeflerText-Ornaments HoeflerTextCE-Regular HoeflerTextCE-Italic
    syn keyword postscrConstant contained HoeflerTextCE-Black HoeflerTextCE-BlackItalic
    syn keyword postscrConstant contained JoannaMT JoannaMT-Italic JoannaMT-Bold JoannaMT-BoldItalic
    syn keyword postscrConstant contained JoannaMTCE JoannaMTCE-Italic JoannaMTCE-Bold JoannaMTCE-BoldItalic
    syn keyword postscrConstant contained LetterGothic LetterGothic-Slanted LetterGothic-Bold LetterGothic-BoldSlanted
    syn keyword postscrConstant contained LetterGothicCE LetterGothicCE-Slanted LetterGothicCE-Bold LetterGothicCE-BoldSlanted
    syn keyword postscrConstant contained LubalinGraph-Book LubalinGraph-BookOblique LubalinGraph-Demi LubalinGraph-DemiOblique
    syn keyword postscrConstant contained LubalinGraphCE-Book LubalinGraphCE-BookOblique LubalinGraphCE-Demi LubalinGraphCE-DemiOblique
    syn keyword postscrConstant contained Marigold Monaco MonacoCE MonaLisa-Recut Oxford Symbol Tekton
    syn keyword postscrConstant contained NewCennturySchlbk-Roman NewCenturySchlbk-Italic NewCenturySchlbk-Bold NewCenturySchlbk-BoldItalic
    syn keyword postscrConstant contained NewCenturySchlbkCE-Roman NewCenturySchlbkCE-Italic NewCenturySchlbkCE-Bold
    syn keyword postscrConstant contained NewCenturySchlbkCE-BoldItalic NewYork NewYorkCE
    syn keyword postscrConstant contained Optima Optima-Italic Optima-Bold Optima-BoldItalic
    syn keyword postscrConstant contained OptimaCE OptimaCE-Italic OptimaCE-Bold OptimaCE-BoldItalic
    syn keyword postscrConstant contained Palatino-Roman Palatino-Italic Palatino-Bold Palatino-BoldItalic
    syn keyword postscrConstant contained PalatinoCE-Roman PalatinoCE-Italic PalatinoCE-Bold PalatinoCE-BoldItalic
    syn keyword postscrConstant contained StempelGaramond-Roman StempelGaramond-Italic StempelGaramond-Bold StempelGaramond-BoldItalic
    syn keyword postscrConstant contained StempelGaramondCE-Roman StempelGaramondCE-Italic StempelGaramondCE-Bold StempelGaramondCE-BoldItalic
    syn keyword postscrConstant contained TimesCE-Roman TimesCE-Italic TimesCE-Bold TimesCE-BoldItalic
    syn keyword postscrConstant contained TimesNewRomanPSMT TimesNewRomanPS-ItalicMT TimesNewRomanPS-BoldMT TimesNewRomanPS-BoldItalicMT
    syn keyword postscrConstant contained TimesNewRomanCE TimesNewRomanCE-Italic TimesNewRomanCE-Bold TimesNewRomanCE-BoldItalic
    syn keyword postscrConstant contained Univers Univers-Oblique Univers-Bold Univers-BoldOblique
    syn keyword postscrConstant contained UniversCE-Medium UniversCE-Oblique UniversCE-Bold UniversCE-BoldOblique
    syn keyword postscrConstant contained Univers-Light Univers-LightOblique UniversCE-Light UniversCE-LightOblique
    syn keyword postscrConstant contained Univers-Condensed Univers-CondensedOblique Univers-CondensedBold Univers-CondensedBoldOblique
    syn keyword postscrConstant contained UniversCE-Condensed UniversCE-CondensedOblique UniversCE-CondensedBold UniversCE-CondensedBoldOblique
    syn keyword postscrConstant contained Univers-Extended Univers-ExtendedObl Univers-BoldExt Univers-BoldExtObl
    syn keyword postscrConstant contained UniversCE-Extended UniversCE-ExtendedObl UniversCE-BoldExt UniversCE-BoldExtObl
    syn keyword postscrConstant contained Wingdings-Regular ZapfChancery-MediumItalic ZapfChanceryCE-MediumItalic ZapfDingBats
  endif " Font names

endif " PS LL3 highlighting


if exists("postscr_ghostscript")
  " GS gstate operators
  syn keyword postscrGSOperator   .setaccuratecurves .currentaccuratecurves .setclipoutside
  syn keyword postscrGSOperator   .setdashadapt .currentdashadapt .setdefaultmatrix .setdotlength
  syn keyword postscrGSOperator   .currentdotlength .setfilladjust2 .currentfilladjust2
  syn keyword postscrGSOperator   .currentclipoutside .setcurvejoin .currentcurvejoin
  syn keyword postscrGSOperator   .setblendmode .currentblendmode .setopacityalpha .currentopacityalpha .setshapealpha .currentshapealpha
  syn keyword postscrGSOperator   .setlimitclamp .currentlimitclamp .setoverprintmode .currentoverprintmode

  " GS path operators
  syn keyword postscrGSOperator   .dashpath .rectappend

  " GS painting operators
  syn keyword postscrGSOperator   .setrasterop .currentrasterop .setsourcetransparent
  syn keyword postscrGSOperator   .settexturetransparent .currenttexturetransparent
  syn keyword postscrGSOperator   .currentsourcetransparent

  " GS character operators
  syn keyword postscrGSOperator   .charboxpath .type1execchar %Type1BuildChar %Type1BuildGlyph

  " GS mathematical operators
  syn keyword postscrGSMathOperator arccos arcsin

  " GS dictionary operators
  syn keyword postscrGSOperator   .dicttomark .forceput .forceundef .knownget .setmaxlength

  " GS byte and string operators
  syn keyword postscrGSOperator   .type1encrypt .type1decrypt
  syn keyword postscrGSOperator   .bytestring .namestring .stringmatch

  " GS relational operators (seem like math ones to me!)
  syn keyword postscrGSMathOperator max min

  " GS file operators
  syn keyword postscrGSOperator   findlibfile unread writeppmfile
  syn keyword postscrGSOperator   .filename .fileposition .peekstring .unread

  " GS vm operators
  syn keyword postscrGSOperator   .forgetsave

  " GS device operators
  syn keyword postscrGSOperator   copydevice .getdevice makeimagedevice makewordimagedevice copyscanlines
  syn keyword postscrGSOperator   setdevice currentdevice getdeviceprops putdeviceprops flushpage
  syn keyword postscrGSOperator   finddevice findprotodevice .getbitsrect

  " GS misc operators
  syn keyword postscrGSOperator   getenv .makeoperator .setdebug .oserrno .oserror .execn

  " GS rendering stack operators
  syn keyword postscrGSOperator   .begintransparencygroup .discardtransparencygroup .endtransparencygroup
  syn keyword postscrGSOperator   .begintransparencymask .discardtransparencymask .endtransparencymask .inittransparencymask
  syn keyword postscrGSOperator   .settextknockout .currenttextknockout

  " GS filters
  syn keyword postscrConstant   contained BCPEncode BCPDecode eexecEncode eexecDecode PCXDecode
  syn keyword postscrConstant   contained PixelDifferenceEncode PixelDifferenceDecode
  syn keyword postscrConstant   contained PNGPredictorDecode TBCPEncode TBCPDecode zlibEncode
  syn keyword postscrConstant   contained zlibDecode PNGPredictorEncode PFBDecode
  syn keyword postscrConstant   contained MD5Encode

  " GS filter keys
  syn keyword postscrConstant   contained InitialCodeLength FirstBitLowOrder BlockData DecodedByteAlign

  " GS device parameters
  syn keyword postscrConstant   contained BitsPerPixel .HWMargins HWSize Name GrayValues
  syn keyword postscrConstant   contained ColorValues TextAlphaBits GraphicsAlphaBits BufferSpace
  syn keyword postscrConstant   contained OpenOutputFile PageCount BandHeight BandWidth BandBufferSpace
  syn keyword postscrConstant   contained ViewerPreProcess GreenValues BlueValues OutputFile
  syn keyword postscrConstant   contained MaxBitmap RedValues

endif " GhostScript highlighting

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_postscr_syntax_inits")
  if version < 508
    let did_postscr_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink postscrComment         Comment

  HiLink postscrConstant        Constant
  HiLink postscrString          String
  HiLink postscrASCIIString     postscrString
  HiLink postscrHexString       postscrString
  HiLink postscrASCII85String   postscrString
  HiLink postscrNumber          Number
  HiLink postscrInteger         postscrNumber
  HiLink postscrHex             postscrNumber
  HiLink postscrRadix           postscrNumber
  HiLink postscrFloat           Float
  HiLink postscrBoolean         Boolean

  HiLink postscrIdentifier      Identifier
  HiLink postscrProcedure       Function

  HiLink postscrName            Statement
  HiLink postscrConditional     Conditional
  HiLink postscrRepeat          Repeat
  HiLink postscrL2Repeat        postscrRepeat
  HiLink postscrOperator        Operator
  HiLink postscrL1Operator      postscrOperator
  HiLink postscrL2Operator      postscrOperator
  HiLink postscrL3Operator      postscrOperator
  HiLink postscrMathOperator    postscrOperator
  HiLink postscrLogicalOperator postscrOperator
  HiLink postscrBinaryOperator  postscrOperator

  HiLink postscrDSCComment      SpecialComment
  HiLink postscrSpecialChar     SpecialChar

  HiLink postscrTodo            Todo

  HiLink postscrError           Error
  HiLink postscrSpecialCharError postscrError
  HiLink postscrASCII85CharError postscrError
  HiLink postscrHexCharError    postscrError
  HiLink postscrASCIIStringError postscrError
  HiLink postscrIdentifierError postscrError

  if exists("postscr_ghostscript")
    HiLink postscrGSOperator      postscrOperator
    HiLink postscrGSMathOperator  postscrMathOperator
  else
    HiLink postscrGSOperator      postscrError
    HiLink postscrGSMathOperator  postscrError
  endif

  delcommand HiLink
endif

let b:current_syntax = "postscr"

" vim: ts=8
./autoload/abc/tune_index.vim	[[[1
12
" Vim completion script
" Language: abc music programming language
" Maintainer: Lee Savide <leesavide@gmail.com>
" Version: 0.1
" Last Change: 2012-05-09 Wed 08:42 PM
" License: http://www.apache.org/licenses/LICENSE-2.0.html
" See Also: http://www.ietf.org/rfc/rfc2119.txt
" GetLatestScript:


" vim:set foldmethod=marker:

./compiler/abc/abc.vim	[[[1
61
" Vim Compiler file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
" URL:        http://abc-standard.googlecode.com/svn/trunk/vim/vimfiles/compiler/abc.vim
" License:
" {{{
"   Copyright 2012-2013 Lee Savide.
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

" TODO
" {{{
" * Add functions for transposing tunes, expanding header file inclusions,
" expanding static macros, providing support for gettext(possibly), XML
" support, omnicompletion support, & anything else that may be useful.
"
" * Provide unique ways to help make Vim detect available software; if certain
" software is not available, use the netrw plugin in clever ways to send the
" tune/abc file over the internet to web services, like music21, or abc4j
" (given that abc4j is updated and improved upon to do that sort of thing), so
" that Vim can work on & with the abc code quickly and effortlessly. The idea
" is that composers ought to be enabled to compose even if they lack the
" software on their computer to do it all. None the less, Vim will still need
" to provide support for local software over web services, but will still give
" the user the option to prefer web services over local software.
"
" * Provide a means to check the latest stable version and latest development
" version of abcm2ps on http://moinejf.free.fr/, and the latest abcmidi. Any
" additional command line software should also be checked, as well
" (abctab2ps, abcpp, abc2prt, abcmplugin, etc.)
" abcplus should also be checked, even though it's not software, since it's
" rare to find such a wonderfully made guide to abc notation.
"
" * Make Vim use 2-3 windows for abc editing: the first for any file opened,
" the 2nd to output any generated code from the Vim functions (so as to not
" change the code of the original abc file), and the 3rd to output PostScript
" to. In the status line, or in the ex command line, errors in the current
" tune should be shown. Because MIDI is a binary format, Vim wouldn't be
" able to edit it, obviously, since it's audio. However, Vim should be
" given the ability to call some sort of MIDI playback on the generated
" MIDI file.
"
" * Make Vim hold a custom session file for abc editing. Storing of a static macro
" dictionary, user-defined symbols, file inclusions, part/voice linking, etc.
" should all be stored in the session file.
"
" * Make certain things happend according to events using autocommands, such
" as error checking & header field sorting.
" }}}

./compiler/abc/abc2abc.vim	[[[1
21
" Vim compiler file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
" URL:        http://abc-standard.googlecode.com/svn/trunk/vim/vimfiles/compiler/abc/abc2midi.vim
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

./compiler/abc/abc2midi.vim	[[[1
20
" Vim compiler file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
" URL:        http://abc-standard.googlecode.com/svn/trunk/vim/vimfiles/compiler/abc/abc2midi.vim
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
./compiler/abc/abcm2ps.vim	[[[1
22
" Vim compiler file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
" URL:        http://abc-standard.googlecode.com/svn/trunk/vim/vimfiles/compiler/abc/abcm2ps.vim
" License:
" {{{
"
"   Copyright 2012-2013 Lee Savide.
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

./ftplugin/abc/abc_embedded.vim	[[[1
20
" Vim ftplugin file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
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

./ftplugin/abc/abc_fragment.vim	[[[1
20
" Vim ftplugin file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
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

./ftplugin/abc/abc_header_include.vim	[[[1
20
" Vim ftplugin file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
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

./ftplugin/abc/abc_tune.vim	[[[1
20
" Vim ftplugin file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
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

./ftplugin/abc/functions.vim	[[[1
20
" Vim ftplugin file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
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

./ftplugin/abc/variables.vim	[[[1
20
" Vim ftplugin file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
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

./autoload/README.txt	[[[1
22
The autoload directory is for standard Vim autoload scripts.

These are functions used by plugins and for general use.  They will be loaded
automatically when the function is invoked.  See ":help autoload".

gzip.vim	for editing compressed files
netrw*.vim	browsing (remote) directories and editing remote files
tar.vim		browsing tar files
zip.vim		browsing zip files
paste.vim	common code for mswin.vim, menu.vim and macmap.vim
spellfile.vim	downloading of a missing spell file

Omni completion files:
ccomplete.vim		C
csscomplete.vim		HTML / CSS
htmlcomplete.vim	HTML
javascriptcomplete.vim  Javascript
phpcomplete.vim		PHP
pythoncomplete.vim	Python
rubycomplete.vim	Ruby
syntaxcomplete.vim	from syntax highlighting
xmlcomplete.vim		XML (uses files in the xml directory)
./colors/README.txt	[[[1
64
README.txt for color scheme files

These files are used for the ":colorscheme" command.  They appear in the
Edit/Color Scheme menu in the GUI.


Hints for writing a color scheme file:

There are two basic ways to define a color scheme:

1. Define a new Normal color and set the 'background' option accordingly.
	set background={light or dark}
	highlight clear
	highlight Normal ...
	...

2. Use the default Normal color and automatically adjust to the value of
   'background'.
	highlight clear Normal
	set background&
	highlight clear
	if &background == "light"
	  highlight Error ...
	  ...
	else
	  highlight Error ...
	  ...
	endif

You can use ":highlight clear" to reset everything to the defaults, and then
change the groups that you want differently.  This also will work for groups
that are added in later versions of Vim.
Note that ":highlight clear" uses the value of 'background', thus set it
before this command.
Some attributes (e.g., bold) might be set in the defaults that you want
removed in your color scheme.  Use something like "gui=NONE" to remove the
attributes.

To see which highlight group is used where, find the help for
"highlight-groups" and "group-name".

You can use ":highlight" to find out the current colors.  Exception: the
ctermfg and ctermbg values are numbers, which are only valid for the current
terminal.  Use the color names instead.  See ":help cterm-colors".

The default color settings can be found in the source file src/syntax.c.
Search for "highlight_init".

If you think you have a color scheme that is good enough to be used by others,
please check the following items:

- Does it work in a color terminal as well as in the GUI?
- Is "g:colors_name" set to a meaningful value?  In case of doubt you can do
  it this way:
  	let g:colors_name = expand('<sfile>:t:r')
- Is 'background' either used or appropriately set to "light" or "dark"?
- Try setting 'hlsearch' and searching for a pattern, is the match easy to
  spot?
- Split a window with ":split" and ":vsplit".  Are the status lines and
  vertical separators clearly visible?
- In the GUI, is it easy to find the cursor, also in a file with lots of
  syntax highlighting?
- Do not use hard coded escape sequences, these will not work in other
  terminals.  Always use color names or #RRGGBB for the GUI.
./compiler/README.txt	[[[1
11
This directory contains Vim scripts to be used with a specific compiler.
They are used with the ":compiler" command.

These scripts usually set options, for example 'errorformat'.
See ":help write-compiler-plugin".

If you want to write your own compiler plugin, have a look at the other files
for how to do it, the format is simple.

If you think a compiler plugin you have written is useful for others, please
send it to Bram@vim.org.
./doc/abc-plugin.txt	[[[1
346
*abc-vim.txt*    For Vim version 7.3.  Last change: 2012 Jun 14

                  -------------------------------
                  abc Music Notation, version 2.1
                  -------------------------------

Author:  Lee Savide <laughingman182@gmail.com>, or <laughingman182@yahoo.com>
Copyright: (c) 2012 by Lee Savide                *abc-vim-copyright*
    |pi_abc.txt| by Lee Savide is licensed under a Creative Commons
    Attribution-NonCommercial-ShareAlike 3.0 Unported License. Please
    read the license deed at
    http://creativecommons.org/licenses/by-nc-sa/3.0/.

==============================================================================
CONTENTS                                                    *abc-vim-contents*

    1. Introduction                  |abc-vim|
    2. Prerequisites                 |abc-prerequisites|
    3. Why abc-vim?                  |abc-why|
    4. abc Intro                     |abc-intro|
        4.1. abc vs. Commercial      |abc-is-free-dom|
        4.2. The abc Code 'Feel'     |abc-feel|
        4.3. Suggested Reading       |abc-reading|
        4.4. Practice!               |abc-practice|
    5. abc syntax                    |abc-syntax|
        5.1.                         |abc-syntax-|
        5.2.                         |abc-syntax-|
        5.3.                         |abc-syntax-|
        5.4.                         |abc-syntax-|
        5.5.                         |abc-syntax-|
        5.6.                         |abc-syntax-|
        5.7.                         |abc-syntax-|
        5.8.                         |abc-syntax-|
        5.9.                         |abc-syntax-|
        5.10.                        |abc-syntax-|
        5.11.                        |abc-syntax-|
        5.12.                        |abc-syntax-|
        5.13.                        |abc-syntax-|
        5.14.                        |abc-syntax-|
    6. Folding                       |abc-folding|
    7. Placeholders                  |abc-placeholders|
    8. Compilers                     |abc-compilers|
    9. Omnicompletion                |abc-omni|
    10.                              |abc-vim-|
    11. Options                      |abc-options|
       11.1. Registered Tunes        |abc-register-files|
       11.2. Temporary Tunes         |abc-temporary-files|
       11.3. Per-Tune Options        |abc-local-options|
       11.4. Global Options          |abc-global-options|
    12. Help                         |abc-help|
    13. Developers                   |abc-developers|
    14. Changelog                    |abc-changelog|
    15. Licenses                     |abc-licenses|
    16. Todo                         |abc-todo|

==============================================================================
1. Introduction                                                      *abc-vim*

abc-vim is an update for the syntax highlighting for the abc music notation
language that comes standard in Vim, and also provides features for the abc
music notation languages by making full use of all the things that make Vim
such a wonderful text editor.

For the moment, the only part of the scripts that will be worked on is the
syntax script, since that lets all the other scripts that will be worked on in
the future something to work from.

==============================================================================
2. Prerequisites                                       *abc-vim-prerequisites*

Make sure you have these settings in your vimrc file: >
    set nocompatible                                                         ~
    filetype plugin on                                                       ~
    syntax on                                                                ~
    set omnifunc=syntaxcomplete#Complete                                     ~

Without them abc-vim will not work properly. Nor will Vim, if you don't use 
'set nocompatible'.

Additionally, I would suggest that you first be able to understand common
concepts in music theory. For any one who may be new to writing music,
I suggest using this guide as a means to get familiar with the abc standard,
while also learning how music notation works in general: >

    http://abcplus.sourceforge.net/#ABCGuide

If it interests you, you can also learn to make a tin whistle from PVC pipe: >

    http://www.ggwhistles.com/howto/

Both the guide and the how-to on making tin whistles are written by the same
author, Dr. Guido Gonzato, from Verona, Italy. Both guides are written very well,
especially for someone who has admitted to me in an email that English was
not his first language. Both guides are free to download at your leasure. The
ABC PLus guide is under a GNU GPL license(technically, I think that makes it
FDL, though, but oh well), and the how-to guide is licensed under a Creative
Commons Attribution-NonCommercial-NoDerivs 3.0 Unported license. Please read
the Creative Commons deed for the how-to guide at: >
 
    http://creativecommons.org/licenses/by-nc-nd/3.0/

And also read the terms and conditions of the GNU GPL at: >

    http://www.gnu.org/licenses/gpl-3.0.txt

Or in HTML at: >

    http://www.gnu.org/licenses/gpl-3.0-standalone.html

==============================================================================
3. Why abc-vim?                                                  *abc-vim-why*

abc is a very powerful standard for writing music. The only problem it
currently has is popularity. No one knows about abc because the commercial
applications for music notation, like Finale or Sibelius, have too much 
say in being the 'professional' standard. The sad thing is, abc is FAR more
useful. The format of abc music notation is what makes it stand out; it TEACHES
you how music theory works as you use it. 

==============================================================================
4. ABC Intro                                                   *abc-intro*

Author: John Chambers <jc@trillian.mit.edu>
-----------------------------------------------------------------------------
               An Introduction to ABC Music Notation                        ~
                        by John Chambers                                    ~
                       <jc@trillian.mit.edu>                                ~
-----------------------------------------------------------------------------
Here's a simple example of abc notation for a well-known Irish jig: >

X: 1
T: The Kesh Jig
T: The Kincora Jig
R: jig
M: 6/8
L: 1/8
K: G
D \
| "G"~G3       GAB | "D7"~A3     ABd | "G"edd gdd | "D7"edB   dBA \
| "G"~G3 "(Em)"GAB | "Am"~A3 "D7"ABd | "G"edd gdB | "D7"AGF "G"G2 :|
|: A \
| "G"~B3 dBd | "C"ege "G"dBG | "G"~B3 dBG | "Am"~A3 "D7"AGA \
| "G"~B3 dBd | "C"ege "G"dBd | "C"~g3 aga | "D7"bgf  "G"g2 :|
<

This is fairly easy to read, and once you understand it, you can quickly
start typing in your own tunes.

-----------------------------------------------------------------------------
4.1 Headers                                        *abc-intro-headers*

First, there are a bunch of "header" lines that say things about the tune as
a whole. The X: line merely gives an index number. If a file has several
tunes, they should all be given different X numbers. Some ABC software lets
you use the X: number to extract tunes from collections, sort of like the way
that some CD players let you pick the order of play.

The T:  lines give titles. This tune has two titles. I put "The Kesh Jig"
first because, in my experience, that's the one that is the best known.
Printing software will typically show the first title in a larger font than
others, which are considered "subtitles".

The R: line ("rhythm") says it's a jig. This is also used by some software.
For example, f you're on a Unix-like system you could use a command like: >
   grep -li "R: *jig" *.abc
<
to locate all the jigs in a directory of abc files.

The M: line gives the meter, 6/8 in this case. You can use M:C and M:C| for
the obvious "common" (4/4) and "cut" (2/2) times. You can also say M:none for
no time signature at all.

The L: line gives the basic or default length of a note. In this case, L:1/8
says that a note without any time modifier is an eighths note (semiquaver).
This is only used in converting ABC to printed music.

The K: line gives the key. In this case, the key is G major. "K: Gm" would
mean G minor. The abc standard also includes the classical modes, so that "K:
Gdor" means G dorian (one flat), and "K:  Amix" means A Mixolydian (two
sharps). The mode can be spelled out or abbreviated to three characters, and
minor can be abbreviated to just m.

ABC's rules say that the X: and T: lines must be first, and the K: line is
the last of the header lines. Then comes the fun part, the music.

-----------------------------------------------------------------------------
4.2 Music                                               *abc-intro-music*

First, if you play a melody instrument, you can ignore all the stuff in
double quotes. Those are called "accompaniment chords". They are to be played
on guitar or accordion or harp or whatever. Now that you know what they are,
you can probably understand the chords in this tune. So we can ignore them,
and the first part of the tune is:

   D \
   | ~G3 GAB | ~A3 ABd | edd gdd | edB dBA \

The backslash means "continued on next line", and is used to merge several
lines of abc into one staff. When reading, we can ignore backslashes, and the
result is:
   D | ~G3 GAB | ~A3 ABd | edd gdd | edB dBA

The letters A-G and a-g are notes. Large notes are the bottom half of the
staff, and lower case is the upper half. The scale actually runs CDEFGAB,
with C being the C below the staff, and B being the line in the middle of the
treble staff. Similarly, cdefgab is the scale from the c in the middle of the
staff to the b above the staff. Programmers hate this, but musicians will see
why it's a good idea.

A number after a note is a note length. So G3 means a G three times as long
as the L: value. In this case, it's a G of length 3/8, or a dotted quarter
note.  You can also use fractions if you wish. So G3/2 would mean a G of
length 3/16, or a dotted eighth note. You can omit a numerator of 1 or a
denominator of 2, so G1/2, G/2 and G/ all mean the same thing, a G of length
1/16 in this tune.

The only thing left to understand the above line is knowing that ~ is
notation for a "turn". It is displayed as a large ~ symbol above or below the
note, and played however you feel like playing it.

So, to translate this all into rather coarse ASCII graphics, here are the
first two bars of the above line:

                                                                 ,|
                                           ,|                  ,/ |
         |\                 ~            ,/ |     ~          ,/   |
     ----|/--#----------|--------------,/---|-|------------,/-|---|-|
         /              |            ,/ |   | |   |       |   |   | |
     ---/|-----6--------|---|-------|---|---|-|---|-------|---|-(*)-|
       / |              |   |       |   |   | |   |       |   |     |
     -/--|----------|\--|---|-------|---|-(*)-|---|-------|-(*)-----|
     (  /| \        | | |   | .     | (*)     | (*) .   (*)         |
     -\--|-/---8----|-|-|-(*)-----(*)---------|---------------------|
       \ |/         | ' |                     |                     |
     ----|----------|---|---------------------|---------------------|
         J        (*)

Wow, that was difficult to type! The ABC notation is much easier, especially
if you're a keyboard player. But anyone who plays any instrument should find
ABC fairly easy to type.

-----------------------------------------------------------------------------
Let's see, what else do you need to know? Oh, yes; in the above tune, you'll
see |: and :| symbols. You guessed right; these are repeat symbols. I left
out the |: at the beginning, as is done in a lot of printed music. You can
also indicate first and second endings:
    |: ...  |1 ...  :|2 ...  ||
where ... represents any music. The || symbol represents a double bar, and
you can use [| and |] to get the thick+thin or thin+thick styles of double
bars. You can also use :: in the middle of a line as a shorthand for :||:,
that is, double bars with repeats on both sides.

There's also notation for two more octaves. It is sort of pictorial, using a
comma (,) for "one octave down" and an apostrophe (') for "one octave up. So
G,A,B, are the three lowest notes on a fiddle or mandolin, and c' is the
second leger line above the treble staff.

It's also useful to be able to include rests. The ABC symbol for a rest is
the letter 'z' (and note that it's lower case). It is used just like a note,
and takes lengths in the same manner.

Something not covered in the above example is accidentals. There is an
obvious problem with the ASCII character set: It has a sharp sign, but no
natural or flat sign. The solution is simple: _G is a G flat; =G is a G
natural, and ^G is a G sharp. Note that this is a bit inconsistent with the
notation for keys and chords: K:Gb and K:G# are how you indicate keys of G
flat and G sharp; "Gbm" and "G#7" are G flat minor and G sharp seventh
chords. But since 'b' is used for a note, it can't be used with notes to
indicate a flat. So the pictorial _=^ symbols are used.

You can also indicate ties and slurs. A tie (or single-note slur) can be
indicated with a hyphen. If the above tune had started G3- GAB it would have
meant to tie the G to the G in the second group of notes. To get a slur, put
parentheses around a group of notes. Thus, in the above example, you might
indicate a generic jig bowing by writing:
   D | ~G2G (GA)B | ~A2A (AB)d | (ed)d (gd)d | (ed)B (dB)A |

A few words about spacing: I've used more spaces in the above examples than
you really need. About the only spaces that are needed within the music are
the ones that separate groups of notes. This is used by abc display or print
programs to determine how notes are beamed together. If the third bar had
been |eddgdd|, the result would be six notes all beamed together. If you
write |ed dg dd| you would get a waltz-type beaming, with three groups of two
notes each. |edd gdd| gives two groups of three notes each.

Spaces around the bar lines aren't needed, but they help a lot if you want
your ABC to be readable by humans. Also, the header lines don't need spaces
after the colons, but they add slightly to readability.

There are some other useful header lines. C: is used to indicate the
Composer. O: is used to comment on the Origin. S: is used to give a Source.
B: is used to list Books where the music can be found. D: means discography
(recordings). H: is used for Historical notes. N: is used for random other
notes. And you should put your name and email address on a Z: line, which is
used to indicate who did the transcription. (T: was already taken.) You can
see O:Trad in a lot of old tunes. And Q:120 or Q:1/4=110 may be used to
indicate a metronome setting.

There's more to ABC, but this is all you need to know to read or write
typical folk tunes. Now go to your favorite editor and type in a few tunes.
And check out the ABC home page: >
   http://abcnotation.org.uk/
You'll find pointers to lots of software and music collections there.
-----------------------------------------------------------------------------

This is the second file from my set of ABC documents. Some others: >
  http://trillian.mit.edu/~jc/music/abc/doc/ABCtrivial.txt
  http://trillian.mit.edu/~jc/music/abc/doc/ABCintro.txt    (this file)
  http://trillian.mit.edu/~jc/music/abc/doc/ABCprimer.html
  http://trillian.mit.edu/~jc/music/abc/doc/ABCtut.html
<
==============================================================================
5.                                                            *abc-vim-syntax*

==============================================================================
6.                                                           *abc-vim-folding*

==============================================================================
7.                                                      *abc-vim-placeholders*

==============================================================================
8.                                                         *abc-vim-compilers*

==============================================================================
9.                                                              *abc-vim-omni*

==============================================================================
10.                                                          *abc-vim-options*

==============================================================================
11.                                                             *abc-vim-help*

==============================================================================
12.                                                       *abc-vim-developers*

==============================================================================
13.                                                        *abc-vim-changelog*

==============================================================================
15.                                                         *abc-vim-licenses*

==============================================================================
16. Todo                                                        *abc-vim-todo*


"vim:tw=78:ts=8:ft=help
./doc/abc_v1.6.txt	[[[1
453

This description of abc notation has been created for  those  who
do  not want to (or cannot) use the package ABC2MTeX but who wish
to  understand  the  notation.  It  has  been   generated   semi-
automatically  from  the  ABC2MTeX  userguide and so occasionally
refers to other parts of the package. In particular, it  mentions
the  document  index.tex, a guide to using ABC2MTeX for archiving
and  indexing  tunes,  and  to  the  example  files  English.abc,
Strspys.abc  and Reels.abc. It also refers to playabc, a separate
package for playing abc tunes  through  the  speaker  of  various
machines.  It is best read in conjunction with an introduction to
abc notation available by anonymous ftp from

        celtic.stanford.edu/pub/tunes/abc2mtex/INTRO.txt

or, if you have WWW access,

        http://celtic.stanford.edu/pub/tunes/abc2mtex/INTRO.html

Note that if you are intending to use  the  notation  solely  for
transcribing  tunes,  you  can  ignore most of description of the
information fields as all you really need are the  T  (title),  M
(meter),  K (key), and possibly L (default note length) fields. I
have included a full description however, for those who  wish  to
understand tunes transcribed by users of the package.

Finally, the notation can easily be  expanded  to  include  other
musical symbols. Please mail me with any suggestions.

        Chris Walshaw
        C.Walshaw@gre.ac.uk

-----------------------------------------------------------------

        The abc Notation System
        =======================

Each tune consists of a header and a body. The header,  which  is
composed of information fields, should start with an X (reference
number) field followed by a T (title) field and finish with  a  K
(key)  field.  The body of the tune in abc notation should follow
immediately after. Tunes are separated by blank lines.

  Information fields
  ==================

The  information  fields  are  used  to  notate  things  such  as
composer,  meter, etc. in fact anything that isn't music. Most of
the information fields are for use within a tune  header  but  in
addition  some  may be used in the tune body, or elsewhere in the
tune file. Those which are allowed elsewhere can be used  to  set
up  a  default  for  the whole or part of a file. For example, in
exactly the same way that tunebooks are organised, a  file  might
start  with  M:6/8 and R:Jigs, followed by some jigs, followed by
M:4/4 and R:Reels, followed by  some  reels.  Tunes  within  each
section then inherit the M: and R: fields automatically, although
they can be overridden inside a tune header.  Finally  note  that
any line beginning with a letter in the range A-Z and immediately
followed by a : is interpreted as a field (so that line like E:|,
which  could  be  regarded  as  an  E  followed by a right repeat
symbol, will cause an error).

By far the best way to find out how to use the fields is to  look
at the example files (in particular English.abc) and try out some
examples. Thus rather than describing them in  detail,  they  are
summarised  in  the following table. The second, third and fourth
columns specify respectively how the field should be used in  the
header  and  whether it may used in tune body or elsewhere in the
file. Certain fields do not affect  the  typeset  music  but  are
there  for  other  reasons,  and  the fifth column reflects this;
index fields only affect the index (see index.tex) while  archive
fields  do not affect the output at all, but are just provided to
put in information that one might find in,  say,  a  conventional
tunebook.

Field name            header tune elsewhere Used by Examples and notes
==========            ====== ==== ========= ======= ==================
A:area                yes                           A:Donegal, A:Bampton
B:book                yes         yes       archive B:O'Neills
C:composer            yes                           C:Trad.
D:discography         yes                   archive D:Chieftans IV
E:elemskip            yes    yes                    see Line Breaking
F:file name                         yes               see index.tex
G:group               yes         yes       archive G:flute
H:history             yes         yes       archive H:This tune said to ...
I:information         yes         yes       playabc
K:key                 last   yes                    K:G, K:Dm, K:AMix
L:default note length yes    yes                    L:1/4, L:1/8
M:meter               yes    yes  yes               M:3/4, M:4/4
N:notes               yes                           N:see also O'Neills - 234
O:origin              yes         yes       index   O:I, O:Irish, O:English
P:parts               yes    yes                    P:ABAC, P:A, P:B
Q:tempo               yes    yes                    Q:200, Q:C2=200
R:rhythm              yes         yes       index   R:R, R:reel
S:source              yes                           S:collected in Brittany
T:title               second yes                    T:Paddy O'Rafferty
W:words                      yes                    W:Hey, the dusty miller
X:reference number    first                         X:1, X:2
Z:transcription note  yes                           Z:from photocopy

Some additional notes on certain of the fields:-

T - tune title. Some tunes have more than one title and  so  this
field  can  be used more than once per tune - the first time will
generate the title whilst  subsequent  usage  will  generate  the
alternatives  in  small  print.   The  T:  field can also be used
within a tune to name parts of a tune - in this  case  it  should
come before any key or meter changes.

K - key; the key signature should be  specified  with  a  capital
letter  which  may  be  followed  by  a  # or b for sharp or flat
respectively. In addition,  different  scales  or  modes  can  be
specified  and,  for  example,  K:F  lydian,  K:C, K:C major, K:C
ionian, K:G mixolydian, K:D dorian, K:A minor, K:Am, K:A aeolian,
K:E  phrygian  and  K:B locrian would all produce a staff with no
sharps or flats.  The spaces can be left out,  capitalisation  is
ignored for the modes and in fact only the first three letters of
each mode are parsed so that, for example, K:F# mixolydian is the
same  as  K:F#Mix or even K:F#MIX.  There are two additional keys
specifically for notating highland bagpipe  tunes;  K:HP  doesn't
put  a  key  signature  on the music, as is common with many tune
books of this music, while K:Hp marks the stave with F  sharp,  C
sharp  and  G natural.  Both force all the beams and staffs to go
downwards.

Finally, global accidentals can also be  set  in  this  field  so
that,  for  example,  K:D =c would write the key signature as two
sharps (key of D) but then mark every  c  as  natural  (which  is
conceptually  the same as D mixolydian).  Note that the there can
be several global  accidentals,  separated  by  spaces  and  each
specified  with  an  accidental,  __,  _, =, ^ or ^^, (see below)
followed by a  letter  in  lower  case.  Global  accidentals  are
overridden  by  accidentals  attached to notes within the body of
the abc tune and are reset by each change of signature.

L - default note length; i.e.  L:1/4  -  quarter  note,  L:1/8  -
eighth  note,  L:1/16  -  sixteenth,  L:1/32 - thirty-second. The
default note length is also set automatically by the meter  field
M: (see below).

M - meter; apart from the normal meters, e.g.   M:6/8  or  M:4/4,
the   symbols  M:C  and  M:C|  give  common  time  and  cut  time
respectively.

P - parts; can be used in the header to state the order in  which
the  tune parts are played, i.e.  P:ABABCDCD, and then inside the
tune to mark each part, i.e.  P:A or P:B.

Q - tempo; can be used to specify the notes per minute, e.g.   if
the  default  note length is an eighth note then Q:120 or Q:C=120
is 120 eighth notes per minute. Similarly  Q:C3=40  would  be  40
dotted  quarter  notes per minute.  An absolute tempo may also be
set,  e.g.  Q:1/8=120  is  also  120  eighth  notes  per  minute,
irrespective of the default note length.

G - group; to group together tunes for indexing purposes.

H - history; can be used for multi-line stories/anecdotes, all of
which will be ignored until the next field occurs.


  abc tune notation
  =================

The following letters are used to represent notes:-


                                                      d'
                                                -c'- ----
                                             b
                                        -a- --- ---- ----
                                       g
 ------------------------------------f-------------------
                                   e
 --------------------------------d-----------------------
                               c
 ----------------------------B---------------------------
                           A
 ------------------------G-------------------------------
                       F
 --------------------E-----------------------------------
                   D
 ---- ---- ---- -C-
            B,
 ---- -A,-
  G,

and by extension, the notes C, D, E, F, a' and b' are  available.
Notes can be modified in length (see below).

  Rests
  =====

Rests are generated with a z and can be  modified  in  length  in
exactly the same way as notes can.

  Note lengths
  ============

NB  Throughout  this  document  note  lengths  are  referred   as
sixteenth,  eighth,  etc.   The  commonly  used  equivalents  are
sixteenth note = semi-quaver, eighth = quaver, quarter = crotchet
and half = minim.

Each meter automatically sets a default note length and a  single
letter in the range A-G, a-g will generate a note of this length.
For example, in 3/4 the default note length is an eighth note and
so  the  input  DEF  represents  3 eighth notes. The default note
length can be calculated by computing the meter as a decimal;  if
it  is  less than 0.75 the default is a sixteenth note, otherwise
it is an eighth note. For example, 2/4 = 0.5, so the default note
length is a sixteenth note, while 4/4 = 1.0 or 6/8 = 0.75, so the
default is an eighth note. Common time  and  cut  time  (M:C  and
M:C|) have an eighth note as default.

Notes of differing lengths can be obtained by  simply  putting  a
multiplier  after the letter. Thus in 2/4, A or A1 is a sixteenth
note, A2 an eighth note, A3 a dotted eighth note,  A4  a  quarter
note,  A6 a dotted quarter note, A7 a double dotted quarter note,
A8 a half note, A12 a dotted half note, A14 a double dotted  half
note,  A15  a triple dotted half note and so on, whilst in 3/4, A
is an eighth note, A2 a quarter note, A3 a dotted  quarter  note,
A4 a half note, ...

To get shorter notes, either divide them - e.g. in 3/4, A/2 is  a
sixteenth  note,  A/4  is  a  thirty-second  note - or change the
default note length with the L:  field.   Alternatively,  if  the
music has a broken rhythm, e.g. dotted eighth note/sixteenth note
pairs, use broken rhythm markers (see below).  Note  that  A/  is
shorthand for A/2.

  Broken rhythms
  ==============

A common occurrence in traditional music is the use of  a  dotted
or broken rhythm. For example, hornpipes, strathspeys and certain
morris jigs all have dotted eighth notes  followed  by  sixteenth
notes  as  well  as  vice-versa  in  the  case of strathspeys. To
support this abc notation uses a > to mean `the previous note  is
dotted, the next note halved' and < to mean `the previous note is
halved, the next dotted'. Thus the following lines all  mean  the
same thing (the third version is recommended):

  L:1/16
  a3b cd3 a2b2c2d2

  L:1/8
  a3/2b/2 c/2d3/2 abcd

  L:1/8
  a>b c<d abcd

As a logical extension, >> means that the first  note  is  double
dotted and the second quartered and >>> means that the first note
is triple dotted and the length of the second divided  by  eight.
Similarly for << and <<<.

  Duplets, triplets, quadruplets, etc.
  ====================================

These can be simply coded with the notation (2ab  for  a  duplet,
(3abc  for  a triplet or (4abcd for a quadruplet, etc., up to (9.
The musical meanings are:


 (2 2 notes in the time of 3
 (3 3 notes in the time of 2
 (4 4 notes in the time of 3
 (5 5 notes in the time of n
 (6 6 notes in the time of 2
 (7 7 notes in the time of n
 (8 8 notes in the time of 3
 (9 9 notes in the time of n

If the time signature is compound (3/8, 6/8, 9/8, 3/4, etc.) then
n is three, otherwise n is two.

More general tuplets can be specified  using  the  syntax  (p:q:r
which  means  `put  p  notes  into  the  time of q for the next r
notes'.  If q is not given, it defaults as above.  If  r  is  not
given,  it  defaults  to p.  For example, (3:2:2 is equivalent to
(3::2 and (3:2:3 is equivalent to (3:2 , (3 or even (3:: .   This
can  be  useful  to  include  notes of different lengths within a
tuplet, for example (3:2:2G4c2 or (3:2:4G2A2Bc and also describes
more precisely how the simple syntax works in cases like (3D2E2F2
or even (3D3EF2. The number written over the tuplet is p.

  Beams
  =====

To group notes together under one beam  they  should  be  grouped
together without spaces. Thus in 2/4, A2BC will produce an eighth
note followed by two sixteenth notes under one beam whilst A2 B C
will  produce  the  same notes separated. The beam slopes and the
choice of upper or lower staffs are generated automatically.

  Repeat/bar symbols
  ==================

Bar line symbols are generated as follows:


 | bar line
 |] thin-thick double bar line
 || thin-thin double bar line
 [| thick-thin double bar line
 :| left repeat
 |: right repeat
 :: left-right repeat



  First and second repeats
  ========================

First and second repeats can be generated with the symbols [1 and
[2,  e.g.  faf gfe|[1 dfe dBA:|[2 d2e dcB|]. When adjacent to bar
lines, these can be shortened to |1 and :|2, but with  regard  to
spaces | [1 is legal, | 1 is not.

  Accidentals
  ===========

The symbols ^ = and _  are  used  (before  a  note)  to  generate
respectively  a  sharp,  natural or flat. Double sharps and flats
are available with ^^ and __ respectively.

  Changing key, meter, and default note length mid-tune
  =====================================================

To change key, meter, or default note length, simply put in a new
line with a K: M: or L: field, e.g.
  ed|cecA B2ed|cAcA E2ed|cecA B2ed|c2A2 A2:|
  K:G
  AB|cdec BcdB|ABAF GFE2|cdec BcdB|c2A2 A2:|

To do this without generating a new line of music, put a \ at the
end of the first line, i.e.
  E2E EFE|E2E EFG|\
  M:9/8
  A2G F2E D2|]

  Ties and slurs
  ==============

You can tie two notes together either across or within a bar with
a  - symbol, e.g. abc-|cba or abc-cba.  More general slurs can be
put in with () symbols.  Thus (DEFG) puts a slur  over  the  four
notes.  Spaces within a slur are OK, e.g. (D E F G), but the open
bracket  should  come  immediately  before  a   note   (and   its
accents/accidentals,  etc.)  and  the  close  bracket should come
immediately after a note (and its octave marker or length).  Thus
(=b c'2) is OK but ( =b c'2 ) is not.

  Gracings
  ========

Grace notes can be written by enclosing  them  in  curly  braces,
{}.  For  example,  a  taorluath  on  the Highland pipes would be
written  {GdGe}. The tune `Athol Brose' (in the file Strspys.abc)
has an example of complex Highland pipe gracing in all its glory.
Grace notes have no time value and so expressions such  as   {a2}
or  {a>b} are not legal.

Alternatively, the tilde symbol ~ represents the general  gracing
of  a  note  which, in the context of traditional music, can mean
different things for different instruments, for example  a  roll,
cran or staccato triplet

  Accents
  =======

Staccato marks (a small dot above or below the note head) can  be
generated  by  a  dot before the note, i.e. a staccato triplet is
written as (3.a.b.c

For fiddlers, the letters u and v can be used  to  denote  up-bow
and down-bow, e.g. vAuBvA

  Chords and unisons
  ==================

Chords (i.e. more than one note head on a  single  stem)  can  be
coded  with [] symbols around the notes, e.g. [CEGc] produces the
chord  of  C  major.  They  can  be  grouped   in   beams,   e.g.
[d2f2][ce][df] but there should be no spaces within a chord.  See
the tune `Kitchen Girl'  in  the  file  Reels.abc  for  a  simple
example.

If the chord contains two notes  both  of  the  same  length  and
pitch,  such  as [DD], then it is a unison (e.g. a note played on
two strings of a violin simultaneously) and is shown as note-head
with both upward and downward stems.

  Guitar chords
  =============

Guitar chords can be put in under the melody  line  by  enclosing
the  chord  in  inverted  commas,  e.g.  "Am7"A2D2 . See the tune
`William and Nancy' in English.abc for an example.

  Order of symbols
  ================

The order of symbols for one note is <guitar  chords>,  <accents>
(e.g. roll, staccato marker or up/downbow), <accidental>, <note>,
<octave>, <note length>, i.e. ~^c'3 or even "Gm7"v.=G,2

Tie symbols, -, should come immediately after a  note  group  but
may  be  followed  by  a space, i.e. =G,2- . Open and close chord
symbols, [], should enclose entire  note  sequences  (except  for
guitar  chords),  i.e.  "C"[CEGc]  or "Gm7"[.=G,^c'] and open and
close   slur   symbols,   (),   should    do    likewise,    i.e.
"Gm7"(v.=G,2~^c'2)


  Comments
  ========

A % symbol will cause the remainder  of  any  input  line  to  be
ignored. The file English.abc contains plenty of examples.

  New notation
  ============

The letters H-Z can be used  to  define  your  own  new  notation
within a tune. Currently the way they are implemented (if at all)
is extremely package dependent and so users are  advised  not  to
rely  too  heavily  on  them to include new features. Instead, if
there is a feature or symbol that  you  need  and  which  is  not
available  it  is better to press for it to be included as a part
of the language.

  Line breaking and justification
  ===============================

Generally one line of abc  notation  will  produce  one  line  of
music,  although  if  the music is too long it will overflow onto
the next line. This can look very  effective,  but  it  can  also
completely  ruin  ties  across  bar  lines,  for example. You can
counteract this by changing either the note spacing with  the  E:
field (although currently this is package dependent) or break the
line of abc notation. If, however, you wish to use two  lines  of
input  to  generate  one  line  of  music  (see, for example, the
`Untitled Reel' in Reels.abc) then simply put a \ at the  end  of
the first line.  This is also useful for changing meter or key in
the middle of a line of music.

With most packages lines of music are  right-justified.  However,
where this is not the case (e.g. when using MusicTeX), a * at the
end of each line of abc notation  will  force  a  right-justified
line-break.

./doc/abc_v1.7.6-draft.txt	[[[1
700
$===============================================================$
$       This document is the draft revised abc standard         $
$       currently being discussed on the abcusers list.         $
$             Version 1.7.6, date 08/05/00                      $
$       Other topics being discussed and not yet assimilated    $
$       here include                                            $
$         the V field (for specifying voices)                   $
$         repeat endings                                        $
$       Other topics which need to be addressed include         $
$         separate dynamics line (as opposed to inline)         $
$         separate chord accompaniment line                     $
$       Topics which don't seem to have reached any agreement   $
$       include                                                 $
$         version numbering as part of the abc language         $
$         transposition as part of the abc language             $
$           (as opposed to part of a player/notation package)   $
$       Further suggestions should be posted to the             $
$       abcusers list.                                          $
$                                                               $
$       Lines which have changed since the previous version     $
$       of the standard are prefixed with a $.                  $
$===============================================================$

This description of abc notation has been created for  those  who
do  not want to (or cannot) use the package ABC2MTeX but who wish
to  understand  the  notation.  It  has  been   generated   semi-
automatically  from  the  ABC2MTeX  userguide and so occasionally
refers to other parts of the package. In particular, it  mentions
the  document  index.tex, a guide to using ABC2MTeX for archiving
and  indexing  tunes,  and  to  the  example  files  English.abc,
Strspys.abc  and Reels.abc. It also refers to playabc, a separate
package for playing abc tunes  through  the  speaker  of  various
machines.  It is best read in conjunction with an introduction to
abc notation available from

        http://www.gre.ac.uk/~c.walshaw/abc2mtex/INTRO.html

$ Since the document was originally written a large number of abc
$ packages (programs which either typeset the abc notation into
$ standard notation or playback the abc through the speakers of
$ a computer) have been developed. Not all of them follow this
$ standard absolutely however and this document does at some points
$ give hints about some of the more package specific features.

Note that if you are intending to use  the  notation  solely  for
transcribing  tunes,  you  can  ignore most of description of the
information fields as all you really need are the  T  (title),  M
$ (meter),  K (key), and possibly L (unit note length) fields. I
have included a full description however, for those who  wish  to
understand tunes transcribed by users of the package.

        Chris Walshaw
        C.Walshaw@gre.ac.uk

-----------------------------------------------------------------

        The abc Notation System
        =======================

Each tune consists of a header and a body. The header,  which  is
composed of information fields, should start with an X (reference
number) field followed by a T (title) field and finish with  a  K
(key)  field.  The body of the tune in abc notation should follow
immediately after. Tunes are separated by blank lines.

  Information fields
  ==================

The  information  fields  are  used  to  notate  things  such  as
composer,  meter, etc. in fact anything that isn't music. Most of
the information fields are for use within a tune  header  but  in
addition  some  may be used in the tune body, or elsewhere in the
tune file. Those which are allowed elsewhere can be used  to  set
up  a  default  for  the whole or part of a file. For example, in
exactly the same way that tunebooks are organised, a  file  might
start  with  M:6/8 and R:Jigs, followed by some jigs, followed by
M:4/4 and R:Reels, followed by  some  reels.  Tunes  within  each
section then inherit the M: and R: fields automatically, although
they can be overridden inside a tune header.  Finally  note  that
any line beginning with a letter in the range A-Z and immediately
followed by a : is interpreted as a field (so that line like E:|,
which  could  be  regarded  as  an  E  followed by a right repeat
symbol, will cause an error).

By far the best way to find out how to use the fields is to  look
at the example files (in particular English.abc) and try out some
examples. Thus rather than describing them in  detail,  they  are
summarised  in  the following table. The second, third and fourth
columns specify respectively how the field should be used in  the
header  and  whether it may used in tune body or elsewhere in the
file. Certain fields do not affect  the  typeset  music  but  are
there  for  other  reasons,  and  the fifth column reflects this;
index fields only affect the index (see index.tex) while  archive
fields  do not affect the output at all, but are just provided to
put in information that one might find in,  say,  a  conventional
tunebook.

Field name            header tune elsewhere Used by Examples and notes
==========            ====== ==== ========= ======= ==================
A:area                yes                           A:Donegal, A:Bampton
B:book                yes         yes       archive B:O'Neills
C:composer            yes                           C:Trad.
D:discography         yes                   archive D:Chieftans IV
$ F:file name                     yes               F:http://a.b.c/file.abc
G:group               yes         yes       archive G:flute
H:history             yes         yes       archive H:This tune said to ...
I:information         yes         yes       playabc
K:key                 last   yes                    K:G, K:Dm, K:AMix
$ L:unit note length  yes    yes                    L:1/4, L:1/8
M:meter               yes    yes  yes               M:3/4, M:4/4
N:notes               yes                           N:see also O'Neills - 234
O:origin              yes         yes       index   O:I, O:Irish, O:English
P:parts               yes    yes                    P:ABAC, P:A, P:B
Q:tempo               yes    yes                    Q:200, Q:C2=200
R:rhythm              yes         yes       index   R:R, R:reel
S:source              yes                           S:collected in Brittany
T:title               second yes                    T:Paddy O'Rafferty
$ U:user defined      yes    yes  yes               U: T = !trill!
$ W:words                    yes                    lyrics after tune
$ w:words                    yes                    lyrics aligned with tune
X:reference number    first                         X:1, X:2
Z:transcription note  yes                           Z:from photocopy

Some additional notes on certain of the fields:-

T - tune title. Some tunes have more than one title and  so  this
field  can  be used more than once per tune - the first time will
generate the title whilst  subsequent  usage  will  generate  the
alternatives  in  small  print.   The  T:  field can also be used
within a tune to name parts of a tune - in this  case  it  should
come before any key or meter changes.

K - key; the key signature should be  specified  with  a  capital
letter  which  may  be  followed  by  a  # or b for sharp or flat
respectively. In addition,  different  scales  or  modes  can  be
specified  and,  for  example,  K:F  lydian,  K:C, K:C major, K:C
ionian, K:G mixolydian, K:D dorian, K:A minor, K:Am, K:A aeolian,
K:E  phrygian  and  K:B locrian would all produce a staff with no
sharps or flats.  The spaces can be left out,  capitalisation  is
ignored for the modes and in fact only the first three letters of
each mode are parsed so that, for example, K:F# mixolydian is the
same  as  K:F#Mix or even K:F#MIX.  There are two additional keys
specifically for notating highland bagpipe  tunes;  K:HP  doesn't
put  a  key  signature  on the music, as is common with many tune
books of this music, while K:Hp marks the stave with F  sharp,  C
sharp  and  G natural.  Both force all the beams and staffs to go
downwards.

$ Global accidentals can also be  set  in  this  field  so
that,  for  example,  K:D =c would write the key signature as two
sharps (key of D) but then mark every  c  as  natural  (which  is
conceptually  the same as D mixolydian).  Note that the there can
be several global  accidentals,  separated  by  spaces  and  each
specified  with  an  accidental,  __,  _, =, ^ or ^^, (see below)
followed by a  letter  in  lower  case.  Global  accidentals  are
overridden  by  accidentals  attached to notes within the body of
the abc tune and are reset by each change of signature.

$ Finally, the key field can also be used to specify a clef, by adding
$ the name of the clef, separated by a space from the key information,
$ e.g K:Am bass.  Some programs currently require this to be
$ written as K:Am clef=bass, but either format should be acceptable.
$ Where no clef is specified the default is treble.

$ L - unit note length; i.e. L:1/4 - quarter note, L:1/8 -
$ eighth note, L:1/16 - sixteenth, L:1/32 - thirty-second. If
$ there is no L: field in the header, a unit note length is set
$ by default, based on the meter field M: (see below).

M - meter; apart from the normal meters, e.g.   M:6/8  or  M:4/4,
$ the symbols M:C and M:C| give common time (4/4) and cut time (2/2)
$ respectively. The symbol M:none omits the meter entirely (free
$ meter).

P - parts; can be used in the header to state the order in  which
the  tune parts are played, i.e.  P:ABABCDCD, and then inside the
tune to mark each part, i.e.  P:A or P:B.
$ Within the header, a part can be repeated by following it
$ with a number e.g. P:A3 is equivalent to P:AAA and a
$ sequence can be repeated by using parentheses e.g. P:(AB)3 is
$ equivalent to P:ABABAB. Nested parentheses are permitted
$ and dots may be placed anywhere within the header P: field,
$ e.g. P:((AB)3.(CD)3)2, to increase legibility and are ignored.

$ Q -  tempo; defines the beat unit (and beats per minute) for setting tempo,
$ e.g. Q:1/2 means that a half note counts as one beat. The number of beats per
$ minute can be specified, e.g. Q:1/2=120 means 120 half-note beats per
$ minute. If no beat unit is given, one is set by default (see
$ below).

G - group; to group together tunes for indexing purposes.

H - history; can be used for multi-line stories/anecdotes, all of
which will be ignored until the next field occurs.

$ w:lyrics; supplies a line of lyrics to be aligned syllable by syllable below
$ the previous line of notes. Syllables are not aligned on grace notes and tied
$ notes are treated as two separate notes. Because lyrics tend to take up more
$ space than notes, one w: field and all continuations match one line of notes,
$ whether or not the line of notes ends with a continuation character. If a
$ line of notes is followed by several w: fields, each one supplies alternate
$ words for the notes (this is typically used for writing the verses of a song).
$ Within the lyrics, the following words should be separated by one or more
$ blank spaces and to correctly align them the following symbols may be used:
$ 
$ -       break between syllables within a word
$ |       advance to next bar
$ _       (underscore) last syllable is to be held for an extra note
$ *       one note is skipped (i.e. * is equivalent to a blank syllable)
$ ~       appears as a space but connects syllables each side into one
$ \-      appears as - sign in output.
$ \       continuation character; next w: field is part of the same line
$ 
$ Some examples:
$ w: syll-a-ble   is aligned with three notes
$ w: time__       is aligned with three notes
$ w: of~the~day   is treated as one syllable (i.e. aligned with one note)
$                  but appears as three separate words

  abc tune notation
  =================

The following letters are used to represent notes:-


                                                      d'
                                                -c'- ----
                                             b
                                        -a- --- ---- ----
                                       g
 ------------------------------------f-------------------
                                   e
 --------------------------------d-----------------------
                               c
 ----------------------------B---------------------------
                           A
 ------------------------G-------------------------------
                       F
 --------------------E-----------------------------------
                   D
 ---- ---- ---- -C-
            B,
 ---- -A,-
  G,

and by extension, the notes C, D, E, F, a' and b' are  available.
Notes can be modified in length (see below).
$ Lower octaves are reached by using 2 commas, 3 commas and so on.
$ Higher octaves are written using 2 apostrophes, 3 apostrophes and
$ so on.

  Rests
  =====

Rests are generated with a z and can be  modified  in  length  in
exactly the same way as notes can.

  Note lengths
  ============

$ NB Throughout this document note lengths are referred as sixteenth, eighth,
$ etc. The commonly used equivalents are sixteenth note = semi-quaver, eighth
$ = quaver, quarter = crotchet and half = minim.

$ The unit note length for the transcription is set in the L: field, e.g.
$ L:1/8 sets an eighth note as the unit note length. A single letter in the
$ range A-G, a-g represents a note of this length. For example, if the unit
$ note length is an eighth note, DEF represents 3 eighth notes.

$ Notes of differing lengths can be obtained by simply putting a multiplier
$ after the letter. Thus if the unit note length is 1/16, A or A1 is a
$ sixteenth note, A2 an eighth note, A3 a dotted eighth note, A4 a quarter
$ note, A6 a dotted quarter note, A7 a double dotted quarter note, A8 a half
$ note, A12 a dotted half note, A14 a double dotted half note, A15 a triple
$ dotted half note and so on. If the unit note length is 1/8, A is an eighth
$ note, A2 a quarter note, A3 a dotted quarter note, A4 a half note, and so
$ on.

$ To get shorter notes, either divide them - e.g. if A is an eighth note, A/2
$ is a sixteenth note, and A/4 is a thirty-second note - or change the unit
$ note length with the L: field. Alternatively, if the music has a broken
$ rhythm, e.g. dotted eighth note/sixteenth note pairs, use broken rhythm
$ markers (see below). Note that A/ is shorthand for A/2 and similarly A//
$ = A/4, etc.

$ If no unit note length is given explicitly in the L: field, a unit note
$ length is set by default, based on the meter. This default is calculated by
$ computing the meter as a decimal: if it is less than 0.75 the default unit
$ note length is a sixteenth note; if it is 0.75 or greater, it is an eighth
$ note. For example, 2/4 = 0.5, so, the default unit note length is a
$ sixteenth note, while for 4/4 = 1.0, or 6/8 = 0.75, or 3/4= 0.75, it is an
$ eighth note. For M:C (4/4), M:C| (2/2) and M:none (free meter), the default
$ unit note length is 1/8.

  Broken rhythms
  ==============

A common occurrence in traditional music is the use of  a  dotted
or broken rhythm. For example, hornpipes, strathspeys and certain
morris jigs all have dotted eighth notes  followed  by  sixteenth
notes  as  well  as  vice-versa  in  the  case of strathspeys. To
support this abc notation uses a > to mean `the previous note  is
dotted, the next note halved' and < to mean `the previous note is
halved, the next dotted'. Thus the following lines all  mean  the
same thing (the third version is recommended):

  L:1/16
  a3b cd3 a2b2c2d2

  L:1/8
  a3/2b/2 c/2d3/2 abcd

  L:1/8
  a>b c<d abcd

As a logical extension, >> means that the first  note  is  double
dotted and the second quartered and >>> means that the first note
is triple dotted and the length of the second divided  by  eight.
Similarly for << and <<<.

  Duplets, triplets, quadruplets, etc.
  ====================================

These can be simply coded with the notation (2ab  for  a  duplet,
(3abc  for  a triplet or (4abcd for a quadruplet, etc., up to (9.
The musical meanings are:


 (2 2 notes in the time of 3
 (3 3 notes in the time of 2
 (4 4 notes in the time of 3
 (5 5 notes in the time of n
 (6 6 notes in the time of 2
 (7 7 notes in the time of n
 (8 8 notes in the time of 3
 (9 9 notes in the time of n

$ If the time signature is compound (6/8, 9/8, 12/8) then
$ n is three, otherwise n is two.

More general tuplets can be specified  using  the  syntax  (p:q:r
which  means  `put  p  notes  into  the  time of q for the next r
notes'.  If q is not given, it defaults as above.  If  r  is  not
given,  it  defaults  to p.  For example, (3:2:2 is equivalent to
(3::2 and (3:2:3 is equivalent to (3:2 , (3 or even (3:: .   This
can  be  useful  to  include  notes of different lengths within a
tuplet, for example (3:2:2G4c2 or (3:2:4G2A2Bc and also describes
more precisely how the simple syntax works in cases like (3D2E2F2
or even (3D3EF2. The number written over the tuplet is p.

  Beams
  =====

To group notes together under one beam  they  should  be  grouped
together without spaces. Thus in 2/4, A2BC will produce an eighth
note followed by two sixteenth notes under one beam whilst A2 B C
will  produce  the  same notes separated. The beam slopes and the
choice of upper or lower staffs are generated automatically.

  Repeat/bar symbols
  ==================

Bar line symbols are generated as follows:


 | bar line
 |] thin-thick double bar line
 || thin-thin double bar line
 [| thick-thin double bar line
$ |: start of repeated section
$ :| end of repeated section
$ :: start & end of two repeated sections



  First and second repeats
  ========================

First and second repeats can be generated with the symbols [1 and
[2,  e.g.  faf gfe|[1 dfe dBA:|[2 d2e dcB|]. When adjacent to bar
lines, these can be shortened to |1 and :|2, but with  regard  to
spaces | [1 is legal, | 1 is not.

  Accidentals
  ===========

The symbols ^ = and _  are  used  (before  a  note)  to  generate
respectively  a  sharp,  natural or flat. Double sharps and flats
are available with ^^ and __ respectively.

$ Changing key, meter, and unit note length mid-tune
  ==================================================

$ To change key, meter, or unit note length, simply put in a new
line with a K: M: or L: field, e.g.
  ed|cecA B2ed|cAcA E2ed|cecA B2ed|c2A2 A2:|
  K:G
  AB|cdec BcdB|ABAF GFE2|cdec BcdB|c2A2 A2:|

$ Key changes within the tune may be accompanied by a clef change,
$ and a change of clef without a key change may be specified by
$ means of a K: field without key information, e.g.
$   K:tenor

To do this without generating a new line of music, put a \ at the
end of the first line, i.e.
  E2E EFE|E2E EFG|\
  M:9/8
  A2G F2E D2|]

$ Alternately, any field which can be legally used within the tune can also
$ be specified as an inline field, by placing it within square
$ brackets in a line of music, e.g.
$   E2E EFE|E2E EFG|[M:9/8] A2G F2E D2|]
$ The first bracket, field identifier and colon must be written
$ without intervening spaces.  Only one field may be placed within
$ a pair of brackets and where appropriate, inline fields
$ (especially clef changes) can be used in the middle of a beam
$ without breaking it.

$ A meter change within the body of the tune will not change the
$ unit note length (unlike one in the header where no L: field is
$ present).

  Ties and slurs
  ==============

You can tie two notes together either across or within a bar with
a  - symbol, e.g. abc-|cba or abc-cba.  More general slurs can be
put in with () symbols.  Thus (DEFG) puts a slur  over  the  four
notes.  Spaces within a slur are OK, e.g. (D E F G), but the open
bracket  should  come  immediately  before  a   note   (and   its
accents/accidentals,  etc.)  and  the  close  bracket should come
immediately after a note (and its octave marker or length).  Thus
(=b c'2) is OK but ( =b c'2 ) is not.

$ It should be noted that although the tie "-" and slur "()" produce
$ similar symbols in staff notation they have completely different
$ meanings to player programs and should not be interchanged.  Ties
$ connect two successive notes of the same pitch, causing them to
$ be played as a single note, while slurs connect the first and
$ last note of any series of notes, and may be used to indicate
$ phrasing, or that the group should be played legato.  Both ties
$ and slurs may be used into, out of and between chords, and in this
$ case the distinction between them is particularly important.

  Gracings
  ========

$ Grace notes can be written by enclosing them in curly braces, {}. For
$ example, a taorluath on the Highland pipes would be written {GdGe}. The
$ tune `Athol Brose' (in the file Strspys.abc) has an example of complex
$ Highland pipe gracing in all its glory. Although nominally grace notes
$ have no melodic time value, expressions such as {a2} and {a>b} can be
$ useful and are legal although some packages may ignore them.
$ The unit duration to use for gracenotes is not specified by the abc
$ file, but by the package, and might be a specific amount of time
$ (for playback purposes) or a note length (e.g. 1/32 for Highland pipe
$ music, which would allow {ge4d} to code a piobaireachd 'cadence').

$ The presence of gracenotes is transparent to the broken rhythm
$ construct. Thus the forms A<{g}A and A{g}<A are legal and equivalent to
$ A/2{g}A3/2 .


Alternatively, the tilde symbol ~ represents the general  gracing
of  a  note  which, in the context of traditional music, can mean
different things for different instruments, for example  a  roll,
cran or staccato triplet

$   Accents and other symbols
$   =========================

Staccato marks (a small dot above or below the note head) can  be
generated  by  a  dot before the note, i.e. a staccato triplet is
written as (3.a.b.c

For fiddlers, the letters u and v can be used  to  denote  up-bow
and down-bow, e.g. vAuBvA

$ Other common symbols are available such as
$ T    trill
$ H    fermata
$ L    accent or emphasis
$ M    lowermordent
$ P    uppermordent
$ S    segno
$ O    coda
$ However these symbols (.uvTHLMPSO and the roll ~) are just short cuts for
$ commonly used accents and can even be redefined (see Redefinable symbols).
$ More generally accents can be entered using the syntax !symbol!, e.g.
$   !trill!A4
$ for a trill symbol (tr). The currently defined symbols (and this list may
$ grow with time) are:
$ 
$ !trill!           "tr" (trill mark)
$ !lowermordent!    short /|/|/ squiggle with a vertical line through it
$ !uppermordent!    short /|/|/ squiggle
$ !mordent!         same as !lowermordent!
$ !pralltriller!    same as !uppermordent!
$ !accent!          > mark
$ !emphasis!        same as !accent!
$ !fermata!         fermata or hold (arc above dot)
$ !invertedfermata! upside down fermata
$ !tenuto!          horizontal line to indicate holding note for full duration
$ !0!-!5!           fingerings
$ !+!               left-hand pizzicato, or rasp for French horns
$ !wedge!           small filled-in wedge mark
$ !open!            small circle above note indicating open string or harmonic
$ !thumb!           cello thumb symbol
$ !snap!            snap-pizzicato mark, visually similar to !thumb!
$ !turn!            a ~ turn mark
$ !roll!            a roll mark (arc) as used in Irish music
$ !breath!          a breath mark (apostrophe-like) after note
$ !shortphrase!     vertical line on the upper part of the staff
$ !mediumphrase!    same, but extending down to the centre line
$ !longphrase!      same, but extending 3/4 of the way down
$ !segno!           2 ornate s-like symbols separated by a diagonal line
$ !coda!            a ring with a cross in it
$ !D.S.!            the letters D.S. (meaning da segno)
$ !D.C.!            the letters D.C. (meaning da coda)
$ !fine!            the word fine
$ !crescendo(!      start of a < crescendo mark
$ !crescendo)!      end of a < crescendo mark, placed after the last note
$ !diminuendo(!     start of a > diminuendo mark
$ !diminuendo)!     end of a > diminuendo mark, placed after the last note
$ !p! !pp! !f! !ff!
$ !mf! !ppp! !pppp! dynamics marks
$ !fff! !ffff! !sfz!
$ !repeatbar!       repeat previous whole bar, a % symbol
$ !repeatbar2!      repeat previous 2 whole bars, a % symbol with a 2 adjacent
$                   this can be extended to an arbitrary number of bars
$ !upbow!           V mark
$ !downbow!         squared n mark

$   Redefinable symbols
$   ===================
$ 
$ As a short cut to writing accents or other symbols which avoids the !symbol!
$ syntax (see Accent above), the letters H-Z and h-w and the symbol ~ can be
$ assigned with the U: and u: fields (the U: defines how the symbols are
$ printed and the u: defines how they are played). For example, to assign the
$ letter T to represent the trill, you can write:  
$   U: T = !trill!
$ 
$ You can also use "^text" etc (see Annotations 
$ below) in definitions, e.g.
$   U: X = "^+"
$ to print a plus sign over notes with X before them.
$ 
$ Symbol definitions can be written in the file header, in which
$ case they apply to all the tunes in that file, or in a tune header,
$ when they apply only to that tune, and override any previous definitions.
$ Programs may also make use of a set of global default definitions, which
$ apply everywhere unless overridden by local definitions.  You can assign
$ the same symbol to two or more letters e.g.
$   U: T = !trill!
$   U: U = !trill!
$ in which case the same visible symbol will be produced by both letters
$ (but they may be played differently), and you can de-assign a symbol by
$ writing:
$   U: T = !nil!
$ or
$   U: T = !none!
$ 
$ The standard set of definitions (if you do not redefine them) is:
$ U: ~ = !roll!
$ U: T = !trill!
$ U: H = !fermata!
$ U: L = !emphasis!
$ U: M = !lowermordent!
$ U: P = !uppermordent!
$ U: S = !segno!
$ U: O = !coda!
$ U: u = !upbow!
$ U: v = !downbow!

  Chords and unisons
  ==================

Chords (i.e. more than one note head on a  single  stem)  can  be
coded  with [] symbols around the notes, e.g. [CEGc] produces the
chord  of  C  major.  They  can  be  grouped   in   beams,   e.g.
[d2f2][ce][df] but there should be no spaces within a chord.  See
the tune `Kitchen Girl'  in  the  file  Reels.abc  for  a  simple
example.

If the chord contains two notes  both  of  the  same  length  and
pitch,  such  as [DD], then it is a unison (e.g. a note played on
two strings of a violin simultaneously) and is shown as note-head
with both upward and downward stems.

$  Accompaniment chords
$  ====================
$
$ Accompaniment chords (e.g. chords/bass notes) can be put in under the
$ melody line (or above, depending on the package) using double-quotation
$ marks placed to the left of the note it is sounded with, e.g. "Am7"A2D2.
$ 
$ The chord has the format <note><accidental><type>/<bass>, where <note>
$ can be A-G, the optional <accidental> can be b, #, the optional <type>
$ is one or more of
$   m or min        minor
$   maj             major
$   dim             diminished
$   aug or +        augmented
$   sus             sustained
$   7, 9 ...        7th, 9th, etc.
$ and /<bass> is an optional bass note.
$ 
$ A slash after the chord type is used only if the optional bass note is
$ also used, e.g., "C/E". If the bass note is a regular part of the
$ chord, it indicates the inversion, i.e., which note of the chord is
$ lowest in pitch. If the bass note is not a regular part of the chord,
$ it indicates an additional note that should be sounded with the chord,
$ below it in pitch. The bass note can be any letter (A-G or a-g), with
$ or without a trailing accidental sign (b or #). The case of the letter
$ used for the bass note does not affect the pitch.
$ 
$ Alternate chords can be indicated for printing purposes (but not for
$ playback) by enclosing them in parentheses inside the double-quotation
$ marks after the regular chord, e.g., "G(Em)".

$   Annotations
$   ===========
$ 
$ General text annotations can be added above, below or on the staff
$ in a similar way to accompaniment. In this case, the string within
$ double quotes is preceded by one of five symbols ^, _, <, >or @ which
$ controls where the annotation is to be placed; above, below, to the
$ left or right respectively of the following note, rest or bar line.
$ Using the @ symbol leaves the exact placing of the string to the
$ discretion of the interpreting program. Where two or more such
$ annotations are placed consecutively, e.g. for fingerings, the notation
$ program should draw them on separate lines, with the first listed at the top.
$ These symbols also distinguish annotations from guitar chords, and
$ should prevent programs from attempting to play or transpose them.

  Order of symbols
  ================

The order of symbols for one note is <guitar  chords>,  <accents>
(e.g. roll, staccato marker or up/downbow), <accidental>, <note>,
<octave>, <note length>, i.e. ~^c'3 or even "Gm7"v.=G,2

Tie symbols, -, should come immediately after a  note  group  but
may  be  followed  by  a space, i.e. =G,2- . Open and close chord
symbols, [], should enclose entire  note  sequences  (except  for
guitar  chords),  i.e.  "C"[CEGc]  or "Gm7"[.=G,^c'] and open and
close   slur   symbols,   (),   should    do    likewise,    i.e.
"Gm7"(v.=G,2~^c'2)

$ Metrical beats for setting tempo
$ ================================

$ The standard form of the Q field is, for example, Q:1/2=120 which means
$ 120 half-note beats per minute, however, if a beat unit is given without
$ a speed (e.g. Q:3/8), then the speed is usually intended to be set in
$ a playback program and this field will then be ignored by typesetting
$ programs.

$ The beat unit can also be given as a multiple of the unit note length using the
$ letter L, e.g. if L:1/8, then Q:L3=120 is equivalent to Q:3/8=120. However,
$ it is usually better to specify an absolute note length. (Note that giving
$ a tempo in relative to the unit note length may result in unexpected
$ behaviour if the unit note length is changed, either explicitly or by
$ default mechanisms.) Older versions of the abc standard used the letter C
$ instead of L, and this is still a permitted form although not recommended.

$ If no beat unit is set in the Q: field or if the Q: field is missing, a
$ default beat unit is assumed. The default beat unit is the demoninator of
$ the meter, except for compound meters (6/8, 9/8 and higher multiples of
$ 3/8), for which the default beat unit is 3/8. For example, if M:2/4, the
$ default beat unit is 1/4. For M:C| (=M:2/2) it is 1/2; for M:12/8 it is
$ 3/8.

$ When giving a tempo, it is preferable to specify a beat unit rather than to
$ rely on default mechanisms.

  Comments
  ========

A % symbol will cause the remainder  of  any  input  line  to  be
ignored. The file English.abc contains plenty of examples.

  Line breaking and justification
  ===============================

Generally one line of abc  notation  will  produce  one  line  of
music,  although  if  the music is too long it will overflow onto
the next line. This can look very  effective,  but  it  can  also
completely  ruin  ties  across  bar  lines,  for example. You can
$ counteract this by changing either the note spacing (using some 
$ package specific command) or break the
line of abc notation. If, however, you wish to use two  lines  of
input  to  generate  one  line  of  music  (see, for example, the
`Untitled Reel' in Reels.abc) then simply put a \ at the  end  of
the first line.  This is also useful for changing meter or key in
the middle of a line of music.

./doc/abc_v2.0.txt	[[[1
1984
\\

====== The ABC Music standard 2.0 (December 2010) ======

\\

** Contents **
  * [[#introduction|1. Introduction]]
    * [[#document_locations|1.1. Document locations]]
  * [[#file_structure|2. File structure]]
    * [[#remarks|2.1. Remarks]]
    * [[#continuation_of_input_lines|2.2. Continuation of input lines]]
    * [[#line_breaking|2.3. Line breaking]]
  * [[#information_fields|3. Information fields]]
    * [[#description|3.1. Description]]
      * [[#xreference number|3.1.1. X: - reference number]]
      * [[#ttune title|3.1.2. T: - tune title]]
      * [[#ccomposer|3.1.3. C: - composer]]
      * [[#oorigin|3.1.4. O: - origin]]
      * [[#aauthor of lyrics|3.1.5. A: - author of lyrics]]
      * [[#mmeter|3.1.6. M: - meter]]
      * [[#lunit note length|3.1.7. L: - unit note length]]
      * [[#qtempo|3.1.8. Q: - tempo]]
      * [[#pparts|3.1.9. P: - parts]]
      * [[#ztranscriber|3.1.10. Z: - transcriber]]
      * [[#nnotes|3.1.11. N: - notes]]
      * [[#ggroup|3.1.12. G: - group]]
      * [[#hhistory|3.1.13. H: - history]]
      * [[#kkey|3.1.14. K: - key]]
      * [[#other_fields|3.1.15. Other fields]]
    * [[#use_of_fields_within_body|3.2. Use of fields within body]]
    * [[#extended_information_fields|3.3. Extended information fields]]
      * [[#copyright_field|3.3.1. Copyright field]]
      * [[#version_field|3.3.2. Version field]]
      * [[#creator_field|3.3.3. Creator field]]
      * [[#charset_field|3.3.4. Charset field]]
      * [[#include_field|3.3.5. Include field]]
      * [[#edited_by_field|3.3.6. Edited-by field]]
  * [[#the_tune_body|4. The tune body]]
    * [[#pitch|4.1. Pitch]]
    * [[#accidentals|4.2. Accidentals]]
    * [[#note_lengths|4.3. Note lengths]]
    * [[#broken_rhythm|4.4. Broken rhythm]]
    * [[#rests|4.5. Rests]]
    * [[#spacer|4.6. Spacer]]
    * [[#beams|4.7. Beams]]
    * [[#repeat_bar_symbols|4.8. Repeat/bar symbols]]
    * [[#first_and_second_repeats|4.9. First and second repeats]]
    * [[#variant_endings|4.10. Variant endings]]
    * [[#ties_and_slurs|4.11. Ties and slurs]]
    * [[#grace_notes|4.12. Grace notes]]
    * [[#duplets_triplets_quadruplets_etc|4.13. Duplets, triplets, quadruplets, etc.]]
    * [[#decorations|4.14. Decorations]]
    * [[#symbol_lines|4.15. Symbol lines]]
    * [[#redefinable_symbols|4.16. Redefinable symbols]]
    * [[#chords_and_unisons|4.17. Chords and unisons]]
    * [[#chord_symbols|4.18. Chord symbols]]
    * [[#annotations|4.19. Annotations]]
    * [[#order_of_abc_constructs|4.20. Order of ABC constructs]]
  * [[#lyrics|5. Lyrics]]
  * [[#clefs|6. Clefs]]
  * [[#multiple_voices|7. Multiple voices]]
    * [[#voice_properties|7.1. Voice properties]]
    * [[#breaking_lines|7.2. Breaking lines]]
    * [[#inline_fields|7.3. Inline fields]]
    * [[#voice_overlay|7.4. Voice overlay]]
  * [[#abc_data_format|8. ABC data format]]
    * [[#tune_body|8.1. Tune body]]
    * [[#abc_string|8.2. ABC string]]
  * [[#macros|9. Macros]]
    * [[#static_macros|9.1. Static macros]]
    * [[#transposing_macros|9.2. Transposing macros]]
  * [[#deprecated_abc_syntax|10. Deprecated ABC syntax]]
    * [[#deprecated_fields|10.1. Deprecated fields]]
    * [[#deprecated_decorations|10.2. Deprecated decorations]]
    * [[#deprecated_continuations|10.3. Deprecated continuations]]
  * [[#abc_stylesheet_specification|11. ABC stylesheet specification]]
    * [[#voice_grouping|11.1. Voice grouping]]
    * [[#instrumentation_directives|11.2. Instrumentation directives]]
    * [[#accidental_directives|11.3. Accidental directives]]
    * [[#formatting_directives|11.4. Formatting directives]]
      * [[#page_format|11.4.1. Page format]]
      * [[#font_settings|11.4.2. Font settings]]
      * [[#spaces|11.4.3. Spaces]]
      * [[#measures|11.4.4. Measures]]
      * [[#text|11.4.5. Text]]
      * [[#misc|11.4.6. Misc]]
    * [[#application_specific_directives|11.5. Application specific directives]]
  * [[#portability_issues|12. Portability issues]]
  * [[#sample_abc_tunes|13. Sample ABC tunes]]
    * [[#englishabc|13.1. English.abc]]
    * [[#strspysabc|13.2. Strspys.abc]]
    * [[#reelsabc|13.3. Reels.abc]]
    * [[#canzonettaabc|13.4. Canzonetta.abc]]
  * [[#appendix|14. Appendix]]
    * [[#general_midi_instruments|14.1. General MIDI instruments]]
    * [[#full_table_of_accented_letters|14.2. Full table of accented letters]]
    * [[#undocumented_features|14.3. Undocumented features]]

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 1. Introduction =====

ABC is a music notation system designed to be comprehensible by both people and computers. Music notated in ABC is written using characters; on paper, or in computer files.

This description of ABC has been created for those who wish to understand the notation, and for implementers of new ABC applications. It mentions some example tunes that are included at the bottom of this document.

The ABC standard itself deals only with structured, high-level information; how this information should be actually rendered by e.g. a typesetter or a player program, is dealt with in a separate standard, i.e. the [[#abc_stylesheet_specification|ABC stylesheet specification]], included at the bottom of this document.

This document is best read in conjunction with an introduction to the ABC notation. Several are available:

  * http://abcnotation.com/learn
  * http://abcplus.sourceforge.net/#ABCGuide
  * http://www.lesession.co.uk/abc/abc_notation.htm
  * http://trillian.mit.edu/~jc/music/abc/doc/ABCtutorial.html

Since the ABC notation system was originally written, a large number of ABC packages (programs which produce printed sheet music or allow for computer performances, search in tune databases, or that analyze tunes in some way) have been developed and/or extended in their functionality. However, not all of them follow this standard absolutely. This document aims at solving, or at least reducing, the problem of incompatibility between applications.

Still, when using ABC it is good to be aware of the existence of such extensions. The extensions that were implemented by the major ABC packages have been described here:

  * http://abc.sourceforge.net/standard/abc2midi.txt
  * http://www.barfly.dial.pipex.com/bfextensions.html
  * http://abc.sourceforge.net/standard/abcm2ps.txt
  * http://www.lautengesellschaft.de/cdmm/userguide/userguide.html

Questions about this standard or ABC in general can be addressed to the abcusers e-mail list:

  * http://groups.yahoo.com/group/abcusers/ (subscriptions and archive of posts)
  * http://www.mail-archive.com/abcusers@argyll.wisemagic.com (archive of old posts)

==== 1.1. Document locations ====

This document is a reformatted and minimally modified version of the ABC 2.0 draft standard by Irwin Oppenheim (14 Aug 2003), itself a significant enhancement of the previous 1.7.6 draft standard by Chris Walshaw and John Atchley (8 May 2000). The first revision of this document was kindly prepared by Guido Gonzato. The current document also contains parts of texts written by Jean-François Moine, Phil Taylor and James Allwright as well as contributions by John Chambers, Jack Campin, Arent Storm and Jaysen Ollerenshaw.

This document can be found at:

  * http://abcnotation.com/wiki/abc:standard:v2.0

Earlier versions of the standard can be found at:

  * http://abc.sourceforge.net/standard/abc2-draft.html - abc draft standard v2.0 (near-final draft of this version)
  * http://abcnotation.com/standard/abc_v1.7.6-draft.txt - abc draft standard v1.7.6
  * http://abcnotation.com/standard/abc_v1.6.txt - abc standard v1.6 (the previous 'official' standard)

Henrik Norbeck has provided formal specifications of the standard in Backus-Naur Format available at:

  * http://www.norbeck.nu/abc/bnf/abc20bnf.htm - abc draft standard v2.0
  * http://www.norbeck.nu/abc/abcbnf.htm - abc standard v1.6

The latest version of the standard can be found via:

  * http://abcnotation.com/wiki/abc:standard

Other developmental work can be found at:

  * http://abcplus.sourceforge.net/ - AbcPlus, an enhanced version of abc based on developments implemented in abcm2ps and abcMIDI
  * http://abc.sourceforge.net/standard/

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 2. File structure =====

An ABC file consists of one or more tune transcriptions. The tunes are separated from each other by blank lines. An ABC file with more than one tune in it, is called an ABC tunebook.

The tune itself consists of a //header// and a //body//. The header is composed of several //field// lines, which are further discussed in the section [[#Information fields|Information fields]]. The header should start with an ''X'' (reference number) field followed by a ''T'' (title) field and finish with a ''K'' (key) field. The body of the tune, which contains the actual music in ABC notation, should follow immediately after. As will be explained, certain fields may also be used inside this tune body. If the file contains only one tune the ''X'' field may be dropped. It is legal to write a tune without a body. This feature can be used to document tunes without transcribing them.

The file may optionally start with a file header, which is a block of consecutive field lines, finished by a blank line. The file header may be used to set default values for the tunes in the file. Such a file header may only appear at the beginning of a file, not between tunes. Of course, tunes may override the file header settings. However, when the end of a tune is reached, the defaults set by the file header are restored. Applications which extract separate tunes from a file, must insert the fields of the original file header, into the header of the extracted tune. However, since users may manually extract tunes, without taking care of the file header, it is advisable not to use file headers in tunebooks that are to be distributed.

It is legal to write free text before or between the tunes of a tunebook. The free text should be separated from the surrounding tunes by blank lines. Programs that are able to print tunebooks, may print the free text sections. The free text is treated as an [[#abc_string|ABC string]]. The free text may be interspersed with directives (see section [[#abc_stylesheet_specification|ABC stylesheet specification]]) or with [[#extended_information_fields|Extended information fields]]; however, the scope of these settings is limited to the text that appears up to the beginning of the next tune. At that point, the defaults set by the file header are restored.

==== 2.1. Remarks ====

A percent symbol (''%'') will cause the remainder of any input line to be ignored. It can be used to add remarks to the end of an ABC line.

Alternatively, you can use the syntax ''[r: remarks]'' to write remarks in the middle of a line of music.

==== 2.2. Continuation of input lines ====

If the last character on a line is a backslash (\), the next line should be appended to the current one, deleting the backslash and the newline, to make one long logical line. There may appear spaces or an end-of-line remark after the backslash: these will be deleted as well. If the user would like to have a space between the two half lines, he should either type one before the backslash, or at the beginning of the next half line.

Example:

  gf|e2dc B2A2|B2G2 E2D2|.G2.G2 \  % continuation
  GABc|d4 B2
  w: Sa-ys my au-l' wan to your aul' wan\
     Will~ye come to the Wa-x-ies dar-gle?

There is no limit to the number of lines that may be appended together.

==== 2.3. Line breaking ====

Traditionally, one line of ABC notation corresponded closely to one line of printed music.

It is desirable, however, that ABC applications provide the user with an option to automatically reformat the line breaking, so that the layout of the printed sheet music will look optimal.

To force a line break at all times, an exclamation mark (''!'') can be used. The ''!'' can be inserted everywhere, where a note group could.

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 3. Information fields =====

The information fields are used to notate things such as composer, meter, etc, in fact anything that isn't music.

Any line beginning with a letter in the range 'A-Z' or 'a-z' and immediately followed by a colon ('':'') is to be interpreted as a field. Many of these field identifiers are currently unused, so programs that comply with this standard should ignore the occurrence of information fields not defined here. This will make it possible to extend the number of information fields in the future. Some fields are permitted only in the file or tune header and some only in the body, while others are allowed in both locations. Field identifiers 'A-G' and 'a-g' will not be permitted in the body to avoid confusion with note symbols.

Note that if you are intending to use the notation solely for transcribing (rather than documenting) tunes, you can ignore most of of the information fields as all you really need are the ''X'' (reference number), ''T'' (title), ''M'' (meter), ''L'' (unit note length) and ''K'' (key) fields. If applicable you could add a ''C'' (composer), an ''A'' (author of lyrics) and a ''w'' (words) field. I have included a full list of fields however, for those who wish to understand tunes transcribed by other users.

By far the best way to find out how to use the fields is to look at the example files in section [[#sample_abc_tunes|Sample ABC tunes]] (in particular [[#englishabc|English.abc]]) and try out some examples. Thus rather than describing them in detail, they are summarised in the following table.

The table illustrates how the fields may be used in the tune header and whether they may also be used in the tune body (see section [[#use_of_fields_within_body|Use of fields within body]] for details) or in the file header (see section [[#file_structure|File structure]]).

ABC Fields and their usage
^ **Field name** ^ **header** ^ **body** ^ **file** ^ **type** ^ **Examples and notes** ^
| A:author of lyrics | yes |  | yes | S | A:Walter Raleigh |
| B:book | yes |  | yes | S | B:O'Neills |
| C:composer | yes |  | yes | S | C:Robert Jones, C:Trad. |
| D:discography | yes |  | yes | S | D:Chieftains IV |
| F:file url | yes |  | yes | S | <nowiki>F:http://a.b.c/file.abc</nowiki> |
| G:group | yes |  | yes | S | G:flute |
| H:history | yes |  | yes | S | H:This tune said to... |
| I:instruction | yes | yes | yes | I | I:papersize A4, I:newpage |
| K:key | last | yes |  | I | K:G, K:Dm, K:AMix |
| L:unit note length | yes | yes |  | I | L:1/4, L:1/8 |
| M:meter | yes | yes | yes | I | M:3/4, M:4/4 |
| m:macro | yes | yes | yes | I | m: ~n2 = (3o/n/m/ n |
| N:notes (annotation) | yes | yes | yes | S | N:see also O'Neills - 234 |
| O:origin | yes |  | yes | S | O:UK, Yorkshire, Bradford |
| P:parts | yes | yes |  | I | P:A, P:ABAC, P:(A2B)3 |
| Q:tempo | yes | yes |  | I | Q:"allegro" 1/4=120 |
| R:rhythm | yes | yes | yes | S | R:R, R:reel |
| r:remark | yes | yes | yes | - | r:I love ABC |
| S:source | yes |  | yes | S | S:collected in Brittany |
| s:symbol line |  | yes |  | I | s: +pp+ <nowiki>**</nowiki> +f+ |
| T:title | second | yes | yes | S | T:Paddy O'Rafferty |
| U:user defined | yes | yes | yes | I | U: T = +trill+ |
| V:voice | yes | yes |  | I | V:4 clef=bass |
| W:words | yes | yes |  | S | lyrics after tune |
| w:words |  | yes |  | S | lyrics aligned with tune |
| X:reference number | first |  |  | I | X:1, X:2 |
| Z:transcriber | yes |  | yes | S | Z:John Smith, <nowiki><j.s@mail.com></nowiki> |

Fields of type 'S' accept free text in the form of an [[#abc_string|ABC string]] as argument. Fields of type 'I' expect a special instruction syntax which will be detailed below. The contents of the remark field will be totally ignored.

The following table indicates whether the field contents should be appended or replaced, if a certain field occurs multiple times in the same tune. Some fields have a special rule.

  A:   append                    Q:   replace
  B:   append                    R:   append (if in header)
  C:   append                    R:   replace (in body)
  D:   append                    S:   append
  F:   replace                   s:   append
  G:   append                    T:   append  (if in header)
  H:   append                    T:   begin new section (in body)
  K:   replace                   U:   replace
  L:   replace                   V:ID replace (if in header)
  M:   replace                   V:ID switch to indicated voice (in body)
  m:   replace                   W:   append
  N:   append                    w:   append
  O:   append                    X:   only once per tune
  P:   replace (if in header)    Z:   append
  P:ID only once (in body)

==== 3.1. Description ====

=== 3.1.1. X: - reference number ===

The ''X'' field is used to assign to each tune within a tunebook an unique reference number (which should be a positive integer), for example: ''X:23''. All tune headers should start with a ''X'' field, which may be omitted solely if there is only one tune in the file. In that case, the tune is implicitly assigned the number one. There may be only one ''X'' field per tune.

=== 3.1.2. T: - tune title ===

Some tunes have more than one title and so this field can be used more than once per tune - the first time will generate the title whilst subsequent usage will generate the alternatives in small print. The ''T:'' field can also be used within a tune to name parts of a tune - in this case it should come before any key or meter changes.

By default, the title(s) will be printed centered above the tune, each title on a separate line. Note that is only indicative, users may change the formatting by providing stylesheet directives or setting options in the software they use.

The ''T'' field may be empty, in which case nothing is printed.

=== 3.1.3. C: - composer ===

By default, the composer(s) will be printed right aligned, just below the title, each composer on a separate line.

=== 3.1.4. O: - origin ===

The geographical origin(s) of a tune.

If possible, enter the data in a hierarchical way, like:

  O:Canada, Nova Scotia, Halifax.
  O:England, Yorkshire, Bradford and Bingley.

Always use '','' as separator, so that software may parse the field.

This field may especially be used for 'traditional' tunes, with no known composer.

By default, the contents of the ''O'' field will be appended to the ''C'' field, surrounded by parentheses.

=== 3.1.5. A: - author of lyrics ===

By default, the lyricist(s) will be printed left aligned, just below the title, each lyricist on a separate line.

=== 3.1.6. M: - meter ===

Apart from the normal meters, e.g. ''M:6/8'' or ''M:4/4'', the symbols ''M:C'' and ''M:C|'' give common time (4/4) and cut time (2/2) respectively. The symbol ''M:none'' omits the meter entirely (free meter).

It is also possible to specify a complex meter, e.g. ''M:(2+3+2)/8'', to make explicit which beats should be accented. The parentheses around the numerator are optional.

The example given will be typeset as:

  2 + 3 + 2
      8

When there is no ''M:'' field defined, free meter is assumed.

Note that in free meter, bar lines can be placed anywhere you want.

=== 3.1.7. L: - unit note length ===

Specifies the unit note length, i.e. ''L:1/4'' - quarter note, ''L:1/8'' - eighth note, ''L:1/16'' - sixteenth, ''L:1/32'' - thirty-second.

If there is no ''L:'' field defined, a unit note length is set by default, based on the meter field ''M:''. This default is calculated by computing the meter as a decimal: if it is less than 0.75 the default unit note length is a sixteenth note; if it is 0.75 or greater, it is an eighth note. For example, 2/4 = 0.5, so, the default unit note length is a sixteenth note, while for 4/4 = 1.0, or 6/8 = 0.75, or 3/4= 0.75, it is an eighth note. For ''M:C'' (4/4), ''M:C|'' (2/2) and ''M:none'' (free meter), the default unit note length is 1/8.

A meter change within the body of the tune will not change the unit note length (unlike one in the header if no ''L:'' field is present).

=== 3.1.8. Q: - tempo ===

Defines the tempo in terms of a number of beats per minute, e.g. ''Q:1/2=120'' means 120 half-note beats per minute.

There may be up to 4 beats in the definition, e.g:

  Q:1/4 3/8 1/4 3/8=40

This means: play the tune as if ''Q:5/4=40'' was written, but print the tempo indication using separate notes as specified by the user.

The tempo definition may be preceded or followed by an optional [[#abc_string|ABC string]], enclosed by quotes, e.g.

  Q: "Allegro" 1/4=120
  Q: 3/8=50 "Slowly"

It is OK to give a string without an explicit tempo indication, e.g. ''Q:"Andante"''.

Older versions of this standard permitted two further formats:

  Q: C=120

This is no longer part of the standard and should not be used.

and:

  Q:120

Meaning: play 120 unit note-lengths per minute. This is not very musical, and its use is to be discouraged, however there are many abc files which employ this format and programs should be prepared to accept it.

=== 3.1.9. P: - parts ===

Can be used in the header to state the order in which the tune parts are played, i.e. ''P:ABABCDCD'', and then inside the tune to mark each part, i.e. ''P:A'' or ''P:B''.

Within the header, a part can be repeated by following it with a number: e.g. ''P:A3'' is equivalent to ''P:AAA''. A sequence can be repeated by using parentheses: e.g. ''P:(AB)3'' is equivalent to ''P:ABABAB''. Nested parentheses are permitted; dots may be placed anywhere within the header ''P:'' field to increase legibility: e.g. ''<nowiki>P:((AB)3.(CD)3)2</nowiki>''. These dots are ignored by computer programs.

Please see section [[#variant_endings|Variant endings]] and section [[#lyrics|Lyrics]] for possible uses of part notation.

=== 3.1.10. Z: transcriber ===

The name(s) of the person(s) who transcribed the tune in ABC, and possibly some contact information, like an (e-)mail address or homepage url.

All ''Z'' fields that appear within the header are appended and by default should be printed just below the tune.

=== 3.1.11. N: - notes ===

Contains general annotations, such as references to other tunes which are similar, details on how the original notation of the tune was converted to ABC, etc.

All ''N'' fields that appear within the tune are appended and by default should be printed left aligned below the name(s) of the transcriber(s).

=== 3.1.12. G: - group ===

Database software may use this field to group together tunes (for example by instruments) for indexing purposes. Other software may safely ignore this field.

=== 3.1.13. H: - history ===

Can be used for multi-line stories/anecdotes, all of which will be ignored until the next field occurs.

=== 3.1.14. K: - key ===

The key signature should be specified with a capital letter (''A-G'') which may be followed by a ''#'' or ''b'' for sharp or flat respectively. In addition the mode should be specified. For example, ''K:C major'', ''K:A minor'', ''K:C ionian'', ''K:A aeolian'', ''K:G mixolydian'', ''K:D dorian'', ''K:E phrygian'', ''K:F lydian'' and ''K:B locrian'' would all produce a staff with no sharps or flats. The spaces can be left out, capitalisation is ignored for the modes and in fact only the first three letters of each mode are parsed so that, for example, ''K:F# mixolydian'' is the same as ''K:F#Mix'' or even ''K:F#MIX''. As a special case, ''minor'' may be abbreviated to ''m''. When no mode is indicated, ''major'' is assumed.

This table sums up key signatures written in different ways:

  Key Sig     Major   Minor    Mix     Dor     Phr     Lyd     Loc
              Ion     Aeo
  
  7 sharps:   C#      A#m      G#Mix   D#Dor   E#Phr   F#Lyd   B#Loc
  6 sharps:   F#      D#m      C#Mix   G#Dor   A#Phr   BLyd    E#Loc
  5 sharps:   B       G#m      F#Mix   C#Dor   D#Phr   ELyd    A#Loc
  4 sharps:   E       C#m      BMix    F#Dor   G#Phr   ALyd    D#Loc
  3 sharps:   A       F#m      EMix    BDor    C#Phr   DLyd    G#Loc
  2 sharps:   D       Bm       AMix    EDor    F#Phr   GLyd    C#Loc
  1 sharp :   G       Em       DMix    ADor    BPhr    CLyd    F#Loc
  0 sharps:   C       Am       GMix    DDor    EPhr    FLyd    BLoc
  1 flat  :   F       Dm       CMix    GDor    APhr    BbLyd   ELoc
  2 flats :   Bb      Gm       FMix    CDor    DPhr    EbLyd   ALoc
  3 flats :   Eb      Cm       BbMix   FDor    GPhr    AbLyd   DLoc
  4 flats :   Ab      Fm       EbMix   BbDor   CPhr    DbLyd   GLoc
  5 flats :   Db      Bbm      AbMix   EbDor   FPhr    GbLyd   CLoc
  6 flats :   Gb      Ebm      DbMix   AbDor   BbPhr   CbLyd   FLoc
  7 flats :   Cb      Abm      GbMix   DbDor   EbPhr   FbLyd   BbLoc

By specifying ''K:none'', it is possible to use no key signature at all.

The key signatures may be **modified** by adding [[#accidentals|accidentals]], according to the format ''K:<tonic> <mode> <accidentals>''. For example, ''K:D Phr ^f'' would give a key signature with two flats and one sharp, which designates a very common mode in e.g. Klezmer (Ahavoh Rabboh) and in Arabic music (Maqam Hedjaz). Likewise, ''K:D maj =c'' or ''K:D =c'' will give a key signature with f sharp and c natural. Note that there can be several modifying accidentals, separated by spaces, each beginning with an accidental sign (''<nowiki>__</nowiki>'', ''_'', ''='', ''^'' or ''<nowiki>^^</nowiki>''), followed by a letter in lower case.

It is possible to use the format ''K:<tonic> exp <accidentals>'' to explicitly define all the accidentals of a key signature. Thus ''K:D Phr ^f'' could also be notated as ''K:D exp _b _e ^f'', where 'exp' is an abbreviation of 'explicit'. Again, the note names of the accidentals should be in lower case.

//Software that does not support explicit key signatures, should mark the individual notes in the tune with the accidentals that apply to them.//

The Scottish highland pipes are highly diatonic, and have the scale ''G A B ^c d e ^f g a''. These are the only notes they play with any accuracy. The highland pipe music thus uses the modes D major and A mixolyian primarily (and also B minor and E dorian).

Therefore there are two additional keys specifically for notating highland bagpipe tunes; ''K:HP'' doesn't put a key signature on the music, as is common with many tune books of this music, while ''K:Hp'' marks the stave with F sharp, C sharp and G natural. Both force all the beams and stems of normal notes to go downwards, and of grace notes to go upwards.

By default, the ABC tune will be typeset with a treble clef. You can add special clef specifiers to the ''K:'' field, with or without a key signature, to change the clef and various other staff properties. ''K: clef=bass'', for example, would indicate the bass clef. See section [[#clefs|Clefs]] for full details.

Note that the first occurence of the ''K'' field, which must appear in every tune, finishes the tune header. All following lines are considered to be part of the tune body.

=== 3.1.15. Other fields ===

  * For ''w:'' see the section [[#lyrics|Lyrics]].
  * For ''s:'' see the section [[#symbol_lines|Symbol lines]].
  * For ''U:'' see the section [[#redefinable_symbols|Redefinable symbols]]. 
  * For ''V:'' see the section [[#multiple_voices|Multiple voices]].
  * For ''r:'' see the section [[#remarks|remarks]].
  * For ''I:'' see the section [[#abc_stylesheet_specification|ABC stylesheet specification]].
  & For ''m:'' see the section [[#macros|macros]].

==== 3.2. Use of fields within body ====

It is often desired to change the key ''K'', meter ''M'', or unit note length ''L'' mid-tune. These fields and any other fields which can be legally used within the tune, can be specified as an inline field, by placing them within square brackets in a line of music, e.g.

  E2E EFE|E2E EFG|[M:9/8] A2G F2E D2|]

The first bracket, field identifier and colon must be written without intervening spaces. Only one field may be placed within a pair of brackets, however, multiple, bracketed fields may be placed next to each other. Where appropriate, inline fields (especially clef changes) can be used in the middle of a beam without breaking it.

See section [[#information_fields|Information fields]] for a list of fields that may appear within the body.

For backward compatibility, it is still allowed to notate tune fields on a line by themselves, between the music lines:

  ed|cecA B2ed|cAcA E2ed|cecA B2ed|c2A2 A2:|
  M:2/2
  K:G
  AB|cdec BcdB|ABAF GFE2|cdec BcdB|c2A2 A2:|

However, the inline format is preferred.

==== 3.3. Extended information fields ====

The number of possible ABC information fields is somewhat limited. Furthermore, the one character names of these fields are rather cryptic. To cope with this, the ABC 2.0 standard introduces a new set of information fields, conforming to a new syntax.

These new fields should appear on a line by themselves. They //start// with the characters ''<nowiki>%%</nowiki>'', possibly followed by spaces, after which the name of the field follows, followed by a space and the contents of the field.

The fields that are defined in this section, may either appear in the file header, in the tune header or in the free text area between tunes, but not in the tune body. Remember: applications which extract separate tunes from a file, must insert the fields of the original file header, into the header of the extracted tune. This is also true for the fields defined in this section.

=== 3.3.1. Copyright field ===

Example:

  %%abc-copyright (C) Copyright John Smith 2003

There may appear multiple copyright fields in the file header and the tune header, that all are appended. The contents of the copyright fields is treated as an [[#abc_string|ABC string]]. Among other things this means that ''(C)'' will be printed as the international copyright symbol.

The contents of the copyright field is finally appended to the contents of the ''Z'' field, which by default is printed just below the tune.

=== 3.3.2. Version field ===

Example:

  %%abc-version 2.0

Software that exports ABC tunes conforming to this standard, should include a version field.

Later occurrences of the version field, override earlier ones.

=== 3.3.3. Creator field ===

Example:

  %%abc-creator xml2abc 2.7

The creator field contains the name of the program that created the ABC file, followed by the version number of the program.

Software that exports ABC tunes conforming to this standard, should include a creator field.

Later occurrences of the creator field, override earlier ones.

=== 3.3.4. Charset field ===

Example:

  %%abc-charset iso-8859-1

This field documents in which character set ABC strings are coded. When no charset is specified, iso-8859-1 (a.k.a. Latin-1) is assumed. This is convenient, since it is also the default charset used in webpages.

Legal values for the charset field are:

  iso-8859-1, iso-8859-2, iso-8859-3, iso-8859-4,
  iso-8859-5, iso-8859-6, iso-8859-7, iso-8859-8,
  iso-8859-9, iso-8859-10, us-ascii, utf-8.

Software that exports ABC tunes conforming to this standard, should include a charset field if an encoding other than iso-8859-1 is used.

Note that software that exports ABC, should convert all accented characters that could be coded with non-numeric backscape sequences, to the notation discussed in section [[#abc_string|ABC string]]. This is to ensure maximum portability. Programs that cannot display the accented letters, can then simply reduce them to the base letter, as is discussed in that section.

All ABC software must be able to handle ABC strings coded in iso-8859-1 and us-ascii. Support for the other charsets is optional. Extensive information about these charsets, can be found here:

  * http://czyborra.com/charsets/iso8859.html

It is possible to use different charsets in one file: later occurrences of the charset field, override earlier ones.

=== 3.3.5. Include field ===

Example:

  %%abc-include mydefs.abh

Imports the definitions found in a separate ABC Header file (ABH), and inserts them into the file header or tune header.

The file may contain both regular ABC field lines, extended information field lines, stylesheet directives (see section [[#abc_stylesheet_specification|ABC stylesheet specification]]) and remark lines, but no other ABC constructs.

=== 3.3.6. Edited-by field ===

Example:

  %%abc-edited-by John Smith, www.johnsmith.com

Name and contact information of the person/organization who edited an ABC tunebook, ABC Header file or ABC tune. This may or may not be the same person who originally transcribed the individual tunes in ABC notation.

Multiple occurrences of the field are appended. The contents of the field is treated as an [[#abc_string|ABC string]].

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 4. The tune body =====

==== 4.1. Pitch ====

The following letters are used to represent notes using the treble clef:

                                                        d'
                                                  -c'- ----
                                               b
                                          -a- --- ---- ----
                                         g
   ------------------------------------f-------------------
                                     e
   --------------------------------d-----------------------
                                 c
   ----------------------------B---------------------------
                             A
   ------------------------G-------------------------------
                         F
   --------------------E-----------------------------------
                     D
   ---- ---- ---- -C-
              B,
   ---- -A,-
    G,

and by extension, the notes ''C,'' ''D,'' ''E,'' ''F,'' ''<nowiki>e'</nowiki>'' ''<nowiki>f'</nowiki>'' ''<nowiki>g'</nowiki>'' ''<nowiki>a'</nowiki>'' and ''<nowiki>b'</nowiki>'' are available. Notes can be modified in length (see [[#note_lengths|Note lengths]]). Lower octaves are reached by using 2 commas, 3 commas and so on. Higher octaves are written using 2 apostrophes, 3 apostrophes and so on.

Programs should be able to to parse any combinations of '','' and ''<nowiki>'</nowiki>'' signs appearing after the note. For example ''C,','' should have the the same meaning as ''C,'' while (uppercase) ''<nowiki>C'</nowiki>'' should have the same meaning as (lowercase) ''c''.

NB. The English note names ''C''-''B'', which are used in the ABC system, correspond to the note names ''do''-''si'', which are used in many other languages: ''do''=''C'', ''re''=''D'', ''mi''=''E'', ''fa''=''F'', ''sol''=''G'', ''la''=''A'', ''si''=''B''.

==== 4.2. Accidentals ====

The symbols ''^'', ''='' and ''_'' are used (before a note) to notate respectively a sharp, natural or flat. Double sharps and flats are available with ''<nowiki>^^</nowiki>'' and ''<nowiki>__</nowiki>'' respectively.

==== 4.3. Note lengths ====

//Throughout this document note lengths are referred as sixteenth, eighth, etc. The equivalents common in the U.K. are sixteenth note = semi-quaver, eighth = quaver, quarter = crotchet and half = minim.//

The unit note length for the transcription is set in the ''L:'' field, e.g. ''L:1/8'' sets an eighth note as the unit note length. A single letter in the range ''A-G'', ''a-g'' represents a note of this length. For example, if the unit note length is an eighth note, ''DEF'' represents 3 eighth notes.

Notes of differing lengths can be obtained by simply putting a multiplier after the letter. Thus if the unit note length is 1/16, ''A'' or ''A1'' is a sixteenth note, ''A2'' an eighth note, ''A3'' a dotted eighth note, ''A4'' a quarter note, ''A6'' a dotted quarter note, ''A7'' a double dotted quarter note, ''A8'' a half note, ''A12'' a dotted half note, ''A14'' a double dotted half note, ''A15'' a triple dotted half note and so on. If the unit note length is ''1/8'', ''A'' is an eighth note, ''A2'' a quarter note, ''A3'' a dotted quarter note, ''A4'' a half note, and so on.

To get shorter notes, either divide them - e.g. if ''A'' is an eighth note, ''A/2'' is a sixteenth note, ''A3/2'' is a dotted eighth note, ''A/4'' is a thirty-second note - or change the unit note length with the ''L:'' field. Alternatively, if the music has a broken rhythm, e.g. dotted eighth note/sixteenth note pairs, use [[#broken_rhythm|broken rhythm]] markers. Note that ''A/'' is shorthand for ''A/2'' and similarly ''<nowiki>A//</nowiki>'' = ''A/4'', etc.

//Note lengths that can't be translated to conventional staff notation are legal, but should be avoided.//

==== 4.4. Broken rhythm ====

A common occurrence in traditional music is the use of a dotted or broken rhythm. For example, hornpipes, strathspeys and certain morris jigs all have dotted eighth notes followed by sixteenth notes as well as vice-versa in the case of strathspeys. To support this, ABC notation uses a ''>'' to mean 'the previous note is dotted, the next note halved' and ''<'' to mean 'the previous note is halved, the next dotted'. Thus the following lines all mean the same thing (the third version is recommended):

  L:1/16
  a3b cd3 a2b2c2d2

  L:1/8
  a3/2b/2 c/2d3/2 abcd

  L:1/8
  a>b c<d abcd

{{:abc:standard:broken-80.png}}

As a logical extension, ''>>'' means that the first note is double dotted and the second quartered and ''>>>'' means that the first note is triple dotted and the length of the second divided by eight. Similarly for ''<<'' and ''<<<''.

Note that the use of broken rhythm markers between notes of unequal lengths will produce undefined results, and should be avoided.

==== 4.5. Rests ====

Rests can be transcribed with a ''z'' or a ''x'' and can be modified in length in exactly the same way as audible notes can. ''z'' rests are printed in the resulting sheet music, while ''x'' rests are invisible, that is not notated in the printed music.

Multi-measure rests are notated using ''Z'' (upper case) followed by the number of measures, e.g.

  Z4|CD EF|GA Bc

{{:abc:standard:rests1-80.png}}

is equivalent to

  z4|z4|z4|z4|CD EF|GA Bc

{{:abc:standard:rests2-80.png}}

When no number of measures is given, ''Z'' is equivalent to a pause of one measure:

{{:abc:standard:pause-80.png}}

==== 4.6. Spacer ====

''y'' can be used to add some more space between the surrounding notes; moreover, [[#chord_symbols|chord symbols]] and [[#decorations|decorations]] can be attached to it, to make them appear between notes. Example:

  "Am" +pp+ y

Note that ''y'' does //not// create a rest in the music.

==== 4.7. Beams ====

To group notes together under one beam they should be grouped together without spaces. Thus in 2/4, ''A2BC'' will produce an eighth note followed by two sixteenth notes under one beam whilst ''A2 B C'' will produce the same notes separated. The beam slopes and the choice of upper or lower staffs are generated automatically.

Notes that cannot be beamed, should be treated as if they were always surrounded by space, e.g. if ''L:1/8'' then ''ABC2DE'' is equivalent with ''AB C2 DE''.

Back quotes ''`'' may be used freely between beamed notes to increase legibility. They are ignored by computer programs. Thus ''A2``B``C'' is interpreted the same way as ''A2BC'' is.

==== 4.8. Repeat/bar symbols ====

Bar line symbols are notated as follows:

^ **Symbol** ^ **Meaning** ^
| ''|''  | bar line                             |
| ''|]'' | thin-thick double bar line           |
| ''||'' | thin-thin double bar line            |
| ''[|'' | thick-thin double bar line           |
| ''|:'' | start of repeated section            |
| '':|'' | end of repeated section              |
| ''::'' | start & end of two repeated sections |

If an 'end of repeated section' is found without a previous 'start of repeated section', the music restarts from the beginning of the tune, or from the latest double bar line or end of repeated section.

Note that the notation ''::'' is short for '':|'' followed by ''|:''. The variants ''::'', '':|:'' and '':||:'' are all equivalent.

By extension, ''|::'' and ''::|'' mean the start and end of a section that is to be repeated three times, and so on.

A dotted bar line can be notated by preceding it with a dot, e.g. ''.|'' - this may be useful for notating editorial bar lines in music with very long measures.

An invisible bar line may be notated by putting the bar line in brackets, e.g. ''[|]'' - this may be useful for notating [[#voice_overlay|Voice overlay]] in meter free music.

ABC parsers should be quite liberal in recognizing bar lines. In the wild, bar lines may have any shape, using a sequence of ''|'' (thin bar line), ''['' or '']'' (thick bar line), and '':'' (dots), e.g. ''|[|'' or ''[|:::'' .

==== 4.9. First and second repeats ====

First and second repeats can be notated with the symbols ''[1'' and ''[2'', e.g.

  faf gfe|[1 dfe dBA:|[2 d2e dcB|].

When adjacent to bar lines, these can be shortened to '' |1'' and '':|2'', but with regard to spaces

  | [1

is legal, while

  | 1

is not.

Thus, a tune with different ending for the first and second repeats has the general form:

  |:  <common body of tune>  |1  <first ending>  :|2  <second ending>  |]

Again, note that in many ABC files the ''|:'' will not be present.

==== 4.10. Variant endings ====

In combination with ''P'' part notation, it is possible to notate more than two variant endings for a section that is to be repeated a number of times.

For example, if the header of the tune contains ''P:A4.B4'' then parts A and B will each be played 4 times. To play a different ending each time, you could write in the tune:

  P:A
  <notes> | [1  <notes>  || [2 <notes> || [3 <notes> || [4 <notes> ||

The Nth ending starts with ''[N'' and ends with one of ''||'', '':|'' ''|]'' or ''[|''. You can also mark a section as being used for more than one ending e.g.

  [1,3 <notes> ||

plays on the 1st and 3rd endings and

  [1-3 <notes> ||

plays on endings 1, 2 and 3. In general, '[' can be followed by any list of numbers and ranges as long as it contains no spaces e.g.

  [1,3,5-7  <notes>  || [2,4,8 <notes> ||

==== 4.11. Ties and slurs ====

You can tie two notes together either across or within a bar with a ''-'' symbol, e.g. ''abc-|cba'' or ''abc-cba''. More general slurs can be put in with ''()'' symbols. Thus ''(DEFG)'' puts a slur over the four notes. Spaces within a slur are OK, e.g. '' ( D E F G ) ''.

Slurs may be nested:

  (c (d e f) g a)

{{:abc:standard:slur1-80.png}}

and they may also start and end on the same note:

  (c d (e) f g a)

{{:abc:standard:slur2-80.png}}

An unnested slur on a singe note, e.g. |c d (e) f g a| is legal, but will be ignored.

A dotted slur may be notated by preceding the opening brace with a dot, e.g. ''.(cde)''; it is optional to dot the closing brace. Likewise, a dotted tie can be transcribed by preceding it with a dot, e.g. ''C.-C''. This is especially useful in parts with multiple verses: some verses may require a slur, some may not.

It should be noted that although the tie ''-'' and slur ''()'' produce similar symbols in staff notation they have completely different meanings to player programs and should not be interchanged. Ties connect two successive notes of the same pitch, causing them to be played as a single note, while slurs connect the first and last note of any series of notes, and may be used to indicate phrasing, or that the group should be played legato. Both ties and slurs may be used into, out of and between chords, and in this case the distinction between them is particularly important.

==== 4.12. Grace notes ====

Grace notes can be written by enclosing them in curly braces, ''{}''. For example, a taorluath on the Highland pipes would be written ''{GdGe}''. The tune 'Athol Brose' (in the file [[#strspysabc|Strspys.abc]]) has an example of complex Highland pipe gracing in all its glory. Although nominally grace notes have no melodic time value, expressions such as ''{a3/2b/}'' or ''{a>b}'' can be useful and are legal although some packages may ignore them. The unit duration to use for gracenotes is not specified by the ABC file, but by the package, and might be a specific amount of time (for playback purposes) or a note length (e.g. 1/32 for Highland pipe music, which would allow ''{ge4d}'' to code a piobaireachd 'cadence').

To distinguish between appoggiaturas and acciaccaturas, the latter are notated with a forward slash immediately following the open brace, e.g. ''{/g}C'' or ''{/gagab}C'':

{{:abc:standard:graces-80.png}}

The presence of gracenotes is transparent to the broken rhythm construct. Thus the forms ''A<{g}A'' and ''A{g}<A'' are legal and equivalent to ''A/2{g}A3/2''.

==== 4.13. Duplets, triplets, quadruplets, etc. ====

These can be simply coded with the notation ''(2ab'' for a duplet, ''(3abc'' for a triplet or ''(4abcd'' for a quadruplet, etc, up to ''(9''. The musical meanings are:

^ **Symbol** ^ **Meaning** ^
| ''(2'' | 2 notes in the time of 3     |
| ''(3'' | 3 notes in the time of 2     |
| ''(4'' | 4 notes in the time of 3     |
| ''(5'' | 5 notes in the time of //n// |
| ''(6'' | 6 notes in the time of 2     |
| ''(7'' | 7 notes in the time of //n// |
| ''(8'' | 8 notes in the time of 3     |
| ''(9'' | 9 notes in the time of //n// |

If the time signature is compound (6/8, 9/8, 12/8) then //n// is three, otherwise //n// is two.

More general tuplets can be specified using the syntax ''(p:q:r'' which means 'put //p// notes into the time of //q// for the next //r// notes'. If //q// is not given, it defaults as above. If //r// is not given, it defaults to //p//. For example, ''(3:2:2'' is equivalent to ''(3::2'' and ''(3:2:3'' is equivalent to ''(3:2'' , ''(3'' or even ''(3::'' . This can be useful to include notes of different lengths within a tuplet, for example ''(3:2:2 G4c2'' or ''(3:2:4 G2A2Bc'' and also describes more precisely how the simple syntax works in cases like ''(3 D2E2F2'' or even ''(3 D3EF2''. The number written over the tuplet is //p//.

Spaces that appear between the tuplet specifier (e.g. ''(p:q:r'') and the following notes are to be ignored.

==== 4.14. Decorations ====

Staccato marks (a small dot above or below the note head) can be notated by a dot before the note, i.e. a staccato triplet is written as ''(3.a.b.c''

For fiddlers, the letters ''u'' and ''v'' can be used to denote up-bow and down-bow, e.g. ''vAuBvA''

Other common symbols are available such as

  ~       Irish roll
  T       trill
  H       fermata
  L       accent or emphasis
  M       lowermordent
  P       uppermordent
  S       segno
  O       coda

However these characters (''~.uvTHLMPSO'') are just short cuts for commonly used decorations and can even be redefined (see section [[#redefinable_symbols|Redefinable symbols]]). More generally, symbols can be entered using the syntax ''+symbol+'', e.g. ''+trill+A4'' for a trill symbol (tr). The currently defined symbols (and this list may grow with time) are:

  +trill+                "tr" (trill mark)
  +lowermordent+         short /|/|/ squiggle with a vertical line through it
  +uppermordent+         short /|/|/ squiggle
  +mordent+              same as +lowermordent+
  +pralltriller+         same as +uppermordent+
  +accent+               > mark
  +>+                    same as +accent+
  +emphasis+             same as +accent+
  +fermata+              fermata or hold (arc above dot)
  +invertedfermata+      upside down fermata
  +tenuto+               horizontal line to indicate holding note for full
                         duration
  +0+ - +5+              fingerings
  +plus+                 left-hand pizzicato, or rasp for French horns
  +wedge+                small filled-in wedge mark
  +open+                 small circle above note indicating open string or
                         harmonic
  +thumb+                cello thumb symbol
  +snap+                 snap-pizzicato mark, visually similar to +thumb+
  +turn+                 a turn mark
  +roll+                 a roll mark (arc) as used in Irish music
  +breath+               a breath mark (apostrophe-like) after note
  +shortphrase+          vertical line on the upper part of the staff
  +mediumphrase+         same, but extending down to the centre line
  +longphrase+           same, but extending 3/4 of the way down
  +segno+                2 ornate s-like symbols separated by a diagonal line
  +coda+                 a ring with a cross in it
  +D.S.+                 the letters D.S. (=Da Segno)
  +D.C.+                 the letters D.C. (=either Da Coda or Da Capo)
  +dacoda+               the word "Da" followed by a Coda sign
  +dacapo+               the words "Da Capo"
  +fine+                 the word "fine"
  +crescendo(+  or +<(+  start of a < crescendo mark
  +crescendo)+  or +<)+  end of a < crescendo mark, placed after the last note
  +diminuendo(+ or +>(+  start of a > diminuendo mark
  +diminuendo)+ or +>)+  end of a > diminuendo mark, placed after the last note
  +pppp+ +ppp+ +pp+ +p+
  +mp+ +mf+ +f+ +ff+
  +fff+ +ffff+ +sfz+     dynamics marks
  +upbow+                V mark
  +downbow+              squared n mark

By extension, the following decorations have been added: ''+slide+'', ''+turnx+'', ''+invertedturn+'', ''+invertedturnx+'', ''+arpeggio+'', ''+trill(+'' and ''+trill)+''.

Here is a picture of most decorations:

{{:abc:standard:decorations1-80.png}}

Note that the decorations may be applied to both notes, rests, note groups, and bar lines. If a decoration is to be positioned between notes, it may be attached to the ''y'' spacer. Spaces may be used freely between each of the symbols and the object to which it should be attached. An object may be preceded by multiple symbols, which should be printed one over another, each on a different line. For example:

  +1+ +3+ +5+ [CEG]  +coda+ y  +p+ +trill+ C   +fermata+|

{{:abc:standard:decorations2-80.png}}

Players may choose to ignore most of the symbols mentioned above, though they may be expected to implement the dynamics marks, the accent mark and the staccato dot. Default volume is equivalent to +mf+. On a scale from 0-127, the relative volumes can be roughly defined as: ''+pppp+'' = ''+ppp+'' = 30, ''+pp+'' = 45, ''+p+'' = 60, ''+mp+'' = 75, ''+mf+'' = 90, ''+f+'' = 105, ''+ff+'' = 120, ''+fff+'' = ''+ffff+'' = 127.

Applications may allow users to define new symbols in a package dependent way.

Note that symbol names may not contain any spaces, ''['', '']'', '|' or '':'' signs. So, while +dacapo+ is legal, +da capo+ is not.

If an unimplemented or unknown symbol is found, it should be ignored.

==== 4.15. Symbol lines ====

Adding many symbols to a line of music can make a tune difficult to read. In such cases, a symbol line (a line that contains only ''+...+'' decorations and ''"..."'' chord symbols or annotations) can be used, analogous to a lyrics line. A symbol line starts with ''s:'', followed by a line of symbols. Matching of notes and symbols follows the rules defined in section [[#lyrics|Lyrics]].

Example:

     CDEF    | G```AB`c
  s: "^slow" | +f+ ** +fff+

==== 4.16. Redefinable symbols ====

As a short cut to writing symbols which avoids the ''+symbol+'' syntax (see [[#decorations|decorations]]), the letters ''H-W'' and ''h-w'' and the symbol ''~'' can be assigned with the ''U:'' field. For example, to assign the letter ''T'' to represent the trill, you can write:

  U: T = +trill+

You can also use ''"^text"'' etc (see [[#annotations|Annotations]] below) in definitions, e.g.

  U: X = ''^+''

to print a plus sign over notes with ''X'' before them.

Symbol definitions can be written in the file header, in which case they apply to all the tunes in that file, or in a tune header, when they apply only to that tune, and override any previous definitions. Programs may also make use of a set of global default definitions, which apply everywhere unless overridden by local definitions. You can assign the same symbol to two or more letters e.g.

  U: T = +trill+
  U: U = +trill+

in which case the same visible symbol will be produced by both letters (but they may be played differently), and you can de-assign a symbol by writing:

  U: T = +nil+

or

  U: T = +none+

The standard set of definitions (if you do not redefine them) is:

  U: ~ = +roll+
  U: T = +trill+
  U: H = +fermata+
  U: L = +emphasis+
  U: M = +lowermordent+
  U: P = +uppermordent+
  U: S = +segno+
  U: O = +coda+
  U: u = +upbow+
  U: v = +downbow+

Please see section [[#macros|Macros]] for an advanced macro mechanism.

==== 4.17. Chords and unisons ====

Chords (i.e. more than one note head on a single stem) can be coded with ''[]'' symbols around the notes, e.g.

  [CEGc]

produces the chord of C major. They can be grouped in beams, e.g.

  [d2f2][ce][df]

but there should be no spaces within a chord. See the tune 'Kitchen Girl' in the file [[#reelsabc|Reels.abc]] for a simple example.

All the notes within a chord should have the same length. More complicated chords can be transcribed with the ''&'' operator, see section [[#voice_overlay|Voice overlay]].

//Some packages allow chords with notes of different lengths. However, currenly the semantics of such chords are not well-defined and differ from package to package.//

The chord forms a syntactic grouping, to which the same prefixes and postfixes can be attached as to an ordinary note, except for accidentals. In particular, the following notation is legal:

  ( "^I" +f+ [CEG]- > [CEG] "^IV" [F=AC]3/2"^V"[GBD]/  H[CEG]2 )

{{:abc:standard:chords-80.png}}

When both inside and outside the chord length modifiers are used, they should be multiplied. I.e. ''[C2E2G2]3'' has the same meaning as ''[CEG]6''.

If the chord contains two notes both of the same length and pitch, such as

  [DD]

then it is a unison (e.g. a note played on two strings of a violin simultaneously) and is shown with one stem and two note-heads:

{{:abc:standard:unison-80.png}}

==== 4.18. Chord symbols ====

Chord symbols (e.g. chords/bass notes) can be put in under the melody line (or above, depending on the package) using double-quotation marks placed to the left of the note it is sounded with, e.g. ''"Am7"A2D2''.

The chord has the format //<note><accidental><type></bass>//, where //<note>// can be ''A-G'', the optional //<accidental>// can be ''b'', ''#'', the optional //<type>// is one or more of

  m or min        minor
  maj             major
  dim             diminished
  aug or +        augmented
  sus             sustained
  7, 9 ...        7th, 9th, etc.

and //</bass>// is an optional bass note.

A slash after the chord type is used only if the optional bass note is also used, e.g., ''"C/E"''. If the bass note is a regular part of the chord, it indicates the inversion, i.e., which note of the chord is lowest in pitch. If the bass note is not a regular part of the chord, it indicates an additional note that should be sounded with the chord, below it in pitch. The bass note can be any letter (''A-G'' or ''a-g''), with or without a trailing accidental sign (''b'' or ''#''). The case of the letter used for the bass note does not affect the pitch.

Alternate chords can be indicated for printing purposes (but not for playback) by enclosing them in parentheses inside the double-quotation marks after the regular chord, e.g., ''"G(Em)"''.

Programs should treat chord symbols quite liberally.

==== 4.19. Annotations ====

General text annotations can be added above, below or on the staff in a similar way to chord symbols. In this case, the string within double quotes is preceded by one of five symbols ''^'', ''_'', ''<'', ''>'' or ''@'' which controls where the annotation is to be placed; above, below, to the left or right respectively of the following note, rest or bar line. Using the ''@'' symbol leaves the exact placing of the string to the discretion of the interpreting program. These placement specifiers distinguish annotations from chord symbols, and should prevent programs from attempting to play or transpose them. All text that follows the placement specifier is treated as an [[#abc_string|ABC string]].

Where two or more annotations with the same placement specifier are placed consecutively, e.g. for fingerings, the notation program should draw them on separate lines, with the first listed at the top.

Example:

  "<(" ">)" C

Places the note between parentheses.

==== 4.20. Order of ABC constructs ====

The order of ABC constructs is: //<grace notes>//, //<chord symbols>//, //<annotations>/<decorations>// (e.g. Irish roll, staccato marker or up/downbow), //<accidentals>//, //<note>//, //<octave>//, //<note length>//, i.e. ''~^c'3'' or even ''"Gm7"v.=G,2''.

Tie symbols, ''-'', should come immediately after a note group but may be followed by a space, i.e. ''=G,2- ''. Open and close chord symbols, ''[]'', should enclose entire note sequences (except for chord symbols), e.g.

  "C"[CEGc]|
  |"Gm7"[.=G,^c']

and open and close slur symbols, ''()'', should do likewise, i.e.

  "Gm7"(v.=G,2~^c'2)

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 5. Lyrics =====

The ''W'' field (uppercase W) can be used for lyrics to be printed separately below the tune.

The ''w'' field (lowercase w) in the body, supplies a line of lyrics to be aligned syllable by syllable below the previous line of notes. Syllables are not aligned on grace notes and tied notes are treated as two separate notes; slurred or beamed notes are also treated as separate notes in this context. Note that lyrics are always aligned to the beginning of the preceding music line.

It is possible for a music line to be followed by several ''w'' fields. This can be used together with the part notation to create verses. The first ''w'' field is used the first time that part is played, then the second and so on.

The lyrics lines are treated as an [[#abc_string|ABC string]]. Within the lyrics, the words should be separated by one or more spaces and to correctly align them the following symbols may be used:

^ **Symbol** ^ **Meaning** ^
| ''-''  | (hyphen) break between syllables within a word                 |
| ''_''  | (underscore) last syllable is to be held for an extra note     |
| ''*''  | one note is skipped (i.e. * is equivalent to a blank syllable) |
| ''~''  | appears as a space; aligns multiple words under one note       |
| ''\-'' | appears as hyphen; aligns multiple syllables under one note    |
| ''|''  | advances to the next bar                                       |

Note that if ''-'' is preceded by a space or another hyphen, it is regarded as a separate syllable.

When an underscore is used next to a hyphen, the hyphen must always come first.

If there are not as many syllables as notes in a measure, typing a ''|'' automatically advances to the next bar; if there are enough syllables the '|' is just ignored.

Some examples:

  w: syll-a-ble    is aligned with three notes
  w: syll-a--ble   is aligned with four notes
  w: syll-a -ble   (equivalent to the previous line)
  w: time__        is aligned with three notes
  w: of~the~day    is treated as one syllable (i.e. aligned with one note)
                   but appears as three separate words

   gf|e2dc B2A2|B2G2 E2D2|.G2.G2 GABc|d4 B2
  w: Sa-ys my au-l' wan to your aul' wan\
     Will~ye come to the Wa-x-ies dar-gle?

Please see section [[#continuation_of_input_lines|Continuation of input lines]] for the meaning of the backslash (\) character.

If a word starts with a digit, this is interpreted as numbering of a stanza and is pushed forward a bit. In other words, use something like

     w: 1.~Three blind mice

to put a number before ''Three''.

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 6. Clefs =====

A clef line specification may be provided in ''K:'' and ''V:'' fields. The general syntax is:

  [clef=]<clef name>[<line number>][+8 | -8]
    [middle=<pitch>] [transpose=<semitones>]
    [stafflines=<lines>]

  * **clef name** - may be ''treble'', ''alto'', ''tenor'', ''bass'', ''perc'' or ''none''. ''perc'' selects the drum clef. ''clef='' may be omitted.
  * **line number** - indicates on which staff line the base clef is written. Defaults are: treble: ''2''; alto: ''3''; tenor: ''4''; bass: ''4''.
  * **+8 -8** - draws '8' above or below the staff. The player will transpose the notes one octave higher or lower.
  * **middle=<pitch>** - is an alternate way to define the line number of the clef. The pitch indicates what note is displayed on the 3rd line of the staff. Defaults are: treble: ''B''; alto: ''C''; tenor: ''A,''; bass: ''D,''; none: ''B''.
  * **transpose=<semitones>** - when playing, transpose the current voice by the indicated amount of semitones. This does not affect the printed score. Default is 0.
  * **stafflines=<lines>** - the number of lines in the staff. Default is 5.

Note that the ''clef'', ''transpose'', ''middle'' and ''stafflines'' specifiers may be used independent of each other.

Examples:

  [K:   clef=alto]
  [K:   perc stafflines=1]
  [K:Am transpose=-2]
  [V:B  middle=d bass]

Note that although this standard supports the drum clef, there is currently no support for special percussion notes.

The middle specifier can be handy when working in the bass clef. Setting ''K:bass middle=d'' will save you from adding comma specifiers to the notes. The specifier may be abbreviated to ''m=''.

The transpose specifier is useful for e.g. a Bb clarinet, for which the music is written in the key of C, although the instrument plays it in the key of Bb:

  [V:Clarinet] [K:C transpose=-2]

The transpose specifier may be abbreviated to ''t=''.

To notate the various standard clefs, one can use the following specifiers:

The seven clefs
^ Name ^ specifier ^
| Treble | ''K:treble'' |
| Bass | ''K:bass'' |
| Baritone | ''K:bass3'' |
| Tenor | ''K:tenor'' |
| Alto | ''K:alto'' |
| Mezzosoprano | ''K:alto2'' |
| Soprano | ''K:alto1'' |

More clef names may be allowed in the future, therefore unknown names should be ignored. If the clef is unknown or not specified, the default is treble.

Applications may introduce their own clef line specifiers. These specifiers should start with the name of the application, followed a colon, folowed by the name of the specifier.

Example:

  V:p1 perc stafflines=3 m=C  mozart:noteC=snare-drum

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 7. Multiple voices =====

The ''V:'' field allows the writing of multi-voice music. In multi-voice ABC tunes, the tune body is divided into several sections, each beginning with a ''V:'' field. All the notes following such a ''V:'' field, up to the next ''V:'' field or the end of the tune body, belong to the voice.

The basic syntax of the field is:

  V:ID

where ID can be either a number or a string, that uniquely identifies the voice in question. When using a string, only the first 20 characters of it will be distinguished. The ID will not be printed on the staff; it's only function is to indicate throughout the ABC file, which music line belongs to which voice.

Example:

  X:1
  T:Zocharti Loch
  C:Louis Lewandowski (1821-1894)
  M:C
  Q:1/4=76
  %%score (T1 T2) (B1 B2)
  V:T1           clef=treble-8  name="Tenore I"   snm="T.I"
  V:T2           clef=treble-8  name="Tenore II"  snm="T.II"
  V:B1  middle=d clef=bass      name="Basso I"    snm="B.I"
  V:B2  middle=d clef=bass      name="Basso II"   snm="B.II"
  K:Gm
  %            End of header, start of tune body:
  % 1
  [V:T1]  (B2c2 d2g2)  | f6e2      | (d2c2 d2)e2 | d4 c2z2 |
  [V:T2]  (G2A2 B2e2)  | d6c2      | (B2A2 B2)c2 | B4 A2z2 |
  [V:B1]       z8      | z2f2 g2a2 | b2z2 z2 e2  | f4 f2z2 |
  [V:B2]       x8      |     x8    |      x8     |    x8   |
  % 5
  [V:T1]  (B2c2 d2g2)  | f8        | d3c (d2fe)  | H d6    ||
  [V:T2]       z8      |     z8    | B3A (B2c2)  | H A6    ||
  [V:B1]  (d2f2 b2e'2) | d'8       | g3g  g4     | H^f6    ||
  [V:B2]       x8      | z2B2 c2d2 | e3e (d2c2)  | H d6    ||

This layout closely resembles printed music, and permits the corresponding notes on different voices to be vertically aligned so that the chords can be read directly from the abc. The addition of single remark lines "%" between the grouped staves, indicating the bar nummers, also makes the source more legible.

Here follows the visible output:

{{:abc:standard:multivoice-80.png}}

Here follows the audible output:

[[http://abcnotation.com/media/standard/multivoice.mid|MIDI]]

''V:'' can appear both in the body and the header. In the latter case, ''V:'' is used exclusively to set voice properties. For example, the ''name'' property in the example above, specifies which label should be printed on the first staff of the voice in question. Note that these properties may be also set or changed in the tune body. The ''V:'' properties will be fully explained in the next section.

Please note that the exact grouping of voices on the staff or staves is not specified by ''V:'' itself. This may be specified with the ''<nowiki>%%score</nowiki>'' stylesheet directive. See section [[#voice_grouping|Voice grouping]] for details. Please see section [[#instrumentation_directives|Instrumentation directives]] to learn how to assign a General MIDI instrument to a voice, using a ''<nowiki>%%MIDI</nowiki>'' stylesheet directive.

Although it is not recommended, the tune body of fragment ''X:1'', could also be notated this way:

  X:2
  T:Zocharti Loch
  %...skipping rest of the header...
  K:Gm
  %               Start of tune body:
  V:T1
   (B2c2 d2g2) | f6e2 | (d2c2 d2)e2 | d4 c2z2 |
   (B2c2 d2g2) | f8 | d3c (d2fe) | H d6 ||
  V:T2
   (G2A2 B2e2) | d6c2 | (B2A2 B2)c2 | B4 A2z2 |
   z8 | z8 | B3A (B2c2) | H A6 ||
  V:B1
   z8 | z2f2 g2a2 | b2z2 z2 e2 | f4 f2z2 |
   (d2f2 b2e'2) | d'8 | g3g  g4 | H^f6 ||
  V:B2
   x8 | x8 | x8 | x8 |
   x8 | z2B2 c2d2 | e3e (d2c2) | H d6 ||

In the example above, each ''V:'' label occurs only once, and the complete part for that voice follows. The output of tune ''X:2'' will be exactly the same as the ouput of tune ''X:1''; the source code of ''X:1'', however, is much better readable.

==== 7.1. Voice properties ====

''V:'' fields can contain voice specifiers such as name, clef, and so on. For example,

  V:T name="Tenor" clef=treble-8

indicates that voice ''T'' will be drawn on a staff labelled ''Tenor'', using the treble clef with a small ''8'' underneath. Player programs will transpose the notes by one octave. Possible voice definitions include:

  * **name="voice name"** - the voice name is printed on the left of the first staff only. The characters ''\n'' produce a newline int the output.
  * **subname="voice subname"** - the voice subname is printed on the left of all staves but the first one.
  * **stem=up/down** - forces the note stem direction.
  * **clef=** - specifies a clef; see section [[#clefs|Clefs]] for details.

The name specifier may be abbreviated to ''nm=''. The subname specifier may be abbreviated to ''snm=''.

Applications may implement their own specifiers, but must gracefully ignore specifiers they don't understand or implement. This is required for portability of ABC files between applications.

==== 7.2. Breaking lines ====

The rules for breaking lines in multi-voice ABC files are the same as described above. Each line of input may end in a backslash (\) to continue it; lyrics should immediately follow in ''w:'' lines (if any). See the example tune [[#canzonettaabc|Canzonetta.abc]].

==== 7.3. Inline fields ====

To avoid ambiguity, inline fields that specify music properties should be repeated in each voice. For example,

  ...
  P:C
  [V:1] C4|[M:3/4]CEG|Gce|
  [V:2] E4|[M:3/4]G3 |E3 |
  P:D
  ...

==== 7.4. Voice overlay ====

The ''&'' operator may be used to temporarily overlay several voices within one measure. The ''&'' operator sets the time point of the music back to the previous bar line, and the notes which follow it form a temporary voice in parallel with the preceding one. This may only be used to add one complete bar's worth of music for each ''&''.

Example:

  A2 | c d e f g  a  &\
       A A A A A  A  &\
       F E D C B, A, |]

{{:abc:standard:overlay1-80.png}}

It can also be used to overlay a pattern of chord symbols on a melody line:

  B4              z   +5+c (3BAG &\
  "Em" x2 "G7" x2 "C" x4         |

{{:abc:standard:overlay2-80.png}}

Likewise, the ''&'' operator may be used in ''w:'' lyrics and in ''s:'' symbol lines, to provide a separate line of lyrics and symbols to each of the overlayed voices:

     g4 f4 | e6 e2  &\
     (d8   | c6) c2
  w: ha-la-| lu-yoh &\
     lu-   |   -yoh

{{:abc:standard:overlay3-80.png}}

In meter free music, invisible bar line signs ''[|]'' may be used instead of regular ones.

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 8. ABC data format =====

Each line in the file may end with blank space which will be ignored. For the purpose of this standard, ASCII Tab and ASCII Space characters are equivalent and are both designated with the term 'space'. Applications must be able to interpret end-of-line markers in Unix (''<LF>''), PC (''<CR><LF>''), and Macintosh style (''<CR>'') correctly.

==== 8.1. Tune body ====

Within the tune body, all the printable ASCII characters may be used for the actual music notation. These are:

   !"#$%&'()*+,-./0123456789:;<=>?@
  ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`
  abcdefghijklmnopqrstuvwxyz{|}~

Of these, the following characters are currently reserved:

  # $ * ; ? @

In future standards they may be used to extend the ABC syntax.

To ensure forward compatibility, current software should ignore these characters when they appear inside or between note groups, possibly giving a warning. However, these characters may not be ignored when they appear inside ABC strings or fields.

Example:

  @a +pp+ #bc2/3* [K:C#] de?f "@this $2was difficult to parse?" y |**

should be treated as:

  a +pp+ bc2/3 [K:C#] def "@this $2was difficult to parse?" y |

==== 8.2. ABC string ====

The contents of ABC strings may be written using any character set. The default ABC string character set is Latin-1, which is convenient since it is also the default used in webpages. If you would like to use a different character set, such as utf-8, you may find more information in section [[#charset_field|Charset field]].

To write non-English characters in ABC strings, special sequences of characters should be used to avoid portability problems. These sequences start with a backslash (\), followed by an accent and a letter.

  accent          example         how to write it
  -----------------------------------------------
  grave           À à è ò         \`A \`a \`e \`o
  acute           Á á é ó         \'A \'a \'e \'o
  circumflex      Â â ê ô         \^A \^a \^e \^o
  umlaut          Ä ä ë ö         \"A \"a \"e \"o
  tilde           Ã ã ñ õ         \~A \~a \~n \~o
  cedilla         Ç ç             \,C \,c
  slash           Ø ø             \/O \/o
  ring            Å å             \oA \oa
  ligature        ß Æ æ           \ss \AE \ae

To get an actual backslash, type ''\\''.

To typeset a //macron// on a letter //x//, type ''\=x''. To typeset an //ogonek//, type ''\;x''. To typeset a //caron//, type ''\vx''. To typeset a //breve//, type ''\ux''. To typeset a long Hungarian umlaut, type ''\:x''. Finally, to typeset a dotted letter, type ''\.x''.

Programs that have difficulty typesetting accented letters may reduce them to the base letter. ''\"y'' can be reduced to ''y'', ''\oA'' can be reduced to ''A'', etc. Ligatures can be reduced by simply ignoring the backslash: ''\ss'' becomes ''ss'', ''\AE'' becomes ''AE'', etc.

There is a [[#full_table_of_accented_letters|Full table of accented letters]] in the appendix.

Characters may also be coded by typing ''\d'' followed by the decimal code of the character, followed by a semicolon. The meaning of these codes depends on the character set used. Some examples for the default Latin-1 charset: ''\d163;'' = ''£'', ''\d161;'' = ''¡'' and ''\d191;'' = ''¿''.

Furthermore, a number of special symbols can be used in ABC strings. To typeset the international copyright symbol, write ''(C)''. To typeset a flat sign, write ''(b)''. To typeset a sharp sign, write ''(#)''. To typeset a natural sign, write ''(=)''.

The specifiers ''$1'', ''$2'', ''$3'' and ''$4'' can be used to change the font within an ABC string. The fonts to be used can be indicated with the ''<nowiki>%%setfont-n</nowiki>'' stylesheet directive. ''$0'' resets the font to its default value. ''$$'' gives an actual dollar sign. See section [[#font_settings|Font settings]] for full details.

Examples:

<code>
%%abc-copyright (C) Fr\'ed\'erique M\"oller
"^A((#))" (^)A
w: Will~ye come to the $3Wa-x-ies$0 dar-gle?
</code>

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 9. Macros =====

This standard defines an **optional** system of macros which is principally used to define the way in which ornament symbols such as the tilde ''~'' are played (although it could be used for many other purposes).

Software implementing these macros, should first expand the macros defined in this section, and only afterwards apply any relevant ''U:'' replacement (see section [[#redefinable_symbols|Redefinable symbols]]).

When these macros are stored in an ABC Header file (see section [[#include_field|Include field]]), they may form a powerful library.

There are two kinds of macro, called Static and Transposing.

==== 9.1. Static macros ====

You define a static macro by writing into the tune header something like this:

   m: ~G3 = G{A}G{F}G

When you play the tune, the program searches the tune header for macro definitions, then does a search and replace on its internal copy of the text before passing that to the parser which plays the tune. Every occurence of ''~G3'' in the tune is replaced by ''G{A}G{F}G'', and that is what gets played. Only ''~G3'' notes are affected, ''~G2'', ''~g3'', ''~F3'' etc. are ignored.

You can put in as many macros as you want, and indeed, if you only use static macros you will need to write a separate macro for each combination of pitch and note-length. Here is an example:

  X:50
  T:Apples in Winter
  S:Trad, arr. Paddy O'Brien
  R:jig
  E:9
  m: ~g2 = {a}g{f}g
  m: ~D2 = {E}D{C}D
  M:6/8
  K:D
  G/2A/2|BEE dEE|BAG FGE|~D2D FDF|ABc ded|
  BEE BAB|def ~g2 e|fdB AGF|GEE E2:|
  d|efe edB|ege fdB|dec dAF|DFA def|
  [1efe edB|def ~g2a|bgb afa|gee e2:|
  [2edB def|gba ~g2e|fdB AGF|GEE E2||

Here I have put in two static macros, since there are two different notes in the tune marked with a tilde.

A static macro definition consists of four parts:

  * the field identifier ''m:''
  * the target string - e.g ''~G3''
  * the equals sign
  * the replacement string - e.g. ''G{A}G{F}G''

The target string can consist of any string up to 31 characters in length, except that it may not include the letter 'n', for reasons which will become obvious later. You don't have to use the tilde, but of course if you don't use a legal combination of abc, other programs will not be able to play your tune.

The replacement string consists of any legal abc text up to 200 characters in length. It's up to you to ensure that the target and replacement strings occupy the same time interval (the program does not check this). Both the target and replacement strings may have spaces embedded if necessary, but leading and trailing spaces are stripped off so

  m:~g2={a}g{f}g

is perfectly OK, although less readable.

==== 9.2. Transposing macros ====

If your tune has ornaments on lots of different notes, and you want them to all play with the same ornament pattern, you can use transposing macros to achieve this. Transposing macros are written in exactly the same way as static macros, except that the note symbol in the target string is represented by 'n' (meaning any note) and the note symbols in the replacement string by other letters (h to z) which are interpreted according to their position in the alphabet relative to n.

So, for example I could re-write the static macro ''m: ~G3 = G{A}G{F}G'' as a transposing macro ''m: ~n3 = n{o}n{m}n''. When the transposing macro is expanded, any note of the form ''~n3'' will be replaced by the appropriate pattern of notes. Notes of the form ''~n2'' (or other lengths) will be ignored, so you will have to write separate transposing macros for each note length.

Here's an example:

  X:35
  T:Down the Broom
  S:Trad, arr. Paddy O'Brien
  R:reel
  M:C|
  m: ~n2 = (3o/n/m/ n                % One macro does for all four rolls
  K:ADor
  EAAG~A2 Bd|eg~g2 egdc|BGGF GAGE|~D2B,D GABG|
  EAAG ~A2 Bd|eg~g2 egdg|eg~g2 dgba|gedB BAA2:|
  ~a2ea agea|agbg agef|~g2dg Bgdg|gfga gede|
  ~a2 ea agea|agbg ageg|dg~g2 dgba|gedB BA A2:|

A transposing macro definition consists of four parts:

  * the field identifier ''m:''
  * the target string - e.g ''~n3''
  * the equals sign
  * the replacement string - e.g. ''n{o}n{m}n''

The target string can consist of any string up to 31 characters in length, except that it must conclude with the letter 'n', followed by a number which specifies the note length.

The replacement string consists of any legal abc text up to 200 characters in length, where note pitches are defined by the letters h - z, the pitches being interpreted relative to that of the letter n. Once again you should ensure that the time intervals match. You should not use accidentals in transposing macros (I can't for the life of me think of a way to transpose ''~=a3'' or ''~^G2'' which will work correctly under all circumstances, so if you need to do this you must use a static macro.)

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 10. Deprecated ABC syntax =====

==== 10.1. Deprecated fields ====

An ''E:'' field was once used by ''abc2mtex'' to explicitly control note spacing; this is no longer neccesary with current formatting algorithms.

The ''A:'' field was used to contain area information. Now, the ''A:'' field contains the name of the lyrics author, and area information can be stored in the ''O:'' field.

==== 10.2. Deprecated decorations ====

The widespread ''abc2win'' program used a ''!'' character to force line breaks, while the previous ABC standard adopted a ''!...!'' syntax to indicate decorations.

The ''abc2win'' usage obviously conflicted with the ''!...!'' style notation for decorations (see section [[#decorations|Decorations]]). Therefore the current standard deprecates the ''!...!'' notation in favour of a ''+...+'' style symbol notation.

To support both the deprecated ''!...!'' syntax and the ''!'' line breaks, the following algorithm is proposed:

When encountering a ''!'', scan forward. If you find another ''!'' before encountering any of ''|[:]'', a space, or the end of line, then you have a decoration, otherwise it is a line break.

Users should avoid using ''!'' line breaks together with the deprecated ''!...!'' symbol syntax.

==== 10.3. Deprecated continuations ====

The following fragment of code:

  G2G2A4 | (FEF) D (A2G) G|\
   M:4/4
   K:C
               c2c2(B2c2) |

was considered to be equivalent to:

  G2G2A4 | (FEF) D (A2G) G|[M:4/4][K:C]c2c2(B2c2) |

Furthermore, the following code:

  w: Sa-ys my au-l' wan to your aul' wan\
  w: Will~ye come to the Wa-x-ies dar-gle?

was considered to be equivalent to:

  w: Sa-ys my au-l' wan to your aul' wan\
     Will~ye come to the Wa-x-ies dar-gle?

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 11. ABC stylesheet specification =====

Music is not only played by humans, but is also conveniently typeset or played by computer programs. The ABC language, however, is a high-level description of music, which only deals with structural information. How this structural information is to be actually rendered by e.g. a typesetter or a player can be controlled using an ABC Stylesheet.

An ABC stylesheet consists of //directives// which are interspersed in a normal ABC file, or collected in an ABC Header file (see section [[#include_field|Include field]]). These are lines that //start// with ''<nowiki>%%</nowiki>'', followed by keywords that give indications to typesetting or player programs. Some examples could be:

  %%papersize A4
  %%newpage
  %%setbarnb 10

Alternatively, the directives may be contained in an ''I:'' (instruction) field:

  I:papersize A4
  I:newpage
  I:setbarnb 10

There may be given only one directive per ''I:'' field. The inline field notation may be used to give a directive in the middle of a line of music:

  CDEFG|[I:setbarnb 10]ABc

If a program doesn't recognise a directive, it should just ignore it.

Predictably, the list of possible directives is long. Applications should provide directives for specifying system and page layout, text annotations, fonts, spacings, voice instruments, transposition, and possibly other details.

It should be stressed that the ABC stylesheet specification is not part of the ABC specification itself. It forms an additional standard. Strictly speaking, ABC applications don't have to conform to the same set of directives. However, it's highly desirable that they do: this arrangement will make the same ABC file portable between different computer systems.

In fact, the ABC standard relates to the ABC Stylesheet specification, as HTML relates to CSS.

==== 11.1. Voice grouping ====

Basic syntax:

  %%score <voice-id1> <voice-id2> ... <voice-idn>

The score directive specifies which voices should be printed in the score and how they should be grouped on the staves.

Voices that are enclosed by parentheses ''()'', will go on one staff. Together they form a voice group. A voice that is not enclosed by parentheses forms a voice group on its own, that will be printed on a separate staff.

If voice groups are enclosed by curly braces ''{}'', the corresponding staves will be connected by a big curly brace printed in front of the staves. Together they form a voice block. This format is used especially for typesetting keyboard music.

If voice groups or braced voice blocks are enclosed by brackets ''[]'', the corresponding staves will be connected by a big bracket printed in front of the staves. Together they form a voice block.

If voice blocks, or voice groups are separated from each other by a ''|'' character, continued bar lines will be drawn between the associated staves.

Example:

  %%score Solo  [(S A) (T B)]  {RH | (LH1 LH2)}

If a single voice, surrounded by two voice groups, is preceded by a star (''*''), the voice is marked to be floating. This means, that the voice won't be printed on it's own staff; rather the software should automatically determine for each note of the voice, whether it should be printed on the preceding staff or on the following staff.

Software that does not support floating voices, may simply print the voice on the preceding staff, as if it were part of the preceding voice group.

Examples:

  %%score {RH *M| LH}
  %%score {(RH1 RH2) *M| (LH1 LH2)}

String parts in an orchestral work are usually bracketed together and the top two (1st/2nd violins) then braced outside the bracket:

  %%score [{Vln1 | Vln2} | Vla | Vc | DB]

Voices that appear in the tune body, but not in the score directive, won't be printed.

When the score directive occurs within the tune body, it resets the music generator, so that voices may appear and disappear for some period of time.

If no score directive is used, all voices that appear in the tune body are printed on separate staves.

See [[#canzonettaabc|Canzonetta.abc]] for an extensive example.

An alternative directive to ''<nowiki>%%score</nowiki>'' is ''<nowiki>%%staves</nowiki>''.

Both ''<nowiki>%%score</nowiki>'' and ''<nowiki>%%staves</nowiki>'' directives accept the same parameters, but measure bar indications work the opposite way. Therefore, ''<nowiki>%%staves [S|A|T|B]</nowiki>'' is equivalent to ''<nowiki>%%score [SATB]</nowiki>'' and means that continued bar lines are not drawn between the associated staves, while ''<nowiki>%%staves [SATB]</nowiki>'' is equivalent to ''<nowiki>%%score [S|A|T|B]</nowiki>'' and means that they are.

==== 11.2. Instrumentation directives ====

  %%MIDI voice [<ID>] [instrument=<integer> [bank=<integer>]] [mute]

Assigns a MIDI instrument to the indicated ABC voice. The MIDI instruments are organized in banks of 128 instruments each. Both the instruments and the banks are numbered starting from one.

The General MIDI (GM) standard defines a portable, numbered set of 128 instruments; these are listed in section [[#general_midi_instruments|General MIDI instruments]]. The GM instruments can be used by selecting bank one. Since the contents of the other MIDI banks is platform dependent, it is highly recommended to only use the first MIDI bank in tunes that are to be distributed.

The default bank number is one.

Example:

  %%MIDI voice Tb instrument=59

assigns GM instrument 59 (tuba) to voice 'Tb'.

If the voice ID is ommited, the instrument is assigned to the current voice:

  M:C
  L:1/8
  Q:1/4=66
  K:C
  V:Rueckpos
  %%MIDI voice instrument=53 bank=2
  A3B    c2c2    |d2e2    de/f/P^c3/d/|d8    |z8           |
  V:Organo
  %%MIDI voice instrument=73 bank=2
  z2E2-  E2AG    |F2E2    F2E2        |F6  F2|E2CD   E3F/G/|

You can use the keyword ''mute'' to mute the specified voice.

Some ABC players can automatically generate an accompaniment based on the [[#chord_symbols|chord symbols]] specified in the melody line. To suggest a GM instrument for playing this accompaniment, use the following directive:

  %%MIDI chordprog 20 % Church organ

==== 11.3. Accidental directives ====

  %%propagate-accidentals not | octave | pitch

When set to ''not'', accidentals apply only to the note they're attached to. When set to ''octave'', accidentals also apply to all the notes of the same pitch in the same octave up to the end of the bar. When set to ''pitch'', accidentals also apply to all the notes of the same pitch in all octaves up to the end of the bar.

The default value is ''pitch''.

  %%writeout-accidentals none | added | all

When set to ''none'', modifying or explicit accidentals that appear in the key signature field (''K:'') are printed in the key signature. When set to ''added'', only the accidentals belonging to the mode indicated in the ''K:'' field, are printed in the key signature. Modifying or explicit accidentals are printed in front of the notes to which they apply. When set to ''all'', both the accidentals belonging to the mode and possible modifying or explicit accidentals are printed in front of the notes to which they apply; no key signature will be printed.

The default value is ''none''.

==== 11.4. Formatting directives ====

Typesetting programs should accept the set of directives in the next sections. The parameter of a directive can be an ABC string, a logical value '1' (true) or '0' (false), an integer number, a number with decimals (just 'number' in the following), or a unit of length. Units can be expressed in cm, in, and pt (points, 1/72 inch).

The following directives should be self-explanatory.

//TODO: ADD EXPLANATIONS.//

=== 11.4.1. Page format ===

  %%pageheight       <length>
  %%pagewidth        <length>
  %%topmargin        <length>
  %%botmargin        <length>
  %%leftmargin       <length>
  %%rightmargin      <length>
  %%indent           <length>
  %%landscape        <logical>

=== 11.4.2. Font settings ===

PostScript and PDF are the standard file formats for distributing printable material. For portability reasons, typesetters will use the PostScript font names. The size paramater should be an integer, but is optional.

  %%titlefont        <font name>  <size>
  %%subtitlefont     <font name>  <size>
  %%composerfont     <font name>  <size>
  %%partsfont        <font name>  <size>
  %%tempofont        <font name>  <size>
  %%gchordfont       <font name>  <size> % for chords symbols
  %%annotationfont   <font name>  <size> % for "^..." annotations
  %%infofont         <font name>  <size>
  %%textfont         <font name>  <size>
  %%vocalfont        <font name>  <size> % for w:
  %%wordsfont        <font name>  <size> % for W:

The specifiers ''$1'', ''$2'', ''$3'' and ''$4'' can be used to change the font within an [[#abc_string|ABC string]]. The font to be used can be specified with the ''<nowiki>%%setfont-n</nowiki>'' directives. ''$0'' resets the font to its default value. ''$$'' gives an actual dollar sign.

  %%setfont-1        <font name>  <size>
  %%setfont-2        <font name>  <size>
  %%setfont-3        <font name>  <size>
  %%setfont-4        <font name>  <size>

=== 11.4.3. Spaces ===

  %%topspace         <length>
  %%titlespace       <length>
  %%subtitlespace    <length>
  %%composerspace    <length>
  %%musicspace       <length> % between composer and 1st staff
  %%partsspace       <length>
  %%vocalspace       <length>
  %%wordsspace       <length>
  %%textspace        <length>
  %%infospace        <length>
  %%staffsep         <length> % between systems
  %%sysstaffsep      <length> % between staves in the same system
  %%barsperstaff     <integer>
  %%parskipfac       <number> % space between parts
  %%lineskipfac      <number> % space between lines of text
  %%stretchstaff     <logical>
  %%stretchlast      <logical>
  %%maxshrink        <number> % shrinking notes
  %%scale            <number>

=== 11.4.4. Measures ===

  %%measurefirst     <integer> % number of first measure
  %%barnumbers       <integer> % bar numbers every 'n' measures
  %%measurenb        <integer> % same as %%barnumbers
  %%measurebox       <logical>
  %%setbarnb         <integer> % set measure number

=== 11.4.5. Text ===

  %%text             <ABC String>
  %%center           <ABC String>
  %%begintext
  %%...
  %%endtext
  %%sep
  %%sep              <number 1> <number 2> <number 3>
  %%vskip
  %%vskip            <number>
  %%newpage

Notes:

  * ''<nowiki>%%text</nowiki>'' is followed by text that will be printed verbatim.
  * ''<nowiki>%%center</nowiki>'' prints the following text centered.
  * ''<nowiki>%%begintext</nowiki>'' and ''<nowiki>%%endtext</nowiki>'' mark a section of lines that start in ''<nowiki>%%</nowiki>'', followed by text. It's an alternative to several ''<nowiki>%%text</nowiki>'' lines.
  * ''<nowiki>%%sep</nowiki>'' draws a separator, e.g. a horizontal line. If followed by three parameters, the line has //number 1// space above, //number 2// space below, and is long //number 3//.
  * ''<nowiki>%%vskip</nowiki>'' adds //number// space.
  * ''<nowiki>%%newpage</nowiki>'' starts a new page.

=== 11.4.6. Misc ===

  %%continueall      <logical> % ignore line breaks
  %%exprabove        <logical>
  %%exprbelow        <logical>
  %%graceslurs       <logical> % grace notes slur to main note
  %%infoline         <logical> % rhythm and origin on the same line
  %%musiconly        <logical> % don't output lyrics
  %%oneperpage       <logical>
  %%vocalabove       <logical>
  %%withxrefs        <logical> % print X: index in title
  %%writehistory     <logical>
  %%freegchord       <logical> % print '#', 'b' and '=' as they are
  %%printtempo       <logical>

==== 11.5. Application specific directives ====

Applications may introduce their own directives. These directives should start with the name of the application, followed a colon, folowed by the name of the directive.

Example:

  %%noteedit:fontcolor  blue

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 12. Portability issues =====

The lack of a well-defined ABC standard wouldn't be a problem, were ABC a human-only notation system. People are smart and flexible (mostly). But when it comes to computer programs, the situation is critical.

Unfortunately, minor variations of the ABC syntax are commonly found. This makes applications slightly incompatible with each other. Obviously, we want ABC files to be readable by as many programs as possible.

Some basic suggestions are:

  * please //do not use// package-specific commands if you plan to distribute your ABC files.
  * please use a text preprocessor to isolate and/or remove package-specific features.
  * please stick to standard file formats: PDF and PostScript give the best results for printing, PNG and JPG are acceptable; MIDI is probably the only sensible option for audible output.
  * if you are a programmer, please try and write cross-platform ABC programs.
  * if you are a programmer, please try to make your ABC programs compatible with others.

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 13. Sample ABC tunes =====

==== 13.1. English.abc ====

  H:This file contains some example English tunes
  O:England             % the origin of all tunes is England
  
  X:1                   % tune no 1
  T:Dusty Miller, The   % title
  T:Binny's Jig         % an alternative title
  C:Trad.               % traditional
  R:DH                  % double hornpipe
  M:3/4                 % meter
  K:G                   % key
  B>cd BAG|FA Ac BA|B>cd BAG|DG GB AG:|\
  Bdd gfg|aA Ac BA|Bdd gfa|gG GB AG:|
  BG G/2G/2G BG|FA Ac BA|BG G/2G/2G BG|DG GB AG:|
  W:Hey, the dusty miller, and his dusty coat;
  W:He will win a shilling, or he spend a groat.
  W:Dusty was the coat, dusty was the colour;
  W:Dusty was the kiss, that I got frae the miller.
  
  X:2
  T:Old Sir Simon the King
  C:Trad.
  S:Offord MSS          % from Offord manuscript
  N:see also Playford   % reference note
  M:9/8
  R:SJ                  % slip jig
  N:originally in C     % transcription note
  K:G
  D|GFG GAG G2D|GFG GAG F2D|EFE EFE EFG|A2G F2E D2:|
  D|GAG GAB d2D|GAG GAB c2D|[1 EFE EFE EFG|A2G F2E D2:|\
  M:12/8                % change meter for a bar
  [2 E2E EFE E2E EFG|\
  M:9/8                 % change back again
  A2G F2E D2|]
  
  X:3
  T:William and Nancy
  T:New Mown Hay
  T:Legacy, The
  C:Trad.
  O:England, Gloucs, Bledington % more specific place of origin
  B:Sussex Tune Book            % can be found in these books
  B:Mally's Cotswold Morris vol.1 2
  D:Morris On                   % can be heard on this record
  P:(AB)2(AC)2A                 % play the parts in this order
  M:6/8
  K:G
  P:A                   % part A
  D|"G"G2G GBd|"C"e2e "G"dBG|"D7"A2d "G"BAG|"C"E2"D7"F "G"G2:|
  P:B                   % part B
  d|"G"e2d B2d|"C"gfe "G"d2d| "G"e2d    B2d|"C"gfe    "D7"d2c|
    "G"B2B Bcd|"C"e2e "G"dBG|"D7"A2d "G"BAG|"C"E2"D7"F "G"G2:|
  T:Slows
  M:4/4                 % change meter
  L:1/4                 % and default note length
  P:C                   % part C
  "G"d2|"C"e2 "G"d2|B2 d2|"Em"gf "A7"e2|"D7"d2 "G"d2|"C"e2 "G"d2|
  M:3/8
  L:1/8
  "G"B2d|[M:6/8]"C"gfe "D7"d2c|
    "G"B2B Bcd|"C"e2e "G"dBG|"D7"A2d "G"BAG|"C"E2"D7"F "G"G2:|

==== 13.2. Strspys.abc ====

  M:4/4
  O:Scottish
  R:Strathspey
  
  X:1
  T:A. A. Cameron's
  K:D
  e<A A2 B>G d>B|e<A A2 d>g (3fed|e<A A2 B>G d>B|B<G G>B d>g (3fed:|
  B<e e>f g>e a>f|B<e e>f g>e (3fed|B<e e>f g>e a>f|d<B G>B d>g (3fed:|
  
  X:2
  T:Atholl Brose
  K:D
  {gcd}c<{e}A {gAGAG}A2 {gef}e>A {gAGAG}Ad|\
  {gcd}c<{e}A {gAGAG}A>e {ag}a>f {gef}e>d|\
  {gcd}c<{e}A {gAGAG}A2 {gef}e>A {gAGAG}Ad|\
  {g}c/d/e {g}G>{d}B {gf}gG {dc}d>B:|\
  {g}c<e {gf}g>e {ag}a>e {gf}g>e|\
  {g}c<e {gf}g>e {ag}a2 {GdG}a>d|\
  {g}c<e {gf}g>e {ag}a>e {gf}g>f|\
  {gef}e>d {gf}g>d {gBd}B<{e}G {dc}d>B|\
  {g}c<e {gf}g>e {ag}a>e {gf}g>e|\
  {g}c<e {gf}g>e {ag}a2 {GdG}ad|\
  {g}c<{GdG}e {gf}ga {f}g>e {g}f>d|\
  {g}e/f/g {Gdc}d>c {gBd}B<{e}G {dc}d2|]\

==== 13.3. Reels.abc ====

  M:4/4
  O:Irish
  R:Reel
  
  X:1
  T:Untitled Reel
  C:Trad.
  K:D
  eg|a2ab ageg|agbg agef|g2g2 fgag|f2d2 d2:|\
  ed|cecA B2ed|cAcA E2ed|cecA B2ed|c2A2 A2:|
  K:G
  AB|cdec BcdB|ABAF GFE2|cdec BcdB|c2A2 A2:|
  
  X:2
  T:Kitchen Girl
  C:Trad.
  K:D
  [c4a4] [B4g4]|efed c2cd|e2f2 gaba|g2e2 e2fg|
  a4 g4|efed cdef|g2d2 efed|c2A2 A4:|
  K:G
  ABcA BAGB|ABAG EDEG|A2AB c2d2|e3f edcB|ABcA BAGB|
  ABAG EGAB|cBAc BAG2|A4 A4:|

==== 13.4. Canzonetta.abc ====

  % canzonetta.abc
  %%pagewidth      21cm
  %%pageheight     29.7cm
  %%topspace       0.5cm
  %%topmargin      1cm
  %%botmargin      0cm
  %%leftmargin     1cm
  %%rightmargin    1cm
  %%titlespace     0cm
  %%titlefont      Times-Bold 32
  %%subtitlefont   Times-Bold 24
  %%composerfont   Times 16
  %%vocalfont      Times-Roman 14
  %%staffsep       60pt
  %%sysstaffsep    20pt
  %%musicspace     1cm
  %%vocalspace     5pt
  %%measurenb      0
  %%barsperstaff   5
  %%scale          0.7
  X: 1
  T: Canzonetta a tre voci
  C: Claudio Monteverdi (1567-1643)
  M: C
  L: 1/4
  Q: "Andante mosso" 1/4 = 110
  %%score [1 2 3]
  V: 1 clef=treble name="Soprano"sname="A"
  V: 2 clef=treble name="Alto"   sname="T"
  V: 3 clef=bass middle=d name="Tenor"  sname="B"
  %%MIDI program 1 75 % recorder
  %%MIDI program 2 75
  %%MIDI program 3 75
  K: Eb
  % 1 - 4
  [V: 1] |:z4  |z4  |f2ec         |_ddcc        |
  w: Son que-sti~i cre-spi cri-ni~e
  w: Que-sti son gli~oc-chi che mi-
  [V: 2] |:c2BG|AAGc|(F/G/A/B/)c=A|B2AA         |
  w: Son que-sti~i cre-spi cri-ni~e que - - - - sto~il vi-so e
  w: Que-sti son~gli oc-chi che mi-ran - - - - do fi-so mi-
  [V: 3] |:z4  |f2ec|_ddcf        |(B/c/_d/e/)ff|
  w: Son que-sti~i cre-spi cri-ni~e que - - - - sto~il
  w: Que-sti son~gli oc-chi che mi-ran - - - - do
  % 5 - 9
  [V: 1] cAB2     |cAAA |c3B|G2!fermata!Gz ::e4|
  w: que-sto~il vi-so ond' io ri-man-go~uc-ci-so. Deh,
  w: ran-do fi-so, tut-to re-stai con-qui-so.
  [V: 2] AAG2     |AFFF |A3F|=E2!fermata!Ez::c4|
  w: que-sto~il vi-so ond' io ri-man-go~uc-ci-so. Deh,
  w: ran-do fi-so tut-to re-stai con-qui-so.
  [V: 3] (ag/f/e2)|A_ddd|A3B|c2!fermata!cz ::A4|
  w: vi - - - so ond' io ti-man-go~uc-ci-so. Deh,
  w: fi - - - so tut-to re-stai con-qui-so.
  % 10 - 15
  [V: 1] f_dec |B2c2|zAGF  |\
  w: dim-me-lo ben mi-o, che que-sto\
  =EFG2          |1F2z2:|2F8|] % more notes
  w: sol de-si-o_. % more lyrics
  [V: 2] ABGA  |G2AA|GF=EF |(GF3/2=E//D//E)|1F2z2:|2F8|]
  w: dim-me-lo ben mi-o, che que-sto sol de-si - - - - o_.
  [V: 3] _dBc>d|e2AF|=EFc_d|c4             |1F2z2:|2F8|]
  w: dim-me-lo ben mi-o, che que-sto sol de-si-o_.

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 14. Appendix =====

==== 14.1. General MIDI instruments ====

Standard General MIDI (GM) instrument numbers:

  Prog#   Instrument            Prog#    Instrument

   PIANO                           CHROMATIC PERCUSSION
  1    Acoustic Grand             9   Celesta
  2    Bright Acoustic           10   Glockenspiel
  3    Electric Grand            11   Music Box
  4    Honky-Tonk                12   Vibraphone
  5    Electric Piano 1          13   Marimba
  6    Electric Piano 2          14   Xylophone
  7    Harpsichord               15   Tubular Bells
  8    Clavinet                  16   Dulcimer

    ORGAN                          GUITAR
  17   Drawbar Organ             25   Nylon String Guitar
  18   Percussive Organ          26   Steel String Guitar
  19   Rock Organ                27   Electric Jazz Guitar
  20   Church Organ              28   Electric Clean Guitar
  21   Reed Organ                29   Electric Muted Guitar
  22   Accoridan                 30   Overdriven Guitar
  23   Harmonica                 31   Distortion Guitar
  24   Tango Accordian           32   Guitar Harmonics

    BASS                           SOLO STRINGS
  33   Acoustic Bass             41   Violin
  34   Electric Bass(finger)     42   Viola
  35   Electric Bass(pick)       43   Cello
  36   Fretless Bass             44   Contrabass
  37   Slap Bass 1               45   Tremolo Strings
  38   Slap Bass 2               46   Pizzicato Strings
  39   Synth Bass 1              47   Orchestral Strings
  40   Synth Bass 2              48   Timpani

    ENSEMBLE                       BRASS
  49   String Ensemble 1         57   Trumpet
  50   String Ensemble 2         58   Trombone
  51   SynthStrings 1            59   Tuba
  52   SynthStrings 2            60   Muted Trumpet
  53   Choir Aahs                61   French Horn
  54   Voice Oohs                62   Brass Section
  55   Synth Voice               63   SynthBrass 1
  56   Orchestra Hit             64   SynthBrass 2

    REED                           PIPE
  65   Soprano Sax               73   Piccolo
  66   Alto Sax                  74   Flute
  67   Tenor Sax                 75   Recorder
  68   Baritone Sax              76   Pan Flute
  69   Oboe                      77   Blown Bottle
  70   English Horn              78   Skakuhachi
  71   Bassoon                   79   Whistle
  72   Clarinet                  80   Ocarina

    SYNTH LEAD                     SYNTH PAD
  81   Lead 1 (square)           89   Pad 1 (new age)
  82   Lead 2 (sawtooth)         90   Pad 2 (warm)
  83   Lead 3 (calliope)         91   Pad 3 (polysynth)
  84   Lead 4 (chiff)            92   Pad 4 (choir)
  85   Lead 5 (charang)          93   Pad 5 (bowed)
  86   Lead 6 (voice)            94   Pad 6 (metallic)
  87   Lead 7 (fifths)           95   Pad 7 (halo)
  88   Lead 8 (bass+lead)        96   Pad 8 (sweep)

     SYNTH EFFECTS                  ETHNIC
   97  FX 1 (rain)               105   Sitar
   98  FX 2 (soundtrack)         106   Banjo
   99  FX 3 (crystal)            107   Shamisen
  100  FX 4 (atmosphere)         108   Koto
  101  FX 5 (brightness)         109   Kalimba
  102  FX 6 (goblins)            110   Bagpipe
  103  FX 7 (echoes)             111   Fiddle
  104  FX 8 (sci-fi)             112   Shanai

     PERCUSSIVE                     SOUND EFFECTS
  113  Tinkle Bell               121   Guitar Fret Noise
  114  Agogo                     122   Breath Noise
  115  Steel Drums               123   Seashore
  116  Woodblock                 124   Bird Tweet
  117  Taiko Drum                125   Telephone Ring
  118  Melodic Tom               126   Helicopter
  119  Synth Drum                127   Applause
  120  Reverse Cymbal            128   Gunshot

This list was taken from http://www.borg.com/~jglatt/tutr/gm.htm

Note that although the instruments are internally numbered from 0 - 127, the MIDI standard suggests that the user should select them with the numbers 1 - 128, since human beings count from 1 rather than 0.

==== 14.2. Full table of accented letters ====

Programs that have difficulty typesetting accented letters may reduce them to the base letter. ''\"y'' can be reduced to ''y'', ''\oA'' can be reduced to ''A'', etc. Ligatures can be reduced by simply ignoring the backslash: ''\ss'' becomes ''ss'', ''\AE'' becomes ''AE'', etc.

Here follows the full table of supported accents:

{{:abc:standard:symtab1.png}} {{:abc:standard:symtab2.png}} {{:abc:standard:symtab3.png}} {{:abc:standard:symtab4.png}}

The uppercase variants of accented letters can be obtained by simply putting the last letter in uppercase. Note that ''\.I'' produces an uppercase I with a dot on it. The uppercase variants of ligatures can be obtained by putting both letters in uppercase.

To get an actual backslash, type ''\\''.

The table is based on:

  * http://www.alanwood.net/unicode/latin_extended_a.html

==== 14.3. Undocumented features ====

Features which were discussed for inclusion in this document, but which are not described include:

  * Repeated tuplets
  * Octava indications
  * Optional accidentals/slurs
  * Microtonal accidentals
  * Tabulatures
  * Guitar chords diagrams
  * Gregorian chant

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>
./doc/abc_v2.1.txt	[[[1
2606
The abc music standard 2.1 (Dec 2011)

Contents



----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 1. Introduction =====

Abc is a text-based music notation system designed to be comprehensible by both people and computers. Music notated in abc is written using characters - letter, digits and punctuation marks - on paper or in computer files.

This description of abc has been created for those who wish to understand the notation, and for implementers of abc software applications. Some example tunes are included in [[#sample_abc_tunes|sample abc tunes]].

==== 1.1 How to read this document ====

Start at the beginning and work through to the end. Alternatively, for selected highlights, take a look at [[#how to avoid reading this document|how to avoid reading this document]].

=== 1.1.1 Terminology / definitions ===

Note that the following terms have specific meanings in the context of the abc standard. For convenience, each time one of these terms is used in the standard it is linked to the section in which it is defined:
  * [[#abc file definition|abc file]]
  * [[#abc fragment definition|abc fragment]]
  * [[#abc tune definition|abc tune]]
  * [[#abc tunebook definition|abc tunebook]]
  * [[#code line-break definition|code line-break]]
  * [[#comment definition|comment]]
  * [[#embedded definition|embedded]]
  * [[#empty line definition|empty line]]
  * [[#file header definition|file header]]
  * [[#free text definition|free text]]
  * [[#information field definition|information field]]
  * [[#inline field definition|inline field]]
  * [[#music code definition|music code]]
  * [[#score line-break definition|score line-break]]
  * [[#stylesheet directive definition|stylesheet directive]]
  * [[#text string definition|text string]]
  * [[#tune body definition|tune body]]
  * [[#tune header definition|tune header]]
  * [[#typeset text definition|typeset text]]

Please see also [[http://www.ietf.org/rfc/rfc2119.txt]] for formal definitions of the key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL.

Finally, the word // VOLATILE // is used to indicate sections which are under active discussion and/or likely to change in some future version of the standard.


==== 1.2 How to avoid reading this document ====

The abc standard contains a lot of information, much of which will not be immediately useful to the beginner. Apart from reading this section, [[#introduction|1. Introduction]], newcomers are recommended to familiarise themselves with all of [[#abc file structure|2.2 Abc file structure]], [[#information fields|3.0 Information fields]], a few subsections in [[#description of information fields|3.1 Description of information fields]] (in particular [[#xreference number|3.1.1]], [[#ttune title|3.1.2]], [[#mmeter|3.1.6]], [[#lunit note length|3.1.7]] and [[#kkey|3.1.14]]), [[#use of fields within the tune body|3.2 Use of fields within the tune body]], and as much of section [[#the tune body|4. The tune body]] as is desired (but in particular [[#pitch|4.1]], [[#note lengths|4.3]], [[#beams|4.7]], [[#repeat bar symbols|4.8]]).

Newcomers are also advised to take a look at section [[#sample abc tunes|13. Sample abc tunes]] and one of the [[#abc tutorials|abc tutorials]] that is available.

After that, it may depend on what you want to use abc for, but further reading suggestions would be:
  * [[#lyrics|5. Lyrics]] for transcribing songs
  * [[#typesetting|6.1 Typesetting]] for printing abc transcriptions in staff notation
  * [[#multiple voices|7. Multiple voices]] for working with multi-voice music

==== 1.3 Abc tutorials ====

This document is also best read in conjunction with an introduction to abc notation. Several are available - see, for example:

  * http://abcnotation.com/learn - a number of tutorials are linked from here
  * http://abcplus.sourceforge.net/#ABCGuide
  * http://www.lesession.co.uk/abc/abc_notation.htm
  * http://trillian.mit.edu/~jc/music/abc/doc/ABCtutorial.html

==== 1.4 Abc extensions ====

Since the abc notation system was originally written, a large number of abc software packages (programs which: produce printed sheet music; play or create audio files, usually MIDI; search or organise tune databases; or that analyse or manipulate tunes in some way) have been developed. However, not all of them follow this standard absolutely. This document aims at solving, or at least reducing, the problem of incompatibility between applications.

Nevertheless, when using abc it is good to be aware of the existence of such extensions. Extensions implemented by some major abc packages are described at the following links:

  * http://moinejf.free.fr/abcm2ps-features.txt - extensions implemented by [[http://abcnotation.com/software#abcm2ps|abcm2ps]]
  * http://abc.sourceforge.net/standard/abc2midi.txt - extensions implemented by [[http://abcnotation.com/software#abcMIDI|abc2midi]]
  * http://www.barfly.dial.pipex.com/bfextensions.html - extensions implemented by [[http://abcnotation.com/software#BarFly|BarFly]]
  * http://www.lautengesellschaft.de/cdmm/userguide/userguide.html - extensions implemented by [[http://abcnotation.com/software#abctab2ps|abctab2ps]]

==== 1.5 Further information and changes ====

Questions about this standard, or abc in general, can be addressed to the abcusers e-mail list, or the abcnotation forums:

  * http://groups.yahoo.com/group/abcusers/ (abcusers - subscriptions and archive of posts)
  * http://www.mail-archive.com/abcusers@argyll.wisemagic.com/ (abcusers - archive of old posts)
  * http://abcnotation.com/forums/

To propose changes to the standard, please read

  * http://abcnotation.com/wiki/abc:standard:route-map - a route map of proposed changes to the standard plus instructions for proposing changes
==== 1.6 Document locations ====

This document can be found at:

  * http://abcnotation.com/wiki/abc:standard:v2.1

The latest version of the standard, plus links to older versions and other developmental work, can always be found via:

  * http://abcnotation.com/wiki/abc:standard

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 2. Abc files, tunes and fragments =====

Tunes written in abc are normally stored in [[#abc file definition|abc files]], either on a computer's hard-drive or linked from a web-page. However, an increasing number are found on web-pages or in databases.

This section describes the basic structure of [[#abc file definition|abc files]] and [[#abc tune definition|abc tunes]], as well as a definition for including fragments of abc tunes elsewhere (e.g. web-pages).

==== 2.1 Abc file identification ====

All [[#abc file definition|abc files]] should have the extension ".abc" (all lower-case) on all platforms.

// Comment: // Some web-servers only allow a limited selection of file types; in this case a ".txt" extension is the best alternative.

Every [[#abc file definition|abc file]] should begin with the string ''%abc''. An optional version number may follow on the same line, e.g.
  %abc-2.1

Version numbers of 2.1 or higher indicate that the [[#abc file definition|abc file]] is to be [[#strict_interpretation|interpreted strictly]] according to the corresponding abc standard; if the version number is missing, the file will be treated under [[#loose_interpretation|loose interpretation]]. The [[#version field|version field]] may also be used to indicate abc versions for individual tunes.

// Note for developers: // Software should ignore the [[http://en.wikipedia.org/wiki/Byte_order_mark|byte order mark]] (BOM) if encountered as the first character of the file.

When an [[#abc file definition|abc file]] is included in a multi-part e-mail, its MIME type must be "text/vnd.abc" (see [[http://www.iana.org/assignments/media-types/text/vnd.abc|IANA text/vnd.abc]]).

==== 2.2 Abc file structure ====

<html><a name="abc_file_definition"></a></html>An **abc file** consists of one or more [[#abc tune definition|abc tune]] transcriptions, optionally interspersed with [[#free text definition|free text]] and [[#typeset text definition|typeset text]] annotations. It may optionally start with a [[#file header definition|file header]] to set up default values for processing the file.

The [[#file header definition|file header]], [[#abc tune definition|abc tunes]] and [[#free text and typeset text|text annotations]] are separated from each other by [[#empty line definition|empty lines]] (also known as blank lines).

<html><a name="abc_tunebook_definition"></a></html>An [[#abc file definition|abc file]] with more than one tune in it is called an **abc tunebook**.

=== 2.2.1 Abc tune ===

<html><a name="abc_tune_definition"></a></html>An **abc tune** itself consists of a [[#tune header definition|tune header]] and a [[#tune body definition|tune body]], terminated by an [[#empty line definition|empty line]] or the end of the [[#abc file definition|file]]. It may also contain [[#comment definition|comment lines]] or [[#stylesheet directive definition|stylesheet directives]].

<html><a name="tune_header_definition"></a></html>The **tune header** is composed of several [[#information field definition|information field]] lines, which are further discussed in [[#information fields|information fields]]. The [[#tune header definition|tune header]] should start with an ''X:''(reference number) field followed by a ''T:''(title) field and finish with a ''K:''(key) field. 

<html><a name="tune_body_definition"></a></html>The **tune body**, which contains the [[#music code definition|music code]], follows immediately after. Certain fields may also be used inside the tune body - see [[#use of fields within the tune body|use of fields within the tune body]].

It is legal to write an [[#abc tune definition|abc tune]] without a [[#tune body definition|tune body]]. This feature can be used to document tunes without transcribing them.

<html><a name="music_code_definition"></a></html>Abc **music code** lines are those lines in the [[#tune body definition|tune body]] which give notes, bar lines and other musical symbols - see [[#the tune body|the tune body]] for details. In effect, music code is the contents of any line which is not an [[#information field definition|information field]], [[#stylesheet directive definition|stylesheet directive]] or [[#comment definition|comment line]].

=== 2.2.2 File header ===

<html><a name="file_header_definition"></a></html>The file may optionally start with a **file header** (immediately after the version field), consisting of a block of consecutive [[#information field definition|information fields]], [[#stylesheet directive definition|stylesheet directives]], or both, terminated with an [[#empty line definition|empty line]]. The [[#file header definition|file header]] is used to set default values for the tunes in the file.

The [[#file header definition|file header]] may only appear at the beginning of a file, not between tunes.

Settings in a tune may override the [[#file header definition|file header]] settings, but when the end of a tune is reached the defaults set by the [[#file header definition|file header]] are reinstated.

Applications which extract separate tunes from a file must insert the fields of the original [[#file header definition|file header]] into the header of the extracted tune. However, since users may manually extract tunes without regard to the [[#file header definition|file header]], it is not recommended to use a [[#file header definition|file header]] in an [[#abc tunebook definition|abc tunebook]] that is to be distributed.

=== 2.2.3 Free text and typeset text ===

The terms [[#free text definition|free text]] and [[#typeset text definition|typeset text]] refer to any text not directly included within the [[#information field definition|information fields]] in a [[#tune header definition|tune header]]. Typically such text is used for annotating [[#abc tunebook definition|abc tunebooks]]; [[#free text definition|free text]] is for annotating the [[#abc file definition|abc file]] but is not included in the typeset score, whereas [[#typeset text definition|typeset text]] is intended for printing out.

<html><a name="free_text_definition"></a></html>**Free text** is just that. It can be included anywhere in an [[#abc file definition|abc file]], after the [[#file header definition|file header]], but must be separated from [[#abc tune definition|abc tunes]], [[#typeset text definition|typeset text]] and the [[#file header definition|file header]] by [[#empty line definition|empty lines]]. Typically it is used for annotating the [[#abc file definition|abc file]] but in principle can be any text not containing [[#information field definition|information fields]].

// Comment: // Since raw html markup and email headers are treated as [[#free text definition|free text]] (provided they don't inadvertently contain [[#information field definition|information fields]]) this means that abc software can process a wide variety of text-based input files just by ignoring non-abc code.

By default [[#free text definition|free text]] is not included in the printed score, although typesetting software may offer the option to print it out (e.g. via a command line switch or GUI checkbox). In this case, the software should treat the [[#free text definition|free text]] as a [[#text string definition|text string]], but may format it in any way it chooses.

<html><a name="typeset_text_definition"></a></html>**Typeset text** is any text specified using [[#text directives|text directives]]. It may be inserted anywhere in an [[#abc file definition|abc file]] after the [[#file header definition|file header]], either separated from tunes by [[#empty line definition|empty lines]], or included in the [[#tune header definition|tune header]] or [[#tune body definition|tune body]].

[[#typeset text definition|Typeset text]] should be printed by typesetting programs although its exact position in the printed score is program-dependent.

[[#typeset text definition|Typeset text]] that is included in an [[#abc tune definition|abc tune]] (i.e. within the [[#tune header definition|tune header]] or [[#tune body definition|tune body]]), must be retained by any programs, such as databasing software, that splits an [[#abc file definition|abc file]] into separate [[#abc tune definition|abc tunes]].

=== 2.2.4 Empty lines and line-breaking ===

<html><a name="empty_line_definition"></a></html>**Empty lines** (also known as blank lines) are used to separate [[#abc tune definition|abc tunes]], [[#free text definition|free text]] and the [[#file header definition|file header]]. They also aid the readability of [[#abc file definition|abc files]].

Lines that consist entirely of white-space (space and tab characters) are also regarded as [[#empty line definition|empty lines]].

Line-breaks (also known as new lines, line feeds, carriage returns, end-of-lines, etc.) can be used within an [[#abc file definition|abc file]] to aid readability and, if required, break up long input lines - see [[#continuation of input lines|continuation of input lines]].

More specifically, line-breaks in the [[#music code definition|music code]] can be used to structure the abc transcription and, by default, generate line-breaks in the printed music. For more details see [[#typesetting_line-breaks|typesetting line-breaks]].

=== 2.2.5 Comments and remarks ===

<html><a name="comment_definition"></a></html>A percent symbol (''%'') will cause the remainder of any input line to be ignored. It can be used to add a **comment** to the end of an abc line or as a **comment line** in its own right. (To get a percent symbol, type ''\%'' - see [[#text strings|text strings]].)

<html><a name="remark_definition"></a></html>Alternatively, you can use the syntax ''[r:remark]'' to write a **remark** in the middle of a line of music.

// Example: //
  |:DEF FED| % this is an end of line comment
  % this is a comment line
  DEF [r:and this is a remark] FED:|
  
Abc code which contains [[#comment definition|comments]] and remarks should be processed in exactly the same way as it would be if all the [[#comment definition|comments]] and [[#remark definition|remarks]] were removed (although, if the code is preprocessed, and [[#comment definition|comments]] are actually removed, the [[#stylesheet directive definition|stylesheet directives]] should be left in place).

Important clarification: lines which just contain a [[#comment definition|comment]] are processed as if the entire line were removed, even if the [[#comment definition|comment]] is preceded by white-space (i.e. the ''%'' symbol is the not first character). In other words, removing the [[#comment definition|comment]] effectively removes the entire line and so no [[#empty line definition|empty line]] is introduced.

=== 2.2.6 Continuation of input lines ===

It is sometimes necessary to tell abc software that an input line is continued on the next physical line(s) in the [[#abc file definition|abc file]], so that the two (or more) lines are treated as one. In abc 2.0 there was a universal continuation character (see [[#outdated continuations|outdated continuations]]) for this purpose, but it was decided that this was both unnecessary and confusing.

In abc 2.1, there are ways of continuing each of the 4 different input line types: [[#music code definition|music code]], [[#information field definition|information fields]], [[#comment definition|comments]] and [[#stylesheet directive definition|stylesheet directives]].

In abc [[#music code definition|music code]], by default, line-breaks in the code generate line-breaks in the typeset score and these can be suppressed by using a backslash (or by telling abc typesetting software to ignore line-breaks using ''I:linebreak $'' or ''I:linebreak <none>'') - see [[#typesetting line-breaks|typesetting line-breaks]] for full details.

// Comment for programmers: // The backslash effectively acts as a continuation character for [[#music code definition|music code]] lines, although, for those used to encountering it in other computer language contexts, its use is very abc-specific. In particular it can continue [[#music code definition|music code]] lines through [[#information field definition|information fields]], [[#comment definition|comments]] and [[#stylesheet directive definition|stylesheet directives]].

The 3 other input line types can be continued as follows:
  * [[#information field definition|information fields]] can be continued using ''+:'' at the start of the following line - see [[#field continuation|field continuation]];
  * [[#comment definition|comments]] can easily be continued by adding a ''%'' symbol at the start of the following line - since they are ignored by abc software it doesn't matter how many lines they are split into;
  * most [[#stylesheet directive definition|stylesheet directives]] are too short to require a continuation syntax, but if one is required then use the ''I:<directive>'' form (see ''[[#iinstruction|I:instruction]]''), in place of ''<nowiki>%%</nowiki><directive>'' and continue the line as a field - see [[#field continuation|field continuation]].

// Comment for developers: // Unlike other languages, and because of the way in which both [[#information field definition|information fields]] and [[#music code definition|music code]] can be continued through [[#comment definition|comments]], [[#stylesheet directive definition|stylesheet directives]] and (in the case of [[#music code definition|music code]]) [[#information field definition|information fields]], it is generally not possible to parse [[#abc file definition|abc files]] by pre-processing continuations into single lines.

Note that, with the exception of abc [[#music code definition|music code]], continuations are unlikely to be needed often. Indeed in most cases it should be possible, although not necessarily desirable, to write very long input lines, since most abc editing software will display them as wrapped within the text editor window.

// Recommendation: // Despite there being no limit on line length in [[#abc file definition|abc files]], it is recommended that users avoid writing abc code with very long lines. In particular, judiciously applied line-breaks can aid the (human) readability of abc code. More importantly, users who send [[#abc tune definition|abc tunes]] with long lines should be aware that email software sometimes introduces additional line-breaks into lines with more than 72 characters and these may even cause errors when the resulting tune is processed.


==== 2.3 Embedded abc and abc fragments ====

<html><a name="embedded_definition"></a></html>Traditionally abc has been used in dedicated [[#abc file definition|abc files]]. More recently, however, the possibility has arisen to include [[#abc tune definition|abc tunes]], and even fragments, within other document types. An abc element included within another document type is referred to as **embedded** in that document.

Often, although not always, some form of markup is used to indicate where the [[#embedded definition|embedded]] abc code starts and finishes.

// Example: // Within an html document a tune could be included as follows:

  <pre class="abc-tune">
  X:1
  T:Title
  K:C
  DEF FED:|
  </pre>

// Important note: // The abc standard makes no stipulation about //how// the abc code is included in the document. For example, in html it could be via a ''<pre>'', ''<div>'', ''<object>'', ''<script>'' or some other tag.

[[#embedded definition|Embedded]] abc elements can be one of four types:
  * an [[#abc fragment definition|abc fragment]]
  * an [[#abc tune definition|abc tune]]
  * a [[#file header definition|file header]]
  * an entire [[#abc file definition|abc file]]
In all cases, the type must be indicated to the abc parsing code which is going to process it (for example, via a ''class'' parameter). An exception is the [[#embedded definition|embedded]] [[#abc tune definition|abc tune]] where the parser may instead use the ''X:'' field to identify it.

The following rules are applied to [[#embedded definition|embedded]] elements:

=== 2.3.1 Embedded abc fragment ===

An <html><a name="abc_fragment_definition"></a></html>**abc fragment** is a partial [[#abc tune definition|abc tune]]. It may contain a partial [[#tune header definition|tune header]] with no body or a [[#tune body definition|tune body]] with optional [[#tune header definition|tune header]] [[#information field definition|information fields]].

// Example 1: // A fragment with no [[#tune header definition|tune header]]:

  <div class="abc-fragment">
  CDEF GABc|
  </div>

// Example 2: // A fragment with a partial [[#tune header definition|tune header]]:

  <div class="abc-fragment">
  T:Major scale in D
  K:D
  DEFG ABcd|
  </div>

Unless ''T:'', ''M:'' and ''K:'' fields are present, a fragment is assumed to describe a stave in the treble clef with no title, no meter indication and no key signature, respectively.

An [[#abc fragment definition|abc fragment]] does not require an [[#empty line definition|empty line]] to mark the end of the [[#tune body definition|tune body]] if it is terminated by the document markup.

// Note for developers: // For processing as an [[#abc tune definition|abc tune]], the parsing code is notionally assumed to add empty ''X:'', ''T:'' and ''K:'' fields, if these are missing. However, since the processing generally takes place internally within a software package, these need not be added in actuality.

=== 2.3.2 Embedded abc tune ===

An [[#embedded definition|embedded]] [[#abc tune definition|abc tune]] has the same structure as an ordinary [[#abc tune definition|abc tune]] except that it does not require an [[#empty line definition|empty line]] to mark the end of the [[#tune body definition|tune body]].

An [[#embedded definition|embedded]] [[#abc tune definition|abc tune]] could also be identified as an [[#abc fragment definition|abc fragment]] (albeit complete), if preferred.

=== 2.3.3 Embedded file header ===

As with the [[#file header definition|file header]], an [[#embedded definition|embedded]] [[#file header definition|file header]] can be used to set default values for all [[#embedded definition|embedded]] abc tunes and [[#abc fragment definition|abc fragments]] within the document.

// Example: // For setting the title font in every [[#abc tune definition|abc tune]] in the document:

  <div class="abc-file-header">
  %%titlefont Arial 10
  </div>

Like its counterpart, there must only be one [[#embedded definition|embedded]] [[#file header definition|file header]] per document and it should precede all other [[#embedded definition|embedded]] abc tunes and [[#abc fragment definition|abc fragments]]. 

=== 2.3.4 Embedded abc file ===

A document may include an entire [[#embedded definition|embedded]] [[#abc file definition|abc file]] with the usual structure - see [[#abc file structure|abc file structure]]. 

An [[#embedded definition|embedded]] [[#abc file definition|abc file]] should be treated independently from other [[#embedded definition|embedded]] elements so that settings in one [[#embedded definition|embedded]] [[#abc file definition|abc file]] do not affect other [[#embedded definition|embedded]] elements.

// Recommendation: // As a consequence, using other [[#embedded definition|embedded]] elements in a document that contains an [[#embedded definition|embedded]] [[#abc file definition|abc file]] is not recommended.

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 3. Information fields =====

<html><a name="information_field_definition"></a></html>Any line beginning with a letter in the range ''A-Z'' or ''a-z'' and immediately followed by a colon ('':'') is an **information field**. Information fields are used to notate things such as composer, meter, etc. In fact anything that isn't music.

An [[#information field definition|information field]] may also be inlined in a [[#tune body definition|tune body]] when enclosed by ''['' and '']'' - see [[#use_of_fields_within_the_tune_body|use of fields within the tune body]].

Many of these [[#information field definition|information field]] identifiers are currently unused so, in order to extend the number of [[#information field definition|information fields]] in the future, programs that comply with this standard must ignore the occurrence of [[#information field definition|information fields]] not defined here (although they should give a non-fatal error message to warn the user, in case the field identifier is an error or is unsupported).

Some [[#information field definition|information fields]] are permitted only in the file or [[#tune header definition|tune header]] and some only in the [[#tune body definition|tune body]], while others are allowed in both locations. [[#Information field definition|information field]] identifiers ''A-G'', ''X-Z'' and ''a-g'', ''x-z'' are not permitted in the body to avoid confusion with [[#pitch|note symbols]], [[#rests|rests]] and [[#typesetting extra space|spacers]].

Users who wish to use abc notation solely for transcribing (rather than documenting) tunes can ignore most of the [[#information field definition|information fields]]. For this purpose all that is really needed are the ''X:''(reference number), ''T:''(title), ''M:''(meter), ''L:''(unit note length) and ''K:''(key) [[#information field definition|information fields]], plus if applicable ''C:''(composer) and ''w:'' or ''W:'' (words/lyrics, respectively within or after the tune).

// Recommendation for newcomers: // A good way to find out how to use the fields is to look at the example files, [[#sample_abc_tunes|sample abc tunes]] (in particular [[#englishabc|English.abc]]), and try out some examples.

The [[#information field definition|information fields]] are summarised in the following table and discussed in [[#description of information fields|description of information fields]] and elsewhere.

The table illustrates how the [[#information field definition|information fields]] may be used in the [[#tune header definition|tune header]] and whether they may also be used in the [[#tune body definition|tune body]] (see [[#use_of_fields_within_the_tune_body|use of fields within the tune body]] for details) or in the [[#file header definition|file header]] (see [[#abc_file_structure|abc file structure]]).

Abc Fields and their usage:
^ Field name                                    ^ [[#file header definition|file header]] ^ [[#tune header definition|tune header]] ^ [[#tune body definition|tune body]]^[[#inline field definition|inline]]^ type        ^ Examples and notes ^
| [[#aarea|A:area]]                             | yes | yes    |     |      | string      | A:Donegal, A:Bampton ([[#outdated information field syntax|deprecated]]) |
| [[#bdfsbackground information|B:book]]        | yes | yes    |     |      | string      | B:O'Neills                                             |
| [[#ccomposer|C:composer]]                     | yes | yes    |     |      | string      | C:Robert Jones, C:Trad.                                |
| [[#bdfsbackground information|D:discography]] | yes | yes    |     |      | string      | D:Chieftains IV                                        |
| [[#bdfsbackground information|F:file url]]    | yes | yes    |     |      | string      | <nowiki>F:http://a.b.c/file.abc</nowiki>               |
| [[#ggroup|G:group]]                           | yes | yes    |     |      | string      | G:flute                                                |
| [[#hhistory|H:history]]                       | yes | yes    |     |      | string      | H:The story behind this tune ...                       |
| [[#iinstruction|I:instruction]]               | yes | yes    | yes | yes  | instruction | I:papersize A4, I:newpage                              |
| [[#kkey|K:key]]                               |     | last   | yes | yes  | instruction | K:G, K:Dm, K:AMix                                      |
| [[#lunit note length|L:unit note length]]     | yes | yes    | yes | yes  | instruction | L:1/4, L:1/8                                           |
| [[#mmeter|M:meter]]                           | yes | yes    | yes | yes  | instruction | M:3/4, M:4/4                                           |
| [[#macros|m:macro]]                           | yes | yes    | yes | yes  | instruction | m: ~G2 = {A}G{F}G                                      |
| [[#nnotes|N:notes]]                           | yes | yes    | yes | yes  | string      | N:see also O'Neills - 234                              |
| [[#oorigin|O:origin]]                         | yes | yes    |     |      | string      | O:UK; Yorkshire; Bradford                              |
| [[#pparts|P:parts]]                           |     | yes    | yes | yes  | instruction | P:A, P:ABAC, P:(A2B)3                                  |
| [[#qtempo|Q:tempo]]                           |     | yes    | yes | yes  | instruction | Q:"allegro" 1/4=120                                    |
| [[#rrhythm|R:rhythm]]                         | yes | yes    | yes | yes  | string      | R:R, R:reel                                            |
| [[#comments and remarks|r:remark]]            | yes | yes    | yes | yes  | -           | r:I love abc                                           |
| [[#bdfsbackground information|S:source]]      | yes | yes    |     |      | string      | S:collected in Brittany                                |
| [[#symbol_lines|s:symbol line]]               |     |        | yes |      | instruction | s: !pp! <nowiki>**</nowiki> !f!                        |
| [[#ttune title|T:tune title]]                 |     | second | yes |      | string      | T:Paddy O'Rafferty                                     |
| [[#redefinable_symbols|U:user defined]]       | yes | yes    | yes | yes  | instruction | U: T = !trill!                                         |
| [[#multiple_voices|V:voice]]                  |     | yes    | yes | yes  | instruction | V:4 clef=bass                                          |
| [[#lyrics|W:words]]                           |     | yes    | yes |      | string      | W:lyrics printed after the end of the tune             |
| [[#lyrics|w:words]]                           |     |        | yes |      | string      | w:lyrics printed aligned with the notes of a tune      |
| [[#xreference number|X:reference number]]     |     | first  |     |      | instruction | X:1, X:2                                               |
| [[#ztranscription|Z:transcription]]           | yes | yes    |     |      | string      | Z:John Smith, <nowiki><j.s@mail.com></nowiki>          |

Fields of type 'string' accept [[#text string definition|text strings]] as argument. Fields of type 'instruction' expect a special instruction syntax which will be detailed below. The contents of the remark field will be totally ignored.

== Repeated information fields ==

All [[#information field definition|information fields]], with the exception of ''X:'', may appear more than once in an [[#abc tune definition|abc tune]].

In the case of all string-type [[#information field definition|information fields]], repeated use in the [[#tune header definition|tune header]] can be regarded as additional information - for example, a tune may be known by many titles and an [[#abc tune definition|abc tune]] transcription may appear at more than one URL (using the ''F:'' field). Typesetting software which prints this information out may concatenate all string-type [[#information field definition|information fields]] of the same kind, separated by semi-colons ('';''), although the initial ''T:''(title) field should be treated differently, as should ''W:''(words) fields - see [[#typesetting information fields|typesetting information fields]].

Certain instruction-type [[#information field definition|information fields]], in particular ''I:'', ''m:'', ''U:'' and ''V:'', may also be used multiple times in the [[#tune header definition|tune header]] to set up different instructions, macros, user definitions and voices. However, if two such fields set up the same value, then the second overrides the first.

// Example: // The second ''I:linebreak'' instruction overrides the first.
  I:linebreak <EOL>
  I:linebreak <none>
  
// Comment: // The above example should not generate an error message. The user may legitimately wish to test the effect of two such instructions; having them both makes switching from one to another easy just by changing their order. 

Other instruction-type [[#information field definition|information fields]] in the [[#tune header definition|tune header]] also override the previous occurrence of that field.

Within the [[#tune body definition|tune body]] each line of code is processed in sequence. Therefore, with the exception of ''s:''(symbol line), ''w:''(words) and ''W:''(words) which have their own syntax, the same [[#information field definition|information field]] may occur a number of times, for example to change key, meter, tempo or voice, and each occurrence has the effect of overriding the previous one, either for the remainder of the tune, or until the next occurrence. See [[#use of fields within the tune body|use of fields within the tune body]] for more details.

== Order of information fields ==
  
// Recommendation for users: // Although [[#information field definition|information fields]] in the [[#tune header definition|tune header]] may be written in any order (subject to ''X:'', ''T:'' and ''K:'' coming first, second and last, respectively), it does make sense for users to stick to a common ordering, if for no other reason than it makes public domain abc code more readable. Typical ordering of the [[#tune header definition|tune header]] puts fundamental tune identification details first (X, T, C, O, R), with [[#information field definition|information fields]] relating to how the tune is played last (P, V, M, L, Q, K). Background information (B, D, F, G, H, N, S, Z) and information on how the abc code should be interpreted (I, m, U) then tends to appear in the middle of the [[#tune header definition|tune header]]. Words (W) may be included in the [[#tune header definition|tune header]] but are usually placed at the end of the [[#tune body|tune body]].

==== 3.1 Description of information fields ====

=== 3.1.1 X: - reference number ===

The ''X:'' (reference number) field is used to assign to each tune within a tunebook a unique reference number (a positive integer), for example: ''X:23''.

The ''X:'' field is also used to indicate the start of the tune (and hence the [[#tune header definition|tune header]]), so all tunes must start with an ''X:'' field and only one ''X:'' field is allowed per tune.

The ''X:'' field may be empty, although this is not recommended.

// Recommendation for developers: // Software which writes [[#abc file definition|abc files]] is recommended to offer users the possibility to manage ''X:'' field numbering automatically. GUI applications may even hide the ''X:'' field from users although they should always allow the user access to the raw [[#abc file definition|abc file]].

=== 3.1.2 T: - tune title ===

A ''T:'' (title) field must follow immediately after the ''X:'' field; it is the human identifier for the tune (although it may be empty).

Some tunes have more than one title and so this field can be used more than once per tune to indicate alternative titles.

The ''T:'' field can also be used within a tune to name parts of a tune - in this case it should come before any key or meter changes.

See [[#typesetting information fields|typesetting information fields]] for details of how the title and alternatives are included in the printed score.

=== 3.1.3 C: - composer ===

The ''C:'' field is used to indicate the composer(s).

See [[#typesetting information fields|typesetting information fields]] for details of how the composer is included in the printed score.

=== 3.1.4 O: - origin ===

The ''O:'' field indicates the geographical origin(s) of a tune.

If possible, enter the data in a hierarchical way, like:

  O:Canada; Nova Scotia; Halifax.
  O:England; Yorkshire; Bradford and Bingley.

// Recommendation: // It is recommended to always use a "'';''" (semi-colon) as the separator, so that software may parse the field. However, abc 2.0 recommended the use of a comma, so legacy files may not be parse-able under abc 2.1.

This field may be especially useful for traditional tunes with no known composer.

See [[#typesetting information fields|typesetting information fields]] for details of how the origin information is included in the printed score.

=== 3.1.5 A: - area ===

Historically, the ''A:'' field has been used to contain area information (more specific details of the tune origin). However this field is now [[#outdated syntax|deprecated]] and it is recommended that such information be included in the ''O:'' field.

=== 3.1.6 M: - meter ===

The ''M:'' field indicates the meter. Apart from standard meters, e.g. ''M:6/8'' or ''M:4/4'', the symbols ''M:C'' and ''M:C|'' give common time (4/4) and cut time (2/2) respectively. The symbol ''M:none'' omits the meter entirely (free meter).

It is also possible to specify a complex meter, e.g. ''M:(2+3+2)/8'', to make explicit which beats should be accented. The parentheses around the numerator are optional.

The example given will be typeset as:

  2 + 3 + 2
      8

When there is no ''M:'' field defined, free meter is assumed (in free meter, bar lines can be placed anywhere you want).

=== 3.1.7 L: - unit note length ===

The ''L:'' field specifies the unit note length - the length of a note as represented by a single letter in abc - see [[#note lengths|note lengths]] for more details.

Commonly used values for unit note length are ''L:1/4'' - quarter note (crotchet), ''L:1/8'' - eighth note (quaver) and ''L:1/16'' - sixteenth note (semi-quaver). ''L:1'' (whole note) - or equivalently ''L:1/1'', ''L:1/2'' (minim), ''L:1/32'' (demi-semi-quaver), ''L:1/64'', ''L:1/128'', ''L:1/256'' and ''L:1/512'' are also available, although ''L:1/64'' and shorter values are optional and may not be provided by all software packages.

If there is no ''L:'' field defined, a unit note length is set by default, based on the meter field ''M:''. This default is calculated by computing the meter as a decimal: if it is less than 0.75 the default unit note length is a sixteenth note; if it is 0.75 or greater, it is an eighth note. For example, 2/4 = 0.5, so, the default unit note length is a sixteenth note, while for 4/4 = 1.0, or 6/8 = 0.75, or 3/4= 0.75, it is an eighth note. For ''M:C'' (4/4), ''M:C|'' (2/2) and ''M:none'' (free meter), the default unit note length is 1/8.

A meter change within the body of the tune will not change the unit note length.

=== 3.1.8 Q: - tempo ===

The ''Q:'' field defines the tempo in terms of a number of beats per minute, e.g. ''Q:1/2=120'' means 120 half-note beats per minute.

There may be up to 4 beats in the definition, e.g:

  Q:1/4 3/8 1/4 3/8=40

This means: play the tune as if ''Q:5/4=40'' was written, but print the tempo indication using separate notes as specified by the user.

The tempo definition may be preceded or followed by an optional [[#text string definition|text string]], enclosed by quotes, e.g.

  Q: "Allegro" 1/4=120
  Q: 3/8=50 "Slowly"

It is OK to give a string without an explicit tempo indication, e.g. ''Q:"Andante"''.

Finally note that some previous ''Q:'' field syntax is now [[#outdated syntax|deprecated]] (see [[#outdated information field syntax|outdated information field syntax]]).

=== 3.1.9 P: - parts ===

// VOLATILE: // For music with more than one voice, interaction between the ''P:'' and ''V:'' fields will be clarified when multi-voice music is addressed in abc 2.2. The use of ''P:'' for single voice music will be revisited at the same time.

The ''P:'' field can be used in the [[#tune header definition|tune header]] to state the order in which the tune parts are played, i.e. ''P:ABABCDCD'', and then inside the [[#tune body definition|tune body]] to mark each part, i.e. ''P:A'' or ''P:B''. (In this context part refers to a section of the tune, rather than a voice in multi-voice music.)

Within the [[#tune header definition|tune header]], you can give instruction to repeat a part by following it with a number: e.g. ''P:A3'' is equivalent to ''P:AAA''. You can make a sequence repeat by using parentheses: e.g. ''P:(AB)3'' is equivalent to ''P:ABABAB''. Nested parentheses are permitted; dots may be placed anywhere within the header ''P:'' field to increase legibility: e.g. ''<nowiki>P:((AB)3.(CD)3)2</nowiki>''. These dots are ignored by computer programs.

See [[#variant_endings|variant endings]] and [[#lyrics|lyrics]] for possible uses of ''P:'' notation.

Player programs should use the ''P:'' field if possible to render a complete playback of the tune; typesetting programs should include the ''P:'' field values in the printed score.

See [[#typesetting information fields|typesetting information fields]] for details of how the part information may be included in the printed score.

=== 3.1.10 Z: - transcription ===

Typically the ''Z:'' field contains the name(s) of the person(s) who transcribed the tune into abc, and possibly some contact information, e.g. an (e-)mail address or homepage URL.

// Example: // Simple transcription notes.
  Z:John Smith, <j.s@mail.com>

However, it has also taken over the role of the ''<nowiki>%%</nowiki>abc-copyright'' and ''<nowiki>%%</nowiki>abc-edited-by'' since they have been [[#outdated syntax|deprecated]] (see [[#outdated directives|outdated directives]]).

// Example: // Detailed transcription notes.
  Z:abc-transcription John Smith, <j.s@mail.com>, 1st Jan 2010
  Z:abc-edited-by Fred Bloggs, <f.b@mail.com>, 31st Dec 2010
  Z:abc-copyright &copy; John Smith

This new usage means that an update history can be recorded in collections which are collaboratively edited by a number of users.

Note that there is no formal syntax for the contents of this field, although users are strongly encouraged to be consistent, but, by convention, ''Z:abc-copyright'' refers to the copyright of the abc transcription rather than the tune.

See [[#typesetting information fields|typesetting information fields]] for details of how the transcription information may be included in the printed score.

// Comment: // If required, software may even choose to interpret specific ''Z:'' strings, for example to print out the string which follows after ''Z:abc-copyright''.

=== 3.1.11 N: - notes ===

Contains general annotations, such as references to other tunes which are similar, details on how the original notation of the tune was converted to abc, etc.

See [[#typesetting information fields|typesetting information fields]] for details of how notes may be included in the printed score.

=== 3.1.12 G: - group ===

Database software may use this field to group together tunes (for example by instruments) for indexing purposes. It can also be used for creating medleys - however, this usage is not standardised.

=== 3.1.13 H: - history ===

Designed for multi-line notes, stories and anecdotes.

Although the ''H:'' fields are typically not typeset, the correct usage for multi-line input is to use [[#field continuation|field continuation]] syntax (''+:''), rather than ''H:'' at the start of each subsequent line of a multi-line note. This allows, for example, database applications to distinguish between two different anecdotes.

// Examples: //
  H:this is considered
  +:as a single entry

  H:this usage is considered as two entries
  H:rather than one

The original usage of ''H:'' (where subsequent lines need no field indicator) is now [[#outdated syntax|deprecated]] (see [[#outdated information field syntax|outdated information field syntax]]). 

See [[#typesetting information fields|typesetting information fields]] for details of how the history may be included in the printed score.

=== 3.1.14 K: - key ===

The key signature should be specified with a capital letter (''A-G'') which may be followed by a ''#'' or ''b'' for sharp or flat respectively. In addition the mode should be specified (when no mode is indicated, ''major'' is assumed).

For example, ''K:C major'', ''K:A minor'', ''K:C ionian'', ''K:A aeolian'', ''K:G mixolydian'', ''K:D dorian'', ''K:E phrygian'', ''K:F lydian'' and ''K:B locrian'' would all produce a staff with no sharps or flats. The spaces can be left out, capitalisation is ignored for the modes and in fact only the first three letters of each mode are parsed so that, for example, ''K:F# mixolydian'' is the same as ''K:F#Mix'' or even ''K:F#MIX''. As a special case, ''minor'' may be abbreviated to ''m''.

This table sums up how the same key signatures can be written in different ways:
^           Mode ^ Ionian ^ Aeolian ^ Mixolydian^ Dorian    ^ Phrygian  ^ Lydian    ^ Locrian   ^
^ Key Signature  ^ Major  ^ Minor   ^           ^           ^           ^           ^           ^
| 7 sharps       | ''C#'' | ''A#m'' | ''G#Mix'' | ''D#Dor'' | ''E#Phr'' | ''F#Lyd'' | ''B#Loc'' |
| 6 sharps       | ''F#'' | ''D#m'' | ''C#Mix'' | ''G#Dor'' | ''A#Phr'' | ''BLyd''  | ''E#Loc'' |
| 5 sharps       | ''B''  | ''G#m'' | ''F#Mix'' | ''C#Dor'' | ''D#Phr'' | ''ELyd''  | ''A#Loc'' |
| 4 sharps       | ''E''  | ''C#m'' | ''BMix''  | ''F#Dor'' | ''G#Phr'' | ''ALyd''  | ''D#Loc'' |
| 3 sharps       | ''A''  | ''F#m'' | ''EMix''  | ''BDor''  | ''C#Phr'' | ''DLyd''  | ''G#Loc'' |
| 2 sharps       | ''D''  | ''Bm''  | ''AMix''  | ''EDor''  | ''F#Phr'' | ''GLyd''  | ''C#Loc'' |
| 1 sharp        | ''G''  | ''Em''  | ''DMix''  | ''ADor''  | ''BPhr''  | ''CLyd''  | ''F#Loc'' |
| 0 sharps/flats | ''C''  | ''Am''  | ''GMix''  | ''DDor''  | ''EPhr''  | ''FLyd''  | ''BLoc''  |
| 1 flat         | ''F''  | ''Dm''  | ''CMix''  | ''GDor''  | ''APhr''  | ''BbLyd'' | ''ELoc''  |
| 2 flats        | ''Bb'' | ''Gm''  | ''FMix''  | ''CDor''  | ''DPhr''  | ''EbLyd'' | ''ALoc''  |
| 3 flats        | ''Eb'' | ''Cm''  | ''BbMix'' | ''FDor''  | ''GPhr''  | ''AbLyd'' | ''DLoc''  |
| 4 flats        | ''Ab'' | ''Fm''  | ''EbMix'' | ''BbDor'' | ''CPhr''  | ''DbLyd'' | ''GLoc''  |
| 5 flats        | ''Db'' | ''Bbm'' | ''AbMix'' | ''EbDor'' | ''FPhr''  | ''GbLyd'' | ''CLoc''  |
| 6 flats        | ''Gb'' | ''Ebm'' | ''DbMix'' | ''AbDor'' | ''BbPhr'' | ''CbLyd'' | ''FLoc''  |
| 7 flats        | ''Cb'' | ''Abm'' | ''GbMix'' | ''DbDor'' | ''EbPhr'' | ''FbLyd'' | ''BbLoc'' |

By specifying an empty ''K:'' field, or ''K:none'', it is possible to use no key signature at all.

The key signatures may be //modified// by adding [[#accidentals|accidentals]], according to the format ''K:<tonic> <mode> <accidentals>''. For example, ''K:D Phr ^f'' would give a key signature with two flats and one sharp, which designates a very common mode in Klezmer (Ahavoh Rabboh) and in Arabic music (Maqam Hedjaz). Likewise, "''K:D maj =c''" or "''K:D =c''" will give a key signature with F sharp and c natural (the D mixolydian mode). Note that there can be several modifying accidentals, separated by spaces, each beginning with an accidental sign (''<nowiki>__</nowiki>'', ''_'', ''='', ''^'' or ''<nowiki>^^</nowiki>''), followed by a note letter. The case of the letter is used to determine on which line the accidental is placed.

It is possible to use the format ''K:<tonic> exp <accidentals>'' to explicitly define all the accidentals of a key signature. Thus ''K:D Phr ^f'' could also be notated as ''K:D exp _b _e ^f'', where 'exp' is an abbreviation of 'explicit'. Again, the case of the letter is used to determine on which line the accidental is placed.

Software that does not support explicit key signatures should mark the individual notes in the tune with the accidentals that apply to them.

Scottish highland pipes typically have the scale ''G A B ^c d e ^f g a'' and highland pipe music primarily uses the modes D major and A mixolyian (plus B minor and E dorian). Therefore there are two additional keys specifically for notating highland bagpipe tunes; ''K:HP'' doesn't put a key signature on the music, as is common with many tune books of this music, while ''K:Hp'' marks the stave with F sharp, C sharp and G natural. Both force all the beams and stems of normal notes to go downwards, and of grace notes to go upwards.

By default, the [[#abc tune definition|abc tune]] will be typeset with a treble clef. You can add special clef specifiers to the ''K:'' field, with or without a key signature, to change the clef and various other staff properties, such as transposition. ''K: clef=bass'', for example, would indicate the bass clef. See [[#clefs and transposition|clefs and transposition]] for full details.

Note that the first occurrence of the ''K:'' field, which must appear in every tune, finishes the [[#tune header definition|tune header]]. All following lines are considered to be part of the [[#tune body definition|tune body]].

=== 3.1.15 R: - rhythm ===

Contains an indication of the type of tune (e.g. hornpipe, double jig, single jig, 48-bar polka, etc). This gives the musician some indication of how a tune should be interpreted as well as being useful for database applications (see [[#bdfsbackground information|background information]]). It has also been used experimentally by playback software (in particular, [[http://abcnotation.com/software#abcmus|abcmus]]) to provide more realistic playback by altering the stress on particular notes within a bar.

See [[#typesetting information fields|typesetting information fields]] for details of how the rhythm may be included in the printed score.

=== 3.1.16 B:, D:, F:, S: - background information ===

The [[#information field definition|information fields]] ''B:book'' (i.e. printed tune book), ''D:discography'' (i.e. a CD or LP where the tune can be heard), ''F:file url'' (i.e. where the either the [[#abc tune definition|abc tune]] or the [[#abc file definition|abc file]] can be found on the web) and ''S:source'' (i.e. the circumstances under which a tune was collected or learned), as well as the fields ''[[#hhistory|H:history]]'', ''[[#nnotes|N:notes]]'', ''[[#oorigin|O:origin]]'' and ''[[#rrhythm|R:rhythm]]'' mentioned above, are used for providing structured background information about a tune. These are particularly aimed at large tune collections (common in abc since its inception) and, if used in a systematic way, mean that abc database software can sort, search and filter on specific fields (for example, to sort by rhythm or filter out all the tunes on a particular CD).

The abc standard does not prescribe how these fields should be used, but it is typical to employ several fields of the same type each containing one piece of information, rather than one field containing several pieces of information (see [[#englishabc|English.abc]] for some examples).

See [[#typesetting information fields|typesetting information fields]] for details of how background information may be included in the printed score.

=== 3.1.17 I: - instruction ===

The ''I:''(instruction) field is used for an extended set of instruction directives concerned with how the abc code is to be interpreted.

The ''I:'' field can be used interchangeably with [[#stylesheet directive definition|stylesheet directives]] so that any ''I:directive'' may instead be written ''<nowiki>%%</nowiki>directive'', and vice-versa. However, to use the [[#use of fields within the tune body|inline]] version, the ''I:'' version must be used.

Despite this interchangeability, certain directives have been adopted as part of the standard (indicated by ''I:'' in this document) and must be implemented by software confirming to this version of the standard; conversely, the [[#stylesheet directive definition|stylesheet directives]] (indicated by ''<nowiki>%%</nowiki>'' in this document) are optional.

// Comment: // Since [[#stylesheet directive definition|stylesheet directives]] are optional, and not necessarily portable from one program to another, this means that ''I:'' fields containing [[#stylesheet directive definition|stylesheet directives]] should be treated liberally by abc software and, in particular, that ''I:'' fields which are not recognised should be ignored.

The following table contains a list of the ''I:'' field directives adopted as part of the abc standard, with links to further information:
^ directive           ^ section                                              ^
| ''I:abc-charset''   | [[#charset field|charset field]]                     |
| ''I:abc-version''   | [[#version field|version field]]                     |
| ''I:abc-include''   | [[#include field|include field]]                     |
| ''I:abc-creator''   | [[#creator field|creator field]]                     |
| ''I:linebreak''     | [[#typesetting line-breaks|typesetting line breaks]] |
| ''I:decoration''    | [[#decoration dialects|decoration dialects]]         |

Typically, instruction fields are for use in the [[#file header definition|file header]], to set defaults for the file, or (in most cases) in the [[#tune header definition|tune header]], but not in the [[#tune body definition|tune body]]. The occurrence of an instruction field in a [[#tune header definition|tune header]] overrides that in the [[#file header definition|file header]].

// Comment: // Remember that abc software which extracts separate tunes from a file must insert the fields of the original [[#file header definition|file header]] into the header of the extracted tune: this is also true for the fields defined in this section.

== Charset field ==

The ''I:abc-charset <value>'' field indicates the character set in which [[#text string definition|text strings]] are coded. Since this affects how the file is read, it should appear as early as possible in the [[#file header definition|file header]]. It may not be changed further on in the file.

// Example: //
  I:abc-charset utf-8

Legal values for the charset field are ''iso-8859-1'' through to ''iso-8859-10'', ''us-ascii'' and ''utf-8'' (the default).

Software that exports [[#abc tune definition|abc tunes]] conforming to this standard should include a charset field if an encoding other than ''utf-8'' is used. All conforming abc software must be able to handle [[#text string definition|text strings]] coded in ''utf-8'' and ''us-ascii''. Support for the other charsets is optional.

Extensive information about [[http://en.wikipedia.org/wiki/UTF-8|UTF-8]] and [[http://en.wikipedia.org/wiki/ISO/IEC_8859|ISO-8859]] can be found on wikipedia.

== Version field ==

Every [[#abc file definition|abc file]] conforming to this standard should start with the line
  %abc-2.1
(see [[#abc file identification|abc file identification]]).

However to indicate tunes conforming to a different standard it is possible to use the ''I:abc-version <value>'' field, either in the [[#tune header definition|tune header]] (for individual tunes) or in the [[#file header definition|file header]].

// Example: //
  I:abc-version 2.0

== Include field ==

The ''I:abc-include <filename.abh>'' imports the definitions found in a separate abc header file (.abh), and inserts them into the [[#file header definition|file header]] or [[#tune header definition|tune header]].

// Example: //
  I:abc-include mydefs.abh

The included file may contain [[#information field definition|information fields]], [[#stylesheet directive definition|stylesheet directives]] and [[#comments and remarks|comments]], but no other abc constructs.

If the header file cannot be found, the ''I:abc-include'' instruction should be ignored with a non-fatal error message.

// Comment: // If you use this construct and distribute your [[#abc file definition|abc files]], make sure that you distribute the .abh files with them.

== Creator field ==

The ''I:abc-creator <value>'' field contains the name and version number of the program that created the [[#abc file definition|abc file]].

// Example: //
  I:abc-creator xml2abc-2.7

Software that exports [[#abc tune definition|abc tunes]] conforming to this standard must include a creator field.

=== 3.1.18 Other fields ===

  * For ''m:'' see [[#macros|macros]].
  * For ''r:'' see [[#comments and remarks|comments and remarks]].
  * For ''s:'' see [[#symbol_lines|symbol lines]].
  * For ''U:'' see [[#redefinable_symbols|redefinable symbols]]. 
  * For ''V:'' see [[#multiple_voices|multiple voices]].
  * For ''W:'' and ''w:'' see [[#lyrics|lyrics]].

==== 3.2 Use of fields within the tune body ====

<html><a name="inline_field_definition"></a></html>It is often desired to change the key (''K''), meter (''M''), or unit note length (''L'') mid-tune. These, and most other [[#information field definition|information fields]] which can be legally used within the [[#tune body definition|tune body]], can be specified as an **inline field** by placing them within square brackets in a line of music

// Example: // The following two excerpts are considered equivalent - either variant is equally acceptable.
  E2E EFE|E2E EFG|[M:9/8] A2G F2E D2|]

  E2E EFE|E2E EFG|\
  M:9/8
  A2G F2E D2|]

The first bracket, field identifier and colon must be written without intervening spaces. Only one field may be placed within a pair of brackets; however, multiple bracketed fields may be placed next to each other. Where appropriate, [[#inline field definition|inline fields]] (especially clef changes) can be used in the middle of a beam without breaking it.

See [[#information fields|information fields]] for a table showing the fields that may appear within the body and those that may be used inline.

==== 3.3 Field continuation ====

A field that is too long for one line may be continued by prefixing ''+:'' at the start of the following line. For string-type [[#information field definition|information fields]] (see the [[#information fields|information fields]] table for a list of string-type fields), the continuation is considered to add a space between the two half lines.

// Example: // The following two excerpts are considered equivalent. 
  w:Sa-ys my au-l' wan to your aul' wan,
  +:will~ye come to the Wa-x-ies dar-gle?

  w:Sa-ys my au-l' wan to your aul' wan, will~ye come to the Wa-x-ies dar-gle?
  
// Comment: // This is most useful for continuing long ''w:(aligned lyrics)'' and ''H:(history)'' fields. However, it can also be useful for preventing automatic wrapping by email software (see [[#continuation of input lines|continuation of input lines]]).

// Recommendation for GUI developers: // Sometimes users may wish to paste paragraphs of text into an [[#abc file definition|abc file]], particularly in the ''H:(history)'' field. GUI developers are recommended to provide tools for reformatting such paragraphs, for example by splitting them into several lines each prefixed by ''+:''.

There is no limit to the number of times a field may be continued and [[#comments and remarks|comments]] and [[#stylesheet directive definition|stylesheet directives]] may be interspersed between the continuations.

// Example: // The following is a legal continuation of the ''w:'' field, although the usage not recommended (the change of font could also be achieved by font specifiers - see [[#font directives|font directives]]).
  %%vocalfont Times-Roman 14
  w:nor-mal
  % legal, but not recommended
  %%vocalfont Times-Italic *
  +:i-ta-lic
  %%vocalfont Times-Roman *
  +:nor-mal

// Comment: // abc standard 2.3 is scheduled to address markup and will be seeking a more elegant way to achieve the above.

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 4. The tune body =====

==== 4.1 Pitch ====

The following letters are used to represent notes using the treble clef:

{{:abc:standard:pitches.0000.png}}

and by extension other lower and higher notes are available.

Lower octaves are reached by using commas and higher octaves are written using apostrophes; each extra comma/apostrophe lowers/raises the note by an octave.

Programs should be able to to parse any combinations of '','' and ''<nowiki>'</nowiki>'' signs appearing after the note. For example ''C,','' (C comma apostrophe comma) has the the same meaning as ''C,'' (C comma) and (uppercase) ''<nowiki>C'</nowiki>'' (C apostrophe) should have the same meaning as (lowercase) ''c''.

Alternatively, it is possible to raise or lower a section of [[#music code definition|music code]] using the ''octave'' parameter of the ''K:'' or ''V:'' fields.

// Comment: // The English note names ''C''-''B'', which are used in the abc system, correspond to the note names ''do''-''si'', which are used in many other languages: ''do''=''C'', ''re''=''D'', ''mi''=''E'', ''fa''=''F'', ''sol''=''G'', ''la''=''A'', ''si''=''B''.

==== 4.2 Accidentals ====

The symbols ''^'', ''='' and ''_'' are used (before a note) to notate respectively a sharp, natural or flat. Double sharps and flats are available with ''<nowiki>^^</nowiki>'' and ''<nowiki>__</nowiki>'' respectively.

==== 4.3 Note lengths ====

//Throughout this document note lengths are referred as sixteenth, eighth, etc. The equivalents common in the U.K. are sixteenth note = semi-quaver, eighth = quaver, quarter = crotchet and half = minim.//

The [[#lunit_note_length|unit note length]] for the transcription is set in the ''L:'' field or, if the ''L:'' field does not exist, inferred from the ''M:'' field. For example, ''L:1/8'' sets an eighth note as the unit note length.

A single letter in the range ''A-G'', ''a-g'' then represents a note of this length. For example, if the unit note length is an eighth note, ''DEF'' represents 3 eighth notes.

Notes of differing lengths can be obtained by simply putting a multiplier after the letter. Thus if the unit note length is 1/16, ''A'' or ''A1'' is a sixteenth note, ''A2'' an eighth note, ''A3'' a dotted eighth note, ''A4'' a quarter note, ''A6'' a dotted quarter note, ''A7'' a double dotted quarter note, ''A8'' a half note, ''A12'' a dotted half note, ''A14'' a double dotted half note, ''A15'' a triple dotted half note and so on. If the unit note length is ''1/8'', ''A'' is an eighth note, ''A2'' a quarter note, ''A3'' a dotted quarter note, ''A4'' a half note, and so on.

To get shorter notes, either divide them - e.g. if ''A'' is an eighth note, ''A/2'' is a sixteenth note, ''A3/2'' is a dotted eighth note, ''A/4'' is a thirty-second note - or change the [[#lunit_note_length|unit note length]] with the ''L:'' field. Alternatively, if the music has a broken rhythm, e.g. dotted eighth note/sixteenth note pairs, use [[#broken_rhythm|broken rhythm]] markers.

Note that ''A/'' is shorthand for ''A/2'' and similarly ''<nowiki>A//</nowiki>'' = ''A/4'', etc.

// Comment: // Note lengths that can't be translated to conventional staff notation are legal, but their representation by abc typesetting software is undefined and they should be avoided.

// Note for developers: // All compliant software should be able to handle note lengths down to a 128th note; shorter lengths are optional.

==== 4.4 Broken rhythm ====

A common occurrence in traditional music is the use of a dotted or broken rhythm. For example, hornpipes, strathspeys and certain morris jigs all have dotted eighth notes followed by sixteenth notes, as well as vice-versa in the case of strathspeys. To support this, abc notation uses a ''>'' to mean 'the previous note is dotted, the next note halved' and ''<'' to mean 'the previous note is halved, the next dotted'.

// Example: // The following lines all mean the same thing (the third version is recommended):
  L:1/16
  a3b cd3 a2b2c2d2

  L:1/8
  a3/2b/2 c/2d3/2 abcd

  L:1/8
  a>b c<d abcd

{{:abc:standard:broken-80.png}}

As a logical extension, ''<nowiki>>></nowiki>'' means that the first note is double dotted and the second quartered and ''<nowiki>>>></nowiki>'' means that the first note is triple dotted and the length of the second divided by eight. Similarly for ''<nowiki><<</nowiki>'' and ''<nowiki><<<</nowiki>''.

Note that the use of broken rhythm markers between notes of unequal lengths will produce undefined results, and should be avoided.

==== 4.5 Rests ====

Rests can be transcribed with a ''z'' or an ''x'' and can be modified in length in exactly the same way as normal notes. ''z'' rests are printed in the resulting sheet music, while ''x'' rests are invisible, that is, not shown in the printed music.

Multi-measure rests are notated using ''Z'' (upper case) followed by the number of measures.

// Example: // The following excerpts, shown with the typeset results, are musically equivalent (although they are typeset differently).

  Z4|CD EF|GA Bc
{{:abc:standard:rests1-80.png}}

  z4|z4|z4|z4|CD EF|GA Bc
{{:abc:standard:rests2-80.png}}

When the number of measures is not given, ''Z'' is equivalent to a pause of one measure.

By extension multi-measure invisible rests are notated using ''X'' (upper case) followed by the number of measures and when the number of measures is not given, ''X'' is equivalent to a pause of one measure.

// Comment: // Although not particularly valuable, a multi-measure invisible rest could be useful when a voice is silent for several measures.

==== 4.6 Clefs and transposition ====

// VOLATILE: // This section is subject to some clarifications with regard to transposition, rules for the ''middle'' parameter and interactions between different parameters.

Clef and transposition information may be provided in the ''K:'' [[#kkey|key]] and ''V:'' [[#multiple voices|voice]] fields. The general syntax is:

  [clef=]<clef name>[<line number>][+8 | -8] [middle=<pitch>] [transpose=<semitones>] [octave=<number>] [stafflines=<lines>]
  
(where ''<...>'' denotes a value, ''[...]'' denotes an optional parameter, and ''|'' separates alternative values).

  * ''<clef name>'' - may be ''treble'', ''alto'', ''tenor'', ''bass'', ''perc'' or ''none''. ''perc'' selects the drum clef. ''clef='' may be omitted.
  * ''[<line number>]'' - indicates on which staff line the base clef is written. Defaults are: treble: ''2''; alto: ''3''; tenor: ''4''; bass: ''4''.
  * ''[+8 | -8]'' - draws '8' above or below the staff. The player will transpose the notes one octave higher or lower.
  * ''[middle=<pitch>]'' - is an alternate way to define the line number of the clef. The pitch indicates what note is displayed on the 3rd line of the staff. Defaults are: treble: ''B''; alto: ''C''; tenor: ''A,''; bass: ''D,''; none: ''B''.
  * ''[transpose=<semitones>]'' - for playback, transpose the current voice by the indicated amount of semitones; positive numbers transpose up, negative down. This setting does not affect the printed score. The default is 0.
  * ''[octave=<number>]'' to raise (positive number) or lower (negative number) the [[#music code definition|music code]] in the current voice by one or more octaves. This usage can help to avoid the need to write lots of apostrophes or commas to raise or lower notes.
  * ''[stafflines=<lines>]'' - the number of lines in the staff. The default is 5.

Note that the ''clef'', ''middle'', ''transpose'', ''octave'' and ''stafflines'' specifiers may be used independent of each other.

// Examples: //
  K:   clef=alto
  K:   perc stafflines=1
  K:Am transpose=-2
  V:B  middle=d bass

Note that although this standard supports the drum clef, there is currently no support for special percussion notes.

The middle specifier can be handy when working in the bass clef. Setting ''K:bass middle=d'' will save you from adding comma specifiers to the notes. The specifier may be abbreviated to ''m=''.

The transpose specifier is useful, for example, for a Bb clarinet, for which the music is written in the key of C although the instrument plays it in the key of Bb:
  V:Clarinet
  K:C transpose=-2

The transpose specifier may be abbreviated to ''t=''.

To notate the various standard clefs, one can use the following specifiers:

The seven clefs
^ Name ^ specifier ^
| Treble | ''K:treble'' |
| Bass | ''K:bass'' |
| Baritone | ''K:bass3'' |
| Tenor | ''K:tenor'' |
| Alto | ''K:alto'' |
| Mezzosoprano | ''K:alto2'' |
| Soprano | ''K:alto1'' |

More clef names may be allowed in the future, therefore unknown names should be ignored. If the clef is unknown or not specified, the default is treble.

Applications may introduce their own clef line specifiers. These specifiers should start with the name of the application, followed a colon, followed by the name of the specifier.

// Example: //
  V:p1 perc stafflines=3 m=C  mozart:noteC=snare-drum

==== 4.7 Beams ====

To group notes together under one beam they must be grouped together without spaces. Thus in 2/4, ''A2BC'' will produce an eighth note followed by two sixteenth notes under one beam whilst ''A2 B C'' will produce the same notes separated. The beam slopes and the choice of upper or lower stems are typeset automatically.

Notes that cannot be beamed may be placed next to each other. For example, if ''L:1/8'' then ''ABC2DE'' is equivalent to ''AB C2 DE''.

Back quotes ''`'' may be used freely between notes to be beamed, to increase legibility. They are ignored by computer programs. For example, ''A2``B``C'' is equivalent to ''A2BC''.

==== 4.8 Repeat/bar symbols ====

Bar line symbols are notated as follows:

^ **Symbol** ^ **Meaning** ^
| ''|''  | bar line                             |
| ''|]'' | thin-thick double bar line           |
| ''||'' | thin-thin double bar line            |
| ''[|'' | thick-thin double bar line           |
| ''|:'' | start of repeated section            |
| '':|'' | end of repeated section              |
| ''::'' | start & end of two repeated sections |

// Recommendation for developers: // If an 'end of repeated section' is found without a previous 'start of repeated section', playback programs should restart the music from the beginning of the tune, or from the latest double bar line or end of repeated section.

Note that the notation ''::'' is short for '':|'' followed by ''|:''. The variants ''::'', '':|:'' and '':||:'' are all equivalent.

By extension, ''|::'' and ''::|'' mean the start and end of a section that is to be repeated three times, and so on.

A dotted bar line can be notated by preceding it with a dot, e.g. ''.|'' - this may be useful for notating editorial bar lines in music with very long measures.

An invisible bar line may be notated by putting the bar line in brackets, e.g. ''[|]'' - this may be useful for notating [[#voice_overlay|voice overlay]] in meter-free music.

Abc parsers should be quite liberal in recognizing bar lines. In the wild, bar lines may have any shape, using a sequence of ''|'' (thin bar line), ''['' or '']'' (thick bar line), and '':'' (dots), e.g. ''|[|'' or ''[|:::'' .

==== 4.9 First and second repeats ====

First and second repeats can be notated with the symbols ''[1'' and ''[2'', e.g.

  faf gfe|[1 dfe dBA:|[2 d2e dcB|].

When adjacent to bar lines, these can be shortened to '' |1'' and '':|2'', but with regard to spaces

  | [1

is legal, while

  | 1

is not.

Thus, a tune with different ending for the first and second repeats has the general form:

  |:  <common body of tune>  |1  <first ending>  :|2  <second ending>  |]

Note that in many [[#abc file definition|abc files]] the ''|:'' may not be present.

==== 4.10 Variant endings ====

In combination with ''P:'' [[#pparts|part notation]], it is possible to notate more than two variant endings for a section that is to be repeated a number of times.

For example, if the header of the tune contains ''P:A4.B4'' then parts A and B will each be played 4 times. To play a different ending each time, you could write in the tune:

  P:A
  <notes> | [1  <notes>  :| [2 <notes> :| [3 <notes> :| [4 <notes> |]

The Nth ending starts with ''[N'' and ends with one of ''||'', '':|'' ''|]'' or ''[|''. You can also mark a section as being used for more than one ending e.g.

  [1,3 <notes> :|

plays on the 1st and 3rd endings and

  [1-3 <notes> :|

plays on endings 1, 2 and 3. In general, '[' can be followed by any list of numbers and ranges as long as it contains no spaces e.g.

  [1,3,5-7  <notes>  :| [2,4,8 <notes> :|

==== 4.11 Ties and slurs ====

You can tie two notes of the same pitch together, within or between bars, with a ''-'' symbol, e.g. ''abc-|cba'' or ''c4-c4''. The tie symbol must always be adjacent to the first note of the pair, but does not need to be adjacent to the second, e.g. ''c4 -c4'' and ''abc|-cba'' are not legal - see [[#order of abc constructs|order of abc constructs]].

More general slurs can be put in with ''()'' symbols. Thus ''(DEFG)'' puts a slur over the four notes. Spaces within a slur are OK, e.g. '' ( D E F G ) ''.

Slurs may be nested:

  (c (d e f) g a)

{{:abc:standard:slur1-80.png}}

and they may also start and end on the same note:

  (c d (e) f g a)

{{:abc:standard:slur2-80.png}}

A dotted slur may be notated by preceding the opening brace with a dot, e.g. ''.(cde)''; it is optional to place a dot immediately before the closing brace. Likewise, a dotted tie can be transcribed by preceding it with a dot, e.g. ''C.-C''. This is especially useful in parts with multiple verses: some verses may require a slur, some may not.

It should be noted that although the tie ''-'' and slur ''()'' produce similar symbols in staff notation they have completely different meanings to player programs and should not be interchanged. Ties connect two successive notes //of the same pitch//, causing them to be played as a single note, while slurs connect the first and last note of any series of notes, and may be used to indicate phrasing, or that the group should be played legato. Both ties and slurs may be used into, out of and between chords, and in this case the distinction between them is particularly important.

==== 4.12 Grace notes ====

Grace notes can be written by enclosing them in curly braces, ''{}''. For example, a taorluath on the Highland pipes would be written ''{GdGe}''. The tune 'Athol Brose' (in the file [[#strspysabc|Strspys.abc]]) has an example of complex Highland pipe gracing in all its glory. Although nominally grace notes have no melodic time value, expressions such as ''{a3/2b/}'' or ''{a>b}'' can be useful and are legal although some software may ignore them. The unit duration to use for gracenotes is not specified by the [[#abc file definition|abc file]], but by the software, and might be a specific amount of time (for playback purposes) or a note length (e.g. 1/32 for Highland pipe music, which would allow ''{ge4d}'' to code a piobaireachd 'cadence').

To distinguish between appoggiaturas and acciaccaturas, the latter are notated with a forward slash immediately following the open brace, e.g. ''{/g}C'' or ''{/gagab}C'':

{{:abc:standard:graces-80.png}}

The presence of gracenotes is transparent to the broken rhythm construct. Thus the forms ''A<{g}A'' and ''A{g}<A'' are legal and equivalent to ''A/2{g}A3/2''.

==== 4.13 Duplets, triplets, quadruplets, etc. ====

These can be simply coded with the notation ''(2ab'' for a duplet, ''(3abc'' for a triplet or ''(4abcd'' for a quadruplet, etc, up to ''(9''. The musical meanings are:

^ **Symbol** ^ **Meaning** ^
| ''(2'' | 2 notes in the time of 3     |
| ''(3'' | 3 notes in the time of 2     |
| ''(4'' | 4 notes in the time of 3     |
| ''(5'' | 5 notes in the time of //n// |
| ''(6'' | 6 notes in the time of 2     |
| ''(7'' | 7 notes in the time of //n// |
| ''(8'' | 8 notes in the time of 3     |
| ''(9'' | 9 notes in the time of //n// |

If the time signature is compound (6/8, 9/8, 12/8) then //n// is three, otherwise //n// is two.

More general tuplets can be specified using the syntax ''(p:q:r'' which means 'put //p// notes into the time of //q// for the next //r// notes'. If //q// is not given, it defaults as above. If //r// is not given, it defaults to //p//. 

For example, ''(3'' is equivalent to ''(3::'' or ''(3:2'' , which in turn are equivalent to ''(3:2:3'', whereas ''(3::2'' is equivalent to ''(3:2:2''.

This can be useful to include notes of different lengths within a tuplet, for example ''(3:2:2 G4c2'' or ''(3:2:4 G2A2Bc''. It also describes more precisely how the simple syntax works in cases like ''(3 D2E2F2'' or even ''(3 D3EF2''. The number written over the tuplet is //p//.

Spaces that appear between the tuplet specifier and the following notes are to be ignored.

==== 4.14 Decorations ====

A number of shorthand decoration symbols are available:
  .       staccato mark
  ~       Irish roll
  H       fermata
  L       accent or emphasis
  M       lowermordent
  O       coda
  P       uppermordent
  S       segno
  T       trill
  u       up-bow
  v       down-bow
Decorations should be placed before the note which they decorate - see [[#order of abc constructs|order of abc constructs]]

// Examples: //
  (3.a.b.c    % staccato triplet
  vAuBvA      % bowing marks (for fiddlers)

Most of the characters above (''~HLMOPSTuv'') are just short-cuts for commonly used decorations and can even be redefined (see [[#redefinable_symbols|redefinable symbols]]).

More generally, symbols can be entered using the syntax ''!symbol!'', e.g. ''!trill!A4'' for a trill symbol. (Note that the abc standard version 2.0 used instead the syntax ''+symbol+'' - this dialect of abc is still available, but is now [[#outdated syntax|deprecated]] - see [[#decoration_dialects|decoration dialects]].)

The currently defined symbols are:
  !trill!                "tr" (trill mark)
  !trill(!               start of an extended trill
  !trill)!               end of an extended trill
  !lowermordent!         short /|/|/ squiggle with a vertical line through it
  !uppermordent!         short /|/|/ squiggle
  !mordent!              same as !lowermordent!
  !pralltriller!         same as !uppermordent!
  !roll!                 a roll mark (arc) as used in Irish music
  !turn!                 a turn mark (also known as gruppetto)
  !turnx!                a turn mark with a line through it
  !invertedturn!         an inverted turn mark
  !invertedturnx!        an inverted turn mark with a line through it
  !arpeggio!             vertical squiggle
  !>!                    > mark
  !accent!               same as !>!
  !emphasis!             same as !>!
  !fermata!              fermata or hold (arc above dot)
  !invertedfermata!      upside down fermata
  !tenuto!               horizontal line to indicate holding note for full duration
  !0! - !5!              fingerings
  !+!                    left-hand pizzicato, or rasp for French horns
  !plus!                 same as !+!
  !snap!                 snap-pizzicato mark, visually similar to !thumb!
  !slide!                slide up to a note, visually similar to a half slur
  !wedge!                small filled-in wedge mark
  !upbow!                V mark
  !downbow!              squared n mark
  !open!                 small circle above note indicating open string or harmonic
  !thumb!                cello thumb symbol
  !breath!               a breath mark (apostrophe-like) after note
  !pppp! !ppp! !pp! !p!  dynamics marks
  !mp! !mf! !f! !ff!     more dynamics marks
  !fff! !ffff! !sfz!     more dynamics marks
  !crescendo(!           start of a < crescendo mark
  !<(!                   same as !crescendo(!
  !crescendo)!           end of a < crescendo mark, placed after the last note
  !<)!                   same as !crescendo)!
  !diminuendo(!          start of a > diminuendo mark
  !>(!                   same as !diminuendo(!
  !diminuendo)!          end of a > diminuendo mark, placed after the last note
  !>)!                   same as !diminuendo)!
  !segno!                2 ornate s-like symbols separated by a diagonal line
  !coda!                 a ring with a cross in it
  !D.S.!                 the letters D.S. (=Da Segno)
  !D.C.!                 the letters D.C. (=either Da Coda or Da Capo)
  !dacoda!               the word "Da" followed by a Coda sign
  !dacapo!               the words "Da Capo"
  !fine!                 the word "fine"
  !shortphrase!          vertical line on the upper part of the staff
  !mediumphrase!         same, but extending down to the centre line
  !longphrase!           same, but extending 3/4 of the way down

Here is a picture of most decorations:

{{:abc:standard:decorations.0000.png}}

Note that the decorations may be applied to notes, rests, note groups, and bar lines. If a decoration is to be typeset between notes, it may be attached to the ''y'' spacer - see [[#typesetting_extra_space|typesetting extra space]].

Spaces may be used freely between each of the symbols and the object to which it should be attached. Also an object may be preceded by multiple symbols, which should be printed one over another, each on a different line.

// Example: //
  [!1!C!3!E!5!G]  !coda! y  !p! !trill! C   !fermata!|

{{:abc:standard:decorations2-80.png}}

Player programs may choose to ignore most of the symbols mentioned above, though they may be expected to implement the dynamics marks, the accent mark and the staccato dot. Default volume is equivalent to !mf!. On a scale from 0-127, the relative volumes can be roughly defined as: ''!pppp!'' = ''!ppp!'' = 30, ''!pp!'' = 45, ''!p!'' = 60, ''!mp!'' = 75, ''!mf!'' = 90, ''!f!'' = 105, ''!ff!'' = 120, ''!fff!'' = ''!ffff!'' = 127.

Abc software may also allow users to define new symbols in a package dependent way.

Note that symbol names may not contain any spaces, ''['', '']'', ''|'' or '':'' signs, e.g. while !dacapo! is legal, !da capo! is not.

If an unimplemented or unknown symbol is found, it should be ignored.

// Recommendation: // A good source of general information about decorations can be found at http://www.dolmetsch.com/musicalsymbols.htm.
==== 4.15 Symbol lines ====

Adding many symbols to a line of music can make a tune difficult to read. In such cases, a symbol line (a line that contains only ''!...!'' [[#decorations|decorations]], ''"..."'' [[#chord symbols|chord symbols]] or [[#annotations|annotations]]) can be used, analogous to a line of [[#lyrics|lyrics]]. 

A symbol line starts with ''s:'', followed by a line of symbols. Matching of notes and symbols follow the [[#alignment|alignment rules]] defined for lyrics (meaning that symbols in an ''s:'' line cannot be aligned on [[#grace notes|grace notes]], [[#rests|rests]] or [[#typesetting extra space|spacers]]).

// Example: //
     CDEF    | G```AB`c
  s: "^slow" | !f! ** !fff!

It is also possible to stack ''s:'' lines to produced multiple symbols on a note.

// Example: // The following two excerpts are equivalent and would place a decorations plus a chord on the ''E''.
     C2  C2 Ez   A2|
  s: "C" *  "Am" * |
  s: *   *  !>!  * |

  "C" C2 C2 "Am" !>! Ez A2|

==== 4.16 Redefinable symbols ====

As a short cut to writing symbols which avoids the ''!symbol!'' syntax (see [[#decorations|decorations]]), the letters ''H-W'' and ''h-w'' and the symbol ''~'' can be assigned with the ''U:'' field. For example, to assign the letter ''T'' to represent the trill, you can write:

  U: T = !trill!

You can also use ''"^text"'', etc (see [[#annotations|annotations]] below) in definitions

// Example: // To print a plus sign over notes, define ''p'' as follows and use it before the required notes:
  U: p = "^+"

Symbol definitions can be written in the [[#file header definition|file header]], in which case they apply to all the tunes in that file, or in a [[#tune header definition|tune header]], when they apply only to that tune, and override any previous definitions. Programs may also make use of a set of global default definitions, which apply everywhere unless overridden by local definitions. You can assign the same symbol to two or more letters e.g.
  U: T = !trill!
  U: U = !trill!
in which case the same visible symbol will be produced by both letters (but they may be played differently), and you can de-assign a symbol by writing:
  U: T = !nil!
or
  U: T = !none!

The standard set of definitions (if you do not redefine them) is:
  U: ~ = !roll!
  U: H = !fermata!
  U: L = !accent!
  U: M = !lowermordent!
  U: O = !coda!
  U: P = !uppermordent!
  U: S = !segno!
  U: T = !trill!
  U: u = !upbow!
  U: v = !downbow!
Please see [[#macros|macros]] for an advanced macro mechanism.

==== 4.17 Chords and unisons ====

Chords (i.e. more than one note head on a single stem) can be coded with ''[]'' symbols around the notes, e.g.

  [CEGc]

indicates the chord of C major. They can be grouped in beams, e.g.

  [d2f2][ce][df]

but there should be no spaces within the notation for a chord. See the tune 'Kitchen Girl' in the sample file [[#reelsabc|Reels.abc]] for a simple example.

All the notes within a chord should normally have the same length, but if not, the chord duration is that of the first note.

// Recommendation: // Although playback programs should not have any difficulty with notes of different lengths, typesetting programs may not always be able to render the resulting chord to staff notation (for example, an eighth and a quarter note cannot be represented on the same stem) and the result is undefined. Consequently, this is not recommended.

More complicated chords can be transcribed with the ''&'' operator (see [[#voice_overlay|voice overlay]]).

The chord forms a syntactic grouping, to which the same prefixes and postfixes can be attached as to an ordinary note (except for accidentals which should be attached to individual notes within the chord and decorations which may be attached to individual notes within the chord or may be attached to the chord as a whole).

// Example: //

  ( "^I" !f! [CEG]- > [CEG] "^IV" [F=AC]3/2"^V"[GBD]/  H[CEG]2 )

{{:abc:standard:chords-80.png}}

When both inside and outside the chord length modifiers are used, they should be multiplied. // Example: // ''[C2E2G2]3'' has the same meaning as ''[CEG]6''.

If the chord contains two notes of the same pitch, then it is a unison (e.g. a note played on two strings of a violin simultaneously) and is shown with one stem and two note-heads.

// Example: //

  [DD]

{{:abc:standard:unison-80.png}}

==== 4.18 Chord symbols ====

// VOLATILE: // The list of chords and how they are handled will be extended at some point. Until then programs should treat chord symbols quite liberally.

Chord symbols (e.g. chords/bass notes) can be put in under the melody line (or above, depending on the package) using double-quotation marks placed to the left of the note it is sounded with, e.g. ''"Am7"A2D2''.

The chord has the format //<note><accidental><type></bass>//, where //<note>// can be ''A-G'', the optional //<accidental>// can be ''b'', ''#'', the optional //<type>// is one or more of

  m or min        minor
  maj             major
  dim             diminished
  aug or +        augmented
  sus             suspended
  7, 9 ...        7th, 9th, etc.

and //</bass>// is an optional bass note.

A slash after the chord type is used only if the optional bass note is also used, e.g., ''"C/E"''. If the bass note is a regular part of the chord, it indicates the inversion, i.e., which note of the chord is lowest in pitch. If the bass note is not a regular part of the chord, it indicates an additional note that should be sounded with the chord, below it in pitch. The bass note can be any letter (''A-G'' or ''a-g''), with or without a trailing accidental sign (''b'' or ''#''). The case of the letter used for the bass note does not affect the pitch.

Alternate chords can be indicated for printing purposes (but not for playback) by enclosing them in parentheses inside the double-quotation marks after the regular chord, e.g., ''"G(Em)"''.

// Note to developers: // Software should also be able to recognise and handle appropriately the unicode versions of flat, natural and sharp symbols (♭, ♮, ♯) - see [[#special symbols|special symbols]].

==== 4.19 Annotations ====

General text annotations can be added above, below or on the staff in a similar way to chord symbols. In this case, the string within double quotes is preceded by one of five symbols ''^'', ''_'', ''<'', ''>'' or ''@'' which controls where the annotation is to be placed; above, below, to the left or right respectively of the following note, rest or bar line. Using the ''@'' symbol leaves the exact placing of the string to the discretion of the interpreting program. These placement specifiers distinguish annotations from chord symbols, and should prevent programs from attempting to play or transpose them. All text that follows the placement specifier is treated as a [[#text string definition|text string]].

Where two or more annotations with the same placement specifier are placed consecutively, e.g. for fingerings, the notation program should draw them on separate lines, with the first listed at the top.

// Example: // The following annotations place the note between parentheses.

  "<(" ">)" C

==== 4.20 Order of abc constructs ====

The order of abc constructs for a note is: //<grace notes>//, //<chord symbols>//, //<annotations>/<decorations>// (e.g. Irish roll, staccato marker or up/downbow), //<accidentals>//, //<note>//, //<octave>//, //<note length>//, i.e. ''~^c'3'' or even ''"Gm7"v.=G,2''.

Each [[#ties_and_slurs|tie symbol]], ''-'', should come immediately after a note group but may be followed by a space, i.e. ''=G,2- ''. Open and close chord delimiters, ''['' and '']'', should enclose entire note sequences (except for chord symbols), e.g.

  "C"[CEGc]|
  |"Gm7"[.=G,^c']

and open and close slur symbols, ''()'', should do likewise, i.e.

  "Gm7"(v.=G,2~^c'2)

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 5. Lyrics =====

The ''W:'' [[#information field definition|information field]] (uppercase W) can be used for lyrics to be printed separately below the tune.

The ''w:'' [[#information field definition|information field]] (lowercase w) in the [[#tune body definition|tune body]], supplies lyrics to be aligned syllable by syllable with previous notes of the current voice.

==== 5.1 Alignment ====

When adjacent, ''w:'' fields indicate different verses ([[#verses|see below]]), but for non-adjacent ''w:'' fields, the alignment of the lyrics:
  * starts at the first note of the voice if there is no previous ''w:'' field; or
  * starts at the first note after the notes aligned to the previous ''w:'' field; and
  * associates syllables to notes up to the end of the ''w:'' line.

// Example: // The following two examples are equivalent.

  C D E F|
  w: doh re mi fa
  G A B c|
  w: sol la ti doh

  C D E F|
  G A B c|
  w: doh re mi fa sol la ti doh

// Comment: // The second example, made possible by an extension (introduced in abc 2.1) of the alignment rules, means that lyrics no longer have to follow immediately after the line of notes to which they are attached. Indeed, the placement of the lyrics can be postponed to the end of the [[#tune body definition|tune body]]. However, the extension of the alignment rules is not fully backwards compatible with abc 2.0 - see [[#outdated lyrics alignment|outdated lyrics alignment]] for an explanation.

If there are fewer syllables than available notes, the remaining notes have no lyric (blank syllables); thus the appearance of a ''w:'' field associates all the notes that have appeared previously with a syllable (either real or blank). 

// Example: // In the following example the empty ''w:'' field means that the 4 ''G'' notes have no lyric associated with them.

  C D E F|
  w: doh re mi fa
  G G G G|
  w:
  F E F C|
  w: fa mi re doh

If there are more syllables than available notes, any excess syllables will be ignored.

// Recommendation for developers: // If a ''w:'' line does not contain the correct number of syllables for the corresponding notes, the program should warn the user. However, having insufficient syllables is legitimate usage (as above) and so the program may allow these warnings to be switched off.

Note that syllables are not aligned on [[#grace notes|grace notes]], [[#rests|rests]] or [[#typesetting extra space|spacers]] and that tied, slurred or beamed notes are treated as separate notes in this context.

The lyrics lines are treated as [[#text string definition|text strings]]. Within the lyrics, the words should be separated by one or more spaces and to correctly align them the following symbols may be used:

^ **Symbol** ^ **Meaning** ^
| ''-''  | (hyphen) break between syllables within a word                 |
| ''_''  | (underscore) previous syllable is to be held for an extra note |
| ''*''  | one note is skipped (i.e. * is equivalent to a blank syllable) |
| ''~''  | appears as a space; aligns multiple words under one note       |
| ''\-'' | appears as hyphen; aligns multiple syllables under one note    |
| ''|''  | advances to the next bar                                       |

Note that if ''-'' is preceded by a space or another hyphen, the ''-'' is regarded as a separate syllable.

When an underscore is used next to a hyphen, the hyphen must always come first.

If there are not as many syllables as notes in a measure, typing a ''|'' automatically advances to the next bar; if there are enough syllables the ''|'' is just ignored.

// Examples: //

  w: syll-a-ble    is aligned with three notes
  w: syll-a--ble   is aligned with four notes
  w: syll-a -ble   (equivalent to the previous line)
  w: time__        is aligned with three notes
  w: of~the~day    is treated as one syllable (i.e. aligned with one note)
                   but appears as three separate words

   gf|e2dc B2A2|B2G2 E2D2|.G2.G2 GABc|d4 B2
  w: Sa-ys my au-l' wan to your aul' wan,
  +: Will~ye come to the Wa-x-ies dar-gle?

See [[#field continuation|field continuation]] for the meaning of the ''+:'' field continuation.

==== 5.2 Verses ====

It is possible for a music line to be followed by several adjacent ''w:'' fields, i.e. immediately after each other. This can be used, together with part notation, to represent different verses. The first ''w:'' field is used the first time that part is played, then the second and so on.

// Examples: //
The following two examples are equivalent and contain two verses:

  CDEF FEDC|
  w: these are the lyr-ics for verse one
  w: these are the lyr-ics for verse two

  CDEF FEDC|
  w: these are the lyr-ics
  +:  for verse one
  w: these are the lyr-ics
  +:  for verse two  

==== 5.3 Numbering ====

// VOLATILE: // The following syntax may be extended to include non-numeric "numbering".

If the first word of a ''w:'' line starts with a digit, this is interpreted as numbering of a stanza. Typesetting programs should align the corresponding note with the first letter that occurs. This can be used in conjunction with the ''~'' symbol mentioned in the table above to create a space between the digit and the first letter.

// Example: // In the following, the ''1.~Three'' is treated as a single word with a space created by the ''~'', but the fact that the ''w:'' line starts with a number means that the first note of the corresponding music line is aligned to ''Three''.

     w: 1.~Three blind mice

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 6. Typesetting and playback =====

==== 6.1 Typesetting ====

=== 6.1.1 Typesetting line-breaks ===

// Terminology: // **Line-breaks** in a document (also known in computing as new lines, line-feeds, carriage-returns, end-of-lines, etc.) determine how the document is set out on the page. Throughout this section, and elsewhere in the standard, a distinction should be noted between
  * <html><a name="code_line-break_definition"></a></html>a **code line-break**, meaning a line-break in the abc [[#tune body definition|tune body]], and, in particular, at the end of a line of [[#music code definition|music code]];
  * <html><a name="score_line-break_definition"></a></html>a **score line-break**, meaning a line-break in the printed score.

The fundamental mechanism for typesetting [[#score line-break definition|score line-breaks]] is by using [[#code line-break definition|code line-breaks]] - one line of [[#music code definition|music code]] in the [[#tune body definition|tune body]] normally corresponds to one line of printed music.

Of course the printed representation of a line of [[#music code definition|music code]] may be too long for the staff, so if necessary, typesetting programs should introduce additional [[#score line-break definition|score line-breaks]]. As a consequence, if you would prefer [[#score line-break definition|score line-breaks]] to be handled completely automatically (as is common in non-abc scoring software), then just type the [[#tune body definition|tune body]] on a single line of [[#music code definition|music code]].

Even though most abc GUI software should wrap over-long lines, typing the [[#tune body definition|tune body]] on a single line may not always be convenient, particularly for users who wish to include [[#code line-break definition|code line-breaks]] to aid readability or if the abc code is to be emailed (see [[#continuation of input lines|continuation of input lines]]).

Furthermore, in the past some typesetting programs used ''!'' characters in the abc code to force [[#score line-break definition|score line-breaks]].

As a result, abc 2.1 introduces a new line-breaking instruction.

== I:linebreak ==

To allow for all line-breaking preferences, the ''I:linebreak'' instruction may be used, together with four possible values, to control [[#score line-break definition|score line-breaking]].

  * "''I:linebreak $''" indicates that the ''$'' symbol is used in the [[#tune body definition|tune body]] to typeset a [[#score line-break definition|score line-break]]. Any [[#code line-break definition|code line-breaks]] are ignored for typesetting purposes.

// Example: // The following abc code should be typeset on two lines.
  I:linebreak $
  K:G
  |:abc def|$fed cba:|

  * "''I:linebreak !''" indicates that the ''!'' symbol is used to typeset a [[#score line-break definition|score line-break]]. Any [[#code line-break definition|code line-breaks]] are ignored for typesetting purposes.

// Comment: // The "''I:linebreak !''" instruction works in the same way as ''I:linebreak $'' and is primarily provided for backwards compatibility - see [[#line-breaking_dialects|line-breaking dialects]], so that "''I:linebreak $''" is the preferred usage. "''I:linebreak !''" also automatically invokes the "''I:decoration +''" instruction - see [[#decoration_dialects|decoration dialects]]. Finally, "''I:linebreak !''" is equivalent to the [[#outdated syntax|deprecated]] directive ''<nowiki>%%</nowiki>continueall true'' - see [[#outdated directives|outdated directives]].

  * "''I:linebreak <EOL>''" indicates that the End Of Line character (CR, LF or CRLF) is used to typeset a [[#score line-break definition|score line-break]]. In other words, [[#code line-break definition|code line-breaks]] are used for typesetting [[#score line-break definition|score line-breaks]].

  * "''I:linebreak <none>''" indicates that all line-breaking is to be carried out automatically and any [[#code line-break definition|code line-breaks]] are ignored for typesetting purposes.

The values ''<EOL>'', ''$'' and ''!'' may also be combined so that more that one symbol can indicate a [[#score line-break definition|score line-break]].

The default line-break setting is:
  I:linebreak <EOL> $
meaning that both [[#code line-break definition|code line-breaks]], and ''$'' symbols, generate a [[#score line-break definition|score line-break]].

// Comment: // Although "''I:linebreak $ !''" is legal it is not recommended as it uses two different symbols to mean the same thing.

An ''I:linebreak'' instruction can be used either in the [[#file header definition|file header]] (in which case it is applied to every [[#abc tune definition|tune]] in the [[#abc file definition|abc file]]), or in a [[#tune header definition|tune header]] (in which case it is applied to that tune only and overrides a line-breaking instruction in the [[#file header definition|file header]]). Similarly, if two ''I:linebreak'' instructions appear in a [[#file header definition|file header]] or a [[#tune header definition|tune header]], the second cancels the first.

// Comment: // It can be sometimes be useful to include two instructions together - for example, "''I:linebreak <EOL> $''" and "''I:linebreak <none>''" can be used to toggle between default and automatic line-breaking simply by swapping the position of the two lines.

''I:linebreak'' instructions are not allowed in the [[#tune body definition|tune body]] (principally because it conflicts with the human readability of the [[#music code definition|music code]]). 

== Suppressing score line-breaks ==

When the ''<EOL>'' character is being used in the [[#tune body definition|tune body]] to indicate [[#score line-break definition|score line-breaks]], it sometimes useful to be able to tell typesetting software to ignore a particular [[#code line-break definition|code line-breaks]]. This is achieved using a backslash (''\'') at the end of a line of [[#music code definition|music code]]. The backslash may be followed by trailing whitespace and/or [[#comment definition|comments]], since they are removed before the line is processed.

// Example: // The following two excerpts are considered equivalent and should be typeset as a single staff in the printed score.
  abc cba|\ % end of line comment
  abc cba|
  
  abc cba|abc cba|
  
The backslash effectively joins two lines together for processing so if space is required between the two half lines (for example, to prevent the notes from being beamed together), it can be placed before the backslash, or at the beginning of the next half line.

// Example: // The following three excerpts are considered equivalent.
  abc \
  cba|
  
  abc\
   cba|
  
  abc cba|  

There is no limit to the number of lines that may be joined together in this way. However, a backslash must not be used before an [[#empty line definition|empty line]].

// Example: // The following is legal.
  cdef|\
  \
  cedf:|
  
// Example: // The following is not legal.
  cdef|\
  
  cdef:|

In the examples above, where a line of [[#music code definition|music code]] follows immediately after a line ending in backslash, the backslash acts as a continuation for two lines of [[#music code definition|music code]] and can therefore be used to split up long [[#music code definition|music code]] lines.

More importantly, however, any [[#information field definition|information fields]] and [[#stylesheet directive definition|stylesheet directives]] are processed (and [[#comment definition|comments]] are removed) at the point where the physical line-break occurs. Hence the backslash is commonly used to include meter or key changes halfway through a line of music.

// Example: // The following should be typeset as a single staff in the printed score.
  abc cab|\
  %%setbarnb 10
  M:9/8
  %comment
  abc cba abc|

// Alternative usage example: // The above could also be achieved using [[#inline field definition|inline fields]], the ''[[#iinstruction|I:<directive>]]'' form instead of ''<nowiki>%%</nowiki><directive>'' and a ''[[#comments and remarks|r:remark]]'' in place of the [[#comment definition|comment]], i.e.
  abc cab|[I:setbarnb 10][M:9/8][r:comment]abc cba abc|
  
Finally, note that if the the ''<EOL>'' character is not being used to indicate [[#score line-break definition|score line-breaks]], then the backslash is effectively redundant.
  
// Recommendation to users: // If you find that you are using backslash symbols on most lines of [[#music code definition|music code]], then consider instead using "''I:linebreak <none>''" or "''I:linebreak $''" which will mean that all the [[#code line-break definition|code line-breaks]] will be ignored for the purposes of generating [[#score line-break definition|score line-breaks]] (and, in the latter case, you can encode a [[#score line-break definition|score line-breaks]] with the ''$'' character).

=== 6.1.2 Typesetting extra space ===

''y'' can be used to add extra space between the surrounding notes; moreover, [[#chord_symbols|chord symbols]] and [[#decorations|decorations]] can be attached to it, to separate them from notes.

// Example: //
  "Am" !pp! y

Note that the ''y'' symbol does //not// create [[#rests|rests]] in the music.

=== 6.1.3 Typesetting information fields ===

By default typesetting programs should include the the title (T), composer (C), origin (O), parts (P), tempo (Q), aligned words (w) and other words (W) in the printed score, using the follow scheme:
  * the ''T:title'' should be printed centred above the tune; alternative titles should be printed underneath the main title in smaller print
  * the ''C:composer'' should be printed right-aligned, just below the title, each composer on a separate line
  * the contents of the ''O:origin'' field should be appended to the ''C:composer'' field, surrounded by parentheses
  * each ''P:part'' in the [[#tune body definition|tune body]] should have the string identifying it printed immediately above the start of that part; if there is a ''P:parts'' field in the [[#tune header definition|tune header]] (describing which order the parts are played in) it should be printed left-aligned above the start of the tune
  * the ''Q:tempo'' should be printed above the tune at the start of the section to which it applies
  * the aligned ''w:words'' (lyrics) should be printed under each line of music with other ''W:words'' printed beneath the tune - see [[#lyrics|lyrics]]

To suppress any of these, or alternatively to typeset additional [[#information field definition|information fields]] such as notes (N), history (H), rhythm (R), book (B), discography (D), file (F), source (S) or transcription (Z), use the ''<nowiki>%%</nowiki>writefields'' directive - see [[#information directives|information directives]].

To customise the typesetting (for example, by changing the font), see [[#formatting directives|formatting directives]].


==== 6.2 Playback ====

Many of the [[#information field definition|information fields]] are ignored by playback programs - exceptions are ''I:'', ''K:'', ''L:'', ''M:'', ''m:'', ''P;'', ''Q:'', ''s:'', ''U:'' and ''V:''.

In addition, playback programs that store their output in file types which have provisions for metadata (e.g. MIDI, ogg, mp3), may record the contents the ''T:'', ''C:'', ''w:'' and ''W:'' fields in that metadata.

Furthermore, playback programs may use the ''R:'' field to infer stress patterns in a tune (i.e. to make playback closer to real music, by for example, placing more stress on the first note in each bar); however, such usage is not standardised.

Most playback customisation is handled by [[#instrumentation_directives|instrumentation directives]].

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 7. Multiple voices =====

// VOLATILE: // Multi-voice music is under active review, with discussion about control voices and interaction between ''P:'', ''V:'' and ''T:'' fields. It is intended that the syntax will be finalised in abc 2.2.

The ''V:'' field allows the writing of multi-voice music. In multi-voice [[#abc tune definition|abc tunes]], the [[#tune body definition|tune body]] is divided into several voices, each beginning with a ''V:'' field. All the notes following such a ''V:'' field, up to the next ''V:'' field or the end of the [[#tune body definition|tune body]], belong to the voice.

The basic syntax of the field is:

  V:ID

where ID can be either a number or a string, that uniquely identifies the voice in question. When using a string, only the first 20 characters of it will be distinguished. The ID will not be printed on the staff; it's only function is to indicate, throughout the [[#abc tune definition|abc tune]], which music line belongs to which voice.

Example:

  X:1
  T:Zocharti Loch
  C:Louis Lewandowski (1821-1894)
  M:C
  Q:1/4=76
  %%score (T1 T2) (B1 B2)
  V:T1           clef=treble-8  name="Tenore I"   snm="T.I"
  V:T2           clef=treble-8  name="Tenore II"  snm="T.II"
  V:B1  middle=d clef=bass      name="Basso I"    snm="B.I"
  V:B2  middle=d clef=bass      name="Basso II"   snm="B.II"
  K:Gm
  %            End of header, start of tune body:
  % 1
  [V:T1]  (B2c2 d2g2)  | f6e2      | (d2c2 d2)e2 | d4 c2z2 |
  [V:T2]  (G2A2 B2e2)  | d6c2      | (B2A2 B2)c2 | B4 A2z2 |
  [V:B1]       z8      | z2f2 g2a2 | b2z2 z2 e2  | f4 f2z2 |
  [V:B2]       x8      |     x8    |      x8     |    x8   |
  % 5
  [V:T1]  (B2c2 d2g2)  | f8        | d3c (d2fe)  | H d6    ||
  [V:T2]       z8      |     z8    | B3A (B2c2)  | H A6    ||
  [V:B1]  (d2f2 b2e'2) | d'8       | g3g  g4     | H^f6    ||
  [V:B2]       x8      | z2B2 c2d2 | e3e (d2c2)  | H d6    ||

This layout closely resembles printed music, and permits the corresponding notes on different voices to be vertically aligned so that the chords can be read directly from the abc. The addition of single remark lines "%" between the grouped staves, indicating the bar numbers, also makes the source more legible.

Here follows the visible output:

{{:abc:standard:multivoice-80.png}}

You can listen to the audible output (as MIDI) [[http://abcnotation.com/media/standard/multivoice.mid|here]].

''V:'' can appear both in the body and the header. In the latter case, ''V:'' is used exclusively to set voice properties. For example, the ''name'' property in the example above, specifies which label should be printed on the first staff of the voice in question. Note that these properties may be also set or changed in the [[#tune body definition|tune body]]. The ''V:'' properties are fully explained [[#voice properties|below]].

Please note that the exact grouping of voices on the staff or staves is not specified by ''V:'' itself. This may be specified with the ''<nowiki>%%score</nowiki>'' [[#stylesheet directive definition|stylesheet directive]]. See [[#voice grouping|voice grouping]] for details. 

For playback, see [[#instrumentation directives|instrumentation directives]] for details of how to assign a General MIDI instrument to a voice using a ''<nowiki>%%MIDI</nowiki>'' [[#stylesheet directive definition|stylesheet directive]].

Although it is not recommended, the [[#tune body definition|tune body]] of fragment ''X:1'', could also be notated this way:

  X:2
  T:Zocharti Loch
  %...skipping rest of the header...
  K:Gm
  %               Start of tune body:
  V:T1
   (B2c2 d2g2) | f6e2 | (d2c2 d2)e2 | d4 c2z2 |
   (B2c2 d2g2) | f8 | d3c (d2fe) | H d6 ||
  V:T2
   (G2A2 B2e2) | d6c2 | (B2A2 B2)c2 | B4 A2z2 |
   z8 | z8 | B3A (B2c2) | H A6 ||
  V:B1
   z8 | z2f2 g2a2 | b2z2 z2 e2 | f4 f2z2 |
   (d2f2 b2e'2) | d'8 | g3g  g4 | H^f6 ||
  V:B2
   x8 | x8 | x8 | x8 |
   x8 | z2B2 c2d2 | e3e (d2c2) | H d6 ||

In the example above, each ''V:'' label occurs only once, and the complete part for that voice follows. The output of tune ''X:2'' will be exactly the same as the output of tune ''X:1''; the source code of ''X:1'', however, is much easier to read.

==== 7.1 Voice properties ====

// VOLATILE: // See [[#multiple voices|above]].

''V:'' fields can contain voice specifiers such as name, clef, and so on. For example,

  V:T name="Tenor" clef=treble-8

indicates that voice ''T'' will be drawn on a staff labelled ''Tenor'', using the treble clef with a small ''8'' underneath. Player programs will transpose the notes by one octave. Possible voice definitions include:

  * **name="voice name"** - the voice name is printed on the left of the first staff only. The characters ''\n'' produce a newline in the output.
  * **subname="voice subname"** - the voice subname is printed on the left of all staves but the first one.
  * **stem=up/down** - forces the note stem direction.
  * **clef=** - specifies a clef; see [[#clefs and transposition|clefs and transposition]] for details.

The name specifier may be abbreviated to ''nm=''. The subname specifier may be abbreviated to ''snm=''.

Applications may implement their own specifiers, but must gracefully ignore specifiers they don't understand or implement. This is required for portability of [[#abc file definition|abc files]] between applications.

==== 7.2 Breaking lines ====

// VOLATILE: // See [[#multiple voices|above]]. In particular the following may be relaxed with the introduction of a control voice.

The rules for [[#typesetting line-breaks|typesetting line-breaks]] in multi-voice [[#abc tune definition|abc tunes]] are the same as for single voice music although additionally a line-break in one voice must be matched in the other voices. See the example tune [[#canzonettaabc|Canzonetta.abc]].

==== 7.3 Inline fields ====

// VOLATILE: // See [[#multiple voices|above]].

To avoid ambiguity, [[#inline field definition|inline fields]] that specify music properties should be repeated in every voice to which they apply.

// Example: //
  [V:1] C4|[M:3/4]CEG|Gce|
  [V:2] E4|[M:3/4]G3 |E3 |

==== 7.4 Voice overlay ====

// VOLATILE: // See [[#multiple voices|above]].

The ''&'' operator may be used to temporarily overlay several voices within one measure. Each ''&'' operator sets the time point of the music back by one bar line, and the notes which follow it form a temporary voice in parallel with the preceding one. This may only be used to add one complete bar's worth of music for each ''&''.

Example:

  A2 | c d e f g  a  &\
       A A A A A  A  &\
       F E D C B, A, |]

{{:abc:standard:overlay1-80.png}}

Words in ''w:'' lines (and symbols in ''s:'' lines) are matched to the corresponding notes as per the normal rules for lyric alignment (see [[#lyrics|lyrics]]), disregarding any overlay in the accompanying [[#music code definition|music code]].

// Example: //
      g4 f4 | e6 e2 |
  && (d8    | c6) c2|
  w: ha-la-| lu-yoh
  +: lu-   |   -yoh

{{:abc:standard:overlay3-80.png}}

This revokes the abc 2.0 usage of ''&'' in ''w:'' and ''s:'' lines, which is now [[#outdated syntax|deprecated]] (see [[#disallowed voice overlay|disallowed]]).

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 8. Abc data format =====

Each line in the file may end with white-space which will be ignored. For the purpose of this standard, ASCII tab and space characters are equivalent and are both included in the term 'white-space'. Applications must be able to interpret end-of-line markers in Unix (''<LF>''), Windows/DOS (''<CR><LF>''), and Macintosh style (''<CR>'') correctly.

==== 8.1 Tune body ====

Within the [[#tune body definition|tune body]], all the printable ASCII characters may be used for the [[#music code definition|music code]]. These are:

   !"#$%&'()*+,-./0123456789:;<=>?@
  ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`
  abcdefghijklmnopqrstuvwxyz{|}~

Of these, the following characters are currently reserved:

  # * ; ? @

In future standards they may be used to extend the abc syntax.

To ensure forward compatibility, current software should ignore these characters when they appear inside or between note groups, possibly giving a warning. However, these characters may not be ignored when they appear inside [[#text string definition|text strings]] or [[#information field definition|information fields]].

// Example: //

  @a !pp! #bc2/3* [K:C#] de?f "@this $2was difficult to parse?" y |**

should be treated as:

  a !pp! bc2/3 [K:C#] def "@this $2was difficult to parse?" y |

==== 8.2 Text strings ====

<html><a name="text_string_definition"></a></html>Text written within an [[#abc file definition|abc file]], either as part of an [[#information field definition|information field]], an [[#annotations|annotation]] or as [[#free text definition|free text]] / [[#typeset text definition|typeset text]], is known as a **text string**, or more fully, an **abc text string**. (Note that the abc standard version 2.0 referred to a [[#text string definition|text string]] as an //abc string//.)

Typically when there are several lines of text, each line forms a separate [[#text string definition|text string]], although the distinction is not essential. 

The contents of a text string may be written using any legal [[#charset field|character set]]. The default character set is ''utf-8'', giving access to every Unicode character.

However, not all text editors support ''utf-8'' and so to avoid portability problems when writing accented characters in text strings, it also possible to use three other encoding options:
  * **mnemonics** - for example, é can be represented by ''\'e''. These mnemonics are are based on TeX encodings and are always in the format //backslash-mnemonic-letter//. They have been available since the earliest days of abc and are widely used in legacy abc files. They are generally easy to remember and easy to read, but are not comprehensive in terms of the possible accents they can represent.
  * **named html entities** - for example, é can be represented by ''&eacute;''. These encodings are not common in legacy abc files but are convenient for websites which use abc and generally easy to remember. However they are not particularly easy to read and are not fully comprehensive in terms of the possible accents they can represent.
  * **fixed width unicode** - for example, é can be represented by ''\u00e9'' using the 16-bit unicode representation ''00e9'' (or ''\U000000e9'' using 32-bit). These encodings are not common in legacy abc files and are not easy to read but give comprehensive access to all unicode characters.

All conforming abc typesetting software should support (understand and be able to convert) the subset of accents and ligatures given in the appendix, [[#supported accents & ligatures|supported accents & ligatures]], together with the special characters and symbols listed below.

A summary, with examples, is as follows:
^ Accent       ^ Examples    ^ Encodings           ^
| grave        | ''À à è ò'' | ''\`A \`a \`e \`o'' |
| acute        | ''Á á é ó'' | ''\'A \'a \'e \'o'' |
| circumflex   | ''Â â ê ô'' | ''\^A \^a \^e \^o'' |
| tilde        | ''Ã ã ñ õ'' | ''\~A \~a \~n \~o'' |
| umlaut       | ''Ä ä ë ö'' | ''\"A \"a \"e \"o'' |
| cedilla      | ''Ç ç''     | ''\cC \cc''         |
| ring         | ''Å å''     | ''\AA \aa''         |
| slash        | ''Ø ø''     | ''\/O \/o''         |
| breve        | ''Ă ă Ĕ ĕ'' | ''\uA \ua \uE \ue'' |
| caron        | ''Š š Ž ž'' | ''\vS \vs \vZ \vz'' |
| double acute | ''Ő ő Ű ű'' | ''\HO \Ho \HU \Hu'' |
| ligatures    | ''ß Æ æ œ'' | ''\ss \AE \ae \oe'' |

Programs that have difficulty typesetting accented letters may reduce them to the base letter or, in the case of ligatures, the two base letters ignoring the backslash.

// Examples: // When reduced to the base letter, ''\oA'' becomes  ''A'', ''\"o'' becomes ''o'', ''\ss'' becomes ''ss'', ''\AE'' becomes ''AE'', etc.

For fixed width unicode, ''\u'' or ''\U'' must be followed by 4 or 8 hexadecimal characters respectively. Thus if any of the 4 characters after ''\u'' is not hexadecimal, then it is interpreted as a breve.

== Special characters ==
Characters that are meaningful in the context of a [[#text string definition|text string]] can be escaped using a backslash as follows:
  * type ''\\'' to get a backslash;
  * type ''\%'' to get a percent symbol that is not interpreted as the start of a [[#comments and remarks|comment]];
  * type ''\&'' to get an ampersand that is not interpreted as the start of a named html entity (although an ampersand followed by white-space is interpreted as is - for example, ''gin & tonic'' is OK, but ''G\&T'' requires the backslash);
  * type ''&quot;'' or ''\u0022'' to get double quote marks in an [[#annotations|annotation]]

== Special symbols ==
The following symbols are also useful:
  * type ''&copy;'' or ''\u00a9'' for the copyright symbol ©
  * type ''\u266d'' for a flat symbol ♭
  * type ''\u266e'' for a natural symbol ♮
  * type ''\u266f'' for a sharp symbol ♯

// VOLATILE: // Finally note that currently the specifiers ''$1'', ''$2'', ''$3'' and ''$4'' can be used to change the font within a [[#text string definition|text string]]. However, this feature is likely to change in future versions of the standard - see [[#font directives|font directives]] for more details.

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 9. Macros =====

This standard defines an **optional** system of macros which is principally used to define the way in which ornament symbols such as the tilde ''~'' are played (although it could be used for many other purposes).

Software implementing these macros, should first expand the macros defined in this section, and only afterwards apply any relevant ''U:'' replacement (see [[#redefinable_symbols|Redefinable symbols]]).

When these macros are stored in an abc header file (see [[#include_field|include field]]), they may form a powerful library.

There are two kinds of macro, called Static and Transposing.

==== 9.1 Static macros ====

You define a static macro by writing into the [[#tune header definition|tune header]] something like this:

   m: ~G3 = G{A}G{F}G

When you play the tune, the program searches the [[#tune header definition|tune header]] for macro definitions, then does a search and replace on its internal copy of the text before passing that to the parser which plays the tune. Every occurence of ''~G3'' in the tune is replaced by ''G{A}G{F}G'', and that is what gets played. Only ''~G3'' notes are affected, ''~G2'', ''~g3'', ''~F3'' etc. are ignored.

You can put in as many macros as you want, and indeed, if you only use static macros you will need to write a separate macro for each combination of pitch and note-length. Here is an example:

  X:50
  T:Apples in Winter
  S:Trad, arr. Paddy O'Brien
  R:jig
  m: ~g2 = {a}g{f}g
  m: ~D2 = {E}D{C}D
  M:6/8
  K:D
  G/2A/2|BEE dEE|BAG FGE|~D2D FDF|ABc ded|
  BEE BAB|def ~g2 e|fdB AGF|GEE E2:|
  d|efe edB|ege fdB|dec dAF|DFA def|
  [1efe edB|def ~g2a|bgb afa|gee e2:|
  [2edB def|gba ~g2e|fdB AGF|GEE E2||

Here I have put in two static macros, since there are two different notes in the tune marked with a tilde.

A static macro definition consists of four parts:

  * the field identifier ''m:''
  * the target string - e.g ''~G3''
  * the equals sign
  * the replacement string - e.g. ''G{A}G{F}G''

The target string can consist of any string up to 31 characters in length, except that it may not include the letter 'n', for reasons which will become obvious later. You don't have to use the tilde, but of course if you don't use a legal combination of abc, other programs will not be able to play your tune.

The replacement string consists of any legal abc text up to 200 characters in length. It's up to you to ensure that the target and replacement strings occupy the same time interval (the program does not check this). Both the target and replacement strings may include spaces if necessary, but leading and trailing spaces are stripped off so

  m:~g2={a}g{f}g

is perfectly OK, although less readable.

==== 9.2 Transposing macros ====

If your tune has ornaments on lots of different notes, and you want them to all play with the same ornament pattern, you can use transposing macros to achieve this. Transposing macros are written in exactly the same way as static macros, except that the note symbol in the target string is represented by 'n' (meaning any note) and the note symbols in the replacement string by other letters (h to z) which are interpreted according to their position in the alphabet relative to n.

So, for example I could re-write the static macro ''m: ~G3 = G{A}G{F}G'' as a transposing macro ''m: ~n3 = n{o}n{m}n''. When the transposing macro is expanded, any note of the form ''~n3'' will be replaced by the appropriate pattern of notes. Notes of the form ''~n2'' (or other lengths) will be ignored, so you will have to write separate transposing macros for each note length.

Here's an example:

  X:35
  T:Down the Broom
  S:Trad, arr. Paddy O'Brien
  R:reel
  M:C|
  m: ~n2 = (3o/n/m/ n                % One macro does for all four rolls
  K:ADor
  EAAG~A2 Bd|eg~g2 egdc|BGGF GAGE|~D2B,D GABG|
  EAAG ~A2 Bd|eg~g2 egdg|eg~g2 dgba|gedB BAA2:|
  ~a2ea agea|agbg agef|~g2dg Bgdg|gfga gede|
  ~a2 ea agea|agbg ageg|dg~g2 dgba|gedB BA A2:|

A transposing macro definition consists of four parts:

  * the field identifier ''m:''
  * the target string - e.g ''~n3''
  * the equals sign
  * the replacement string - e.g. ''n{o}n{m}n''

The target string can consist of any string up to 31 characters in length, except that it must conclude with the letter 'n', followed by a number which specifies the note length.

The replacement string consists of any legal abc text up to 200 characters in length, where note pitches are defined by the letters h - z, the pitches being interpreted relative to that of the letter n. Once again you should ensure that the time intervals match. You should not use accidentals in transposing macros

// Comment: // It is almost impossible to think of a way to transpose ''~=a3'' or ''~^G2'' which will work correctly under all circumstances, so a static macro should be used for cases like these.

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 10. Outdated syntax =====

The abc standard contains a variety of outdated syntax that is no longer recommended or, in some cases even supported, according to the following definitions:
  * **Deprecated** syntax is rules or constructs that have been outdated by newer syntax. Deprecated syntax must be supported by conforming abc software under strict interpretation but is not recommended for new transcriptions. Deprecated syntax may become obsolete in future versions of abc. Conforming abc software that encounters deprecated syntax should issue a warning when using strict interpretation (although it may offer the user the option to switch warnings off).
  * **Obsolete** syntax is rules or constructs for which there is no guarantee of support by conforming abc software. Obsolete syntax may be supported under loose interpretation but must not be used for new transcriptions. Conforming abc software that encounters obsolete syntax should issue a (preferably non-fatal) error message when using strict interpretation, or a warning when using loose interpretation (although it may offer the user the option to switch warnings off).
  * **Disallowed** syntax has the same definition as obsolete syntax, but has not gone through a formal process of deprecation.
  * **Outdated** syntax is the collective term for deprecated, obsolete and disallowed syntax.

Please see [[http://www.ietf.org/rfc/rfc2119.txt]] for formal definitions of the key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this context.

Outdated abc syntax is listed below so that users who come across it are able to interpret (and preferably update) it according to the latest standard.

==== 10.1 Outdated information field syntax ====

The ''A:'' [[#aarea|field]] was originally used to contain area information. In version 2.0 this was changed to contain the name of the lyrics author. In version 2.1, to maintain backwards compatibility, this has been changed back to area, but for clarity, the ''A:'' field is [[#outdated syntax|deprecated]] - area information can be stored in the ''O:'' field and a new field // (to be decided) // will be used for author information.

// Comment: // Of the 160,000 tunes currently available in the [[http://abcnotation.com/search|abcnotation.com tune search]] 16,300 contain an ''A:'' field with 680 distinct values. Of these, only around 10 contain author information rather than area (in some cases it is difficult to tell).

An ''E:'' field was once used by ''abc2mtex'' to explicitly control note spacing; this is no longer necessary with current formatting algorithms and the ''E:'' field is now [[#outdated syntax|deprecated]].

The original usage of the ''H:'' [[#hhistory|history]] field, where the contents of the history field is considered to continue over several lines until the next field occurs, is now [[#outdated syntax|deprecated]]. 

The ''Q:'' [[#qtempo|tempo]] field is still very much in use, but earlier versions of the standard permitted two syntax variants, now [[#outdated syntax|deprecated]], which specified how many unit note lengths to play per minute.

// Examples: // Both examples mean "play 120 unit note-lengths per minute".
  Q:C=120
  Q:120

This is not very musical, and the usage is [[#outdated syntax|deprecated]]. However, there are many [[#abc file definition|abc files]] which employ this syntax and programs should accept it.

==== 10.2 Outdated dialects ====

=== 10.2.1 Outdated line-breaking ===

The popular abc software abc2win introduced an exclamation mark (''!'') as a way of forcing a [[#score line-break definition|score line-break]] and this was adopted by abc 2.0, conflicting with the previous usage of ''!...!'' to delimit decorations.

The ''!'' is now [[#outdated syntax|deprecated]] for [[#score line-break definition|score line-breaks]] although it is still available (even under [[#strict interpretation|strict interpretation]]) for legacy abc transcriptions by use of the "''I:linebreak !''" directive - see [[#line-breaking dialects|line-breaking dialects]].

=== 10.2.2 Outdated decorations ===

Abc standard 2.0 adopted ''+...+'' syntax to indicate decorations in place of ''!...!''. It never gained much favour, however, and the latter is in much more common (see [[#decoration_dialects|decoration dialects]]).

Therefore, and since a non-conflicting mechanism has now been found to allow ''!'' for line-breaking (see [[#line-breaking dialects|line-breaking dialects]]), the ''+...+'' decoration syntax is now [[#outdated syntax|deprecated]] in favour of ''!...!''.

Nonetheless, the ''+...+'' decoration syntax is still available using the "''I:decoration +''" instruction (see [[#decoration dialects|decoration dialects]]).

=== 10.2.3 Outdated chords ===

Early versions of the abc standard used the ''+'' symbol to delimit chords (in place of ''[]'' symbols). This usage is now [[#outdated syntax|deprecated]] - see [[#chord dialects|chord dialects]] for more details.


==== 10.3 Outdated continuations ====

From the earliest days of abc (in abc standard 1.0 through to abc 1.7.6), the backslash (''\'') has been used to suppress [[#score line-break definition|score line-breaks]] by placing it at the end of a line of [[#music code definition|music code]]. Thus, effectively, it has acted as a continuation character, although with its own special rules, in particular that it could act through [[#information field definition|information fields]] and [[#comment definition|comments]].

Abc 2.0 extended this usage to make ''\'' a general continuation character, which also allows continuation of [[#information field definition|information fields]] and in particular the ''w:'' lyrics field (usually the only field which actually requires a continuation in typical transcriptions). Unfortunately, however, the rules of precedence were never well established (should the ''\'' be treated by a pre-processor joining together continued lines and, if so, should comments be removed before or after that happened?) and the usage was never widely adopted, nor even well understood.

// Comment: // Of the 160,000 tunes currently available in the [[http://abcnotation.com/search|abcnotation.com tune search]], only 22 (0.01%) use continuations for the ''w:'' field and only around 50 (0.03%) use it for any other field; of these latter usages, almost all are actually in error.

Furthermore, discussions during the development of abc 2.1 led to the suggestion that a new character should be introduced to suppress [[#score line-break definition|score line-breaks]] - in other words the ''\'' (as described in abc 2.0) had evolved far enough away from its initial definition so that another character was required to replace what it had originally been designed to do.

Consequently, in abc 2.1 the ''\'' has been reinstated to its original purpose of suppressing [[#score line-break definition|score line-breaks]] (see [[#typesetting line-breaks|typesetting line-breaks]]) and its use a general continuation character is now [[#outdated syntax|disallowed]] (see [[#continuation of input lines|continuation of input lines]] for the alternatives). 


==== 10.4 Outdated directives ====

The ''<nowiki>%%</nowiki>continueall true'' directive is replaced by "''I:linebreak !''" in abc 2.1 (see [[#typesetting_line-breaks|typesetting line-breaks]]) and [[#outdated syntax|deprecated]].

The ''<nowiki>%%</nowiki>abc-copyright'' and ''<nowiki>%%</nowiki>abc-edited-by'' extended information fields from section 3.3. of abc 2.0 have been [[#outdated syntax|deprecated]] in favour of the [[#ztranscription|Z: - transcription]] field.

// Comment: // Of the 131,000 files currently available in the [[http://abcnotation.com/search|abcnotation.com tune search]] only 32 use ''<nowiki>%%</nowiki>abc-edited-by'' and only 1 uses ''<nowiki>%%</nowiki>abc-copyright''.


==== 10.5 Outdated file structure ====

=== 10.5.1 Outdated tune header syntax ===

Abc standard 2.0 included the rule that 'if the [[#abc file definition|abc file]] contains only one tune the ''X:'' field may be dropped'. However, it was pointed out that as a consequence, a user who pasted an additional tune into such a file would get an error message from a tune which previously contained no errors.

Despite considerable discussion on the abcusers mail list (see for example the threads [[http://tech.groups.yahoo.com/group/abcusers/message/3950]] and [[http://tech.groups.yahoo.com/group/abcusers/message/4113]]) and, a number of good suggestions, no consensus was reached. As a result the above rule is [[#outdated syntax|deprecated]] in abc 2.1; a tune must start with a ''X:'' field followed by a ''T:'' field.

However, this decision may be revisited in the future and the specification relaxed.

=== 10.5.2 Outdated defaults ===

In early versions of the abc standard, defaults could be set throughout an [[#abc file definition|abc file]], using [[#information field definition|information fields]], which applied to all subsequent tune. In other words, the [[#file header definition|file header]] could effectively appear anywhere inside a file instead of just at the top.

This usage significantly complicates random access of the tunes in the file, since the all the preceding contents of the file must be scanned for default settings before a tune can be processed. As result this was [[#outdated syntax|deprecated]] in abc 2.0 and is [[#outdated syntax|deprecated]] in abc 2.1.

==== 10.6 Outdated lyrics alignment ====

Abc 2.1 introduced an extension to [[#alignment|lyrics alignment]] meaning that lyric lines (i.e. those using the ''w:'' field) no longer need to follow immediately after the line of [[#music code definition|music code]] to which they are attached, meaning that they can even be postponed to the end of the [[#tune body definition|tune body]].

// Examples: // The following two excerpts are equivalent in abc 2.1; under abc 2.0 and previous versions of the standard, only the first version would be legal. Note that there are 4 ([[#numbering|numbered]]) verses and hence 4 ''w:'' fields for each line of [[#music code definition|music code]].

In the first excerpt the lyrics follow immediately after the line of [[#music code definition|music code]] to which they are attached.

In the second excerpt, the lyrics are postponed to the end of the tune, arguably aiding readability substantially and meaning that each verse is contiguous. The [[#comment definition|comment lines]] in the second excerpt (those lines beginning with ''%'') are added for readability and are entirely optional.

  D2DE G2GG|A2EE ED-D2|c2cc B2AG|
  w:1\-~Si les ma-tins de gri-sail-le se tein-tent,*s'ils ont cou-leur en la
  w:2\-~Si mo-ri-bonds sont les rois en ri-pail-le,*si leurs pri-sons sont des
  w:3\-~Si mill' so-leils de mé-tal pren-nent voi-le,*dix mill' so-leils de cris-
  w:4\-~Si mill' bri-gands à l'en-can font par-ta-ge,*dix mille en-fants des tor-
  A2B^c d4|e2ee d2BA|G2EF GABc|
  w:nuit qui s'é-teint, vien-dront d'o-pal's len-de-mains, re-vien-dront les siè-cles
  w:ca-ges sans fond, vien-ne l'heur' des é-va-sions,******
  w:\-tal font mer-veille vienn'nt des lu-eurs de ver-meil,******
  w:\-rents font ar-gent, vien-nent des fleurs de sa-fran,******

  %
  % music
  %
  D2DE G2GG|A2EE ED-D2|c2cc B2AG|
  A2B^c d4|e2ee d2BA|G2EF GABc|
  %
  % lyrics
  %
  w:1\-~Si les ma-tins de gri-sail-le se tein-tent,*s'ils ont cou-leur en la
  +:nuit qui s'é-teint, vien-dront d'o-pal's len-de-mains, re-vien-dront les siè-cles
  %
  w:2\-~Si mo-ri-bonds sont les rois en ri-pail-le,*si leurs pri-sons sont des
  +:ca-ges sans fond, vien-ne l'heur' des é-va-sions,******
  %
  w:3\-~Si mill' so-leils de mé-tal pren-nent voi-le,*dix mill' so-leils de cris-
  +:\-tal font mer-veille vienn'nt des lu-eurs de ver-meil,******
  %
  w:4\-~Si mill' bri-gands à l'en-can font par-ta-ge,*dix mille en-fants des tor-
  +:\-rents font ar-gent, vien-nent des fleurs de sa-fran,******

Unfortunately, however, this extension is not fully backwards compatible with abc 2.0.

The difficulty arises when there is a line (or lines) of music code without lyrics attached, followed by a line with lyrics attached.

// Example: // In the following excerpt, using abc 2.0 the lyrics would be aligned with the adjacent [[#music code definition|music code]], i.e. with ''cdef''; using abc 2.1 they would be aligned at the start of the tune (or voice), i.e. with ''CDEF''.

  CDEF|
  FEDC|
  cdef|]
  w:these are lyr-ics

The work around for users who have files with such usage is either to avoid writing ''%abc-2.1'' as the [[#abc file identification|file identifier]] or to add an empty ''w:'' field after the final line of [[#music code definition|music code]] that should be without lyrics.

// Example: // The following excerpt should be treated the same way (with regard to lyrics alignment) under abc 2.0 and abc 2.1. Under abc 2.1 the empty ''w:'' field means that the lyrics are aligned with ''cdef''.

  CDEF|
  FEDC|
  w:
  cdef|]
  w:these are lyr-ics

==== 10.7 Other outdated syntax ====

=== 10.7.1 Disallowed voice overlay ===

Although the use of ampersand (''&'') to overlay voices (as introduced in abc 2.0) is still perfectly acceptable, this usage has been [[#outdated syntax|deprecated]] within ''w:'' lyric and ''s:'' symbol [[#information field definition|information fields]].

The reason is that, as far as is known, this usage has never been implemented in software and, furthermore, ''&'' symbols are widely used within ''w:'' fields in legacy abc files to indicate ampersands.

Instead lyrics are matched to notes without regard to the voice overlay - see [[#voice overlay|voice overlay]].

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 11. Stylesheet directives and pseudo-comments =====

==== 11.0 Introduction to directives ====

=== 11.0.1 Disclaimer ===

In the early days of abc, pseudo-comments (lines starting with ''<nowiki>%%</nowiki>'') were introduced as a means of adding software-specific information and formatting instructions into [[#abc file definition|abc files]]; because they started with a ''%'' symbol software that didn't recognise them would ignore them as a [[#comment definition|comment]].

In a valiant effort, abc 2.0 made an attempt to standardise these pseudo-comments with the introduction [[#stylesheet directive definition|stylesheet directives]] and the abc stylesheet specification. This  was described as "not part of the ABC specification itself" but as "an additional standard" containing directives to control how the content and structural information described by the abc code "is to be actually rendered, for example by a typesetting or player program".

Unfortunately, however, there are a very large number of pseudo-comment directives and not all of them are well-defined. Furthermore, some directives, in particular the [[#text directives|text directives]] and [[#accidental directives|accidental directives]], actually contain content and / or structural information (as opposed to rendering instructions).

Abc 2.1 has stepped away from this approach somewhat.

The pseudo-comments are still very much accepted as a way for developers to introduce experimental features and software-specific formatting instructions. However, when a directive gains acceptance, either by being implemented in more than one piece of software, or by its use in a substantial body of tunes, the aim is that the usage will be standardised and adopted in the standard and the ''I:'' [[#iinstruction|instruction]] form recommended in place of the ''<nowiki>%%</nowiki>'' pseudo-comment form.

In particular, it is intended that abc 2.3 will address markup and embedding and at that point a number of the text-based directives, together with other widely accepted forms, will be formally incorporated.

For the moment, section 11 is retained mostly unchanged from abc 2.0 (save for typo corrections) but, as a result of the foregoing, the whole of section 11 and all stylesheet directives should regarded as // VOLATILE//.

=== 11.0.2 Stylesheet directives ===

<html><a name="stylesheet_directive_definition"></a></html>A **stylesheet directive** is a line that starts with ''<nowiki>%%</nowiki>'', followed by a directive that gives instructions to typesetting or player programs.

// Examples: //
  %%papersize A4
  %%newpage
  %%setbarnb 10

Alternatively, any [[#stylesheet directive definition|stylesheet directive]] may be written as an ''[[#iinstruction|I:instruction]]'' field although this is not recommended for usages which have not been standardised (i.e. it is not recommended for any directives described in section 11).

// Examples: // Not recommended.
  I:papersize A4
  I:newpage
  I:setbarnb 10

[[#inline field definition|Inline field]] notation may be used to place a [[#stylesheet directive definition|stylesheet directive]] in the middle of a line of music:

// Example: //
  CDEFG|[I:setbarnb 10]ABc

If a program doesn't recognise a [[#stylesheet directive definition|stylesheet directive]], it should just ignore it.

It should be stressed that the [[#stylesheet directive definition|stylesheet directives]] are not formally part of the abc standard itself. Furthermore, the list of possible [[#stylesheet directive definition|directives]] is long and not standardised. They are provided by a variety of programs for specifying layout, text annotations, fonts, spacings, voice instruments, transposition and other details.

Strictly speaking, abc applications don't have to conform to the same set of [[#stylesheet directive definition|stylesheet directives]]. However, it is desirable that they do in order to make [[#abc file definition|abc files]] portable between different computer systems.

==== 11.1 Voice grouping ====

// VOLATILE: // This section is under review as part of the general discussion about [[#multiple_voices|multiple voices]] for abc 2.2. See also the [[#disclaimer|section 11 disclaimer]].

Basic syntax:

  %%score <voice-id1> <voice-id2> ... <voice-idn>

The score directive specifies which voices should be printed in the score and how they should be grouped on the staves.

Voices that are enclosed by parentheses ''()'' will go on one staff. Together they form a voice group. A voice that is not enclosed by parentheses forms a voice group on its own that will be printed on a separate staff.

If voice groups are enclosed by curly braces ''{}'', the corresponding staves will be connected by a big curly brace printed in front of the staves. Together they form a voice block. This format is used especially for typesetting keyboard music.

If voice groups or braced voice blocks are enclosed by brackets ''[]'', the corresponding staves will be connected by a big bracket printed in front of the staves. Together they form a voice block.

If voice blocks or voice groups are separated from each other by a ''|'' character, continued bar lines will be drawn between the associated staves.

Example:

  %%score Solo  [(S A) (T B)]  {RH | (LH1 LH2)}

If a single voice surrounded by two voice groups is preceded by a star (''*''), the voice is marked to be floating. This means that the voice won't be printed on it's own staff; rather the software should automatically determine, for each note of the voice, whether it should be printed on the preceding staff or on the following staff.

Software that does not support floating voices may simply print the voice on the preceding staff, as if it were part of the preceding voice group.

Examples:

  %%score {RH *M| LH}
  %%score {(RH1 RH2) *M| (LH1 LH2)}

String parts in an orchestral work are usually bracketed together and the top two (1st/2nd violins) then braced outside the bracket:

  %%score [{Vln1 | Vln2} | Vla | Vc | DB]

Any voices appearing in the [[#tune body definition|tune body]] will only be printed if it is mentioned in the score directive.

When the score directive occurs within the [[#tune body definition|tune body]], it resets the music generator, so that voices may appear and disappear for some period of time.

If no score directive is used, all voices that appear in the [[#tune body definition|tune body]] are printed on separate staves.

See [[#canzonettaabc|Canzonetta.abc]] for an extensive example.

An alternative directive to ''<nowiki>%%score</nowiki>'' is ''<nowiki>%%staves</nowiki>''.

Both ''<nowiki>%%score</nowiki>'' and ''<nowiki>%%staves</nowiki>'' directives accept the same parameters, but measure bar indications work the opposite way. Therefore, ''<nowiki>%%staves [S|A|T|B]</nowiki>'' is equivalent to ''<nowiki>%%score [S A T B]</nowiki>'' and means that continued bar lines are not drawn between the associated staves, while ''<nowiki>%%staves [S A T B]</nowiki>'' is equivalent to ''<nowiki>%%score [S|A|T|B]</nowiki>'' and means that they are drawn.

==== 11.2 Instrumentation directives ====

// VOLATILE: // See the [[#disclaimer|section 11 disclaimer]].

  %%MIDI voice [<ID>] [instrument=<integer> [bank=<integer>]] [mute]

Assigns a MIDI instrument to the indicated abc voice. The MIDI instruments are organized in banks of 128 instruments each. Both the instruments and the banks are numbered starting from one.

The General MIDI (GM) standard defines a portable, numbered set of 128 instruments (numbered from 1-128) - see http://www.midi.org/techspecs/gm1sound.php. The GM instruments can be used by selecting bank one. Since the contents of the other MIDI banks is platform dependent, it is highly recommended to only use the first MIDI bank in tunes that are to be distributed.

The default bank number is 1 (one).

// Example: // The following assigns GM instrument 59 (tuba) to voice 'Tb'.
  %%MIDI voice Tb instrument=59

If the voice ID is omitted, the instrument is assigned to the current voice.

// Example: //
  M:C
  L:1/8
  Q:1/4=66
  K:C
  V:Rueckpos
  %%MIDI voice instrument=53 bank=2
  A3B    c2c2    |d2e2    de/f/P^c3/d/|d8    |z8           |
  V:Organo
  %%MIDI voice instrument=73 bank=2
  z2E2-  E2AG    |F2E2    F2E2        |F6  F2|E2CD   E3F/G/|

You can use the keyword ''mute'' to mute the specified voice.

Some abc players can automatically generate an accompaniment based on the [[#chord_symbols|chord symbols]] specified in the melody line. To suggest a GM instrument for playing this accompaniment, use the following directive:

  %%MIDI chordprog 20 % Church organ

==== 11.3 Accidental directives ====

// VOLATILE: // This section is under active discussion. See also the [[#disclaimer|section 11 disclaimer]].

  %%propagate-accidentals not | octave | pitch

When set to ''not'', accidentals apply only to the note they're attached to. When set to ''octave'', accidentals also apply to all the notes of the same pitch in the same octave up to the end of the bar. When set to ''pitch'', accidentals also apply to all the notes of the same pitch in all octaves up to the end of the bar.

The default value is ''pitch''.

  %%writeout-accidentals none | added | all

When set to ''none'', modifying or explicit accidentals that appear in the key signature field (''K:'') are printed in the key signature. When set to ''added'', only the accidentals belonging to the mode indicated in the ''K:'' field, are printed in the key signature. Modifying or explicit accidentals are printed in front of the notes to which they apply. When set to ''all'', both the accidentals belonging to the mode and possible modifying or explicit accidentals are printed in front of the notes to which they apply; no key signature will be printed.

The default value is ''none''.

==== 11.4 Formatting directives ====

// VOLATILE: // See the [[#disclaimer|section 11 disclaimer]].

Typesetting programs should accept the set of directives in the next sections. The parameter of a directive can be a [[#text string definition|text string]], a logical value ''true'' or ''false'', an integer number, a number with decimals (just 'number' in the following), or a unit of length. Units can be expressed in cm, in, and pt (points, 1/72 inch).

The following directives should be self-explanatory.

=== 11.4.1 Page format directives ===

// VOLATILE: // See the [[#disclaimer|section 11 disclaimer]].

  %%pageheight       <length>
  %%pagewidth        <length>
  %%topmargin        <length>
  %%botmargin        <length>
  %%leftmargin       <length>
  %%rightmargin      <length>
  %%indent           <length>
  %%landscape        <logical>

=== 11.4.2 Font directives ===

// VOLATILE: // Font directives are due to be considered in abc 2.3 - see the [[#disclaimer|section 11 disclaimer]].

PostScript and PDF are the standard file formats for distributing printable material. For portability reasons, typesetters will use the PostScript font names. The size parameter should be an integer, but is optional.

  %%titlefont        <font name>  <size>
  %%subtitlefont     <font name>  <size>
  %%composerfont     <font name>  <size>
  %%partsfont        <font name>  <size>
  %%tempofont        <font name>  <size>
  %%gchordfont       <font name>  <size> % for chords symbols
  %%annotationfont   <font name>  <size> % for "^..." annotations
  %%infofont         <font name>  <size>
  %%textfont         <font name>  <size>
  %%vocalfont        <font name>  <size> % for w:
  %%wordsfont        <font name>  <size> % for W:

The specifiers ''$1'', ''$2'', ''$3'' and ''$4'' can be used to change the font within a [[#text string definition|text string]]. The font to be used can be specified with the ''<nowiki>%%setfont-n</nowiki>'' directives. ''$0'' resets the font to its default value. ''$$'' gives an actual dollar sign.

  %%setfont-1        <font name>  <size>
  %%setfont-2        <font name>  <size>
  %%setfont-3        <font name>  <size>
  %%setfont-4        <font name>  <size>

=== 11.4.3 Space directives ===

// VOLATILE: // See the [[#disclaimer|section 11 disclaimer]].

  %%topspace         <length>
  %%titlespace       <length>
  %%subtitlespace    <length>
  %%composerspace    <length>
  %%musicspace       <length> % between composer and 1st staff
  %%partsspace       <length>
  %%vocalspace       <length>
  %%wordsspace       <length>
  %%textspace        <length>
  %%infospace        <length>
  %%staffsep         <length> % between systems
  %%sysstaffsep      <length> % between staves in the same system
  %%barsperstaff     <integer>
  %%parskipfac       <number> % space between parts
  %%lineskipfac      <number> % space between lines of text
  %%stretchstaff     <logical>
  %%stretchlast      <logical>
  %%maxshrink        <number> % shrinking notes
  %%scale            <number>

=== 11.4.4 Measure directives ===

// VOLATILE: // See the [[#disclaimer|section 11 disclaimer]].

  %%measurefirst     <integer> % number of first measure
  %%barnumbers       <integer> % bar numbers every 'n' measures
  %%measurenb        <integer> % same as %%barnumbers
  %%measurebox       <logical>
  %%setbarnb         <integer> % set measure number

=== 11.4.5 Text directives ===

// VOLATILE: // Text directives are due to be considered in abc 2.3 - see the [[#disclaimer|section 11 disclaimer]].

The following directives can be used for inserting [[#typeset text definition|typeset text]] within an [[#abc file definition|abc file]].

  %%text             <text string>
  %%center           <text string>
  %%begintext
  %%...              <text string>
  %%endtext

Notes:
  * ''<nowiki>%%text</nowiki>'' prints the following text, treated as a [[#text string definition|text string]].
  * ''<nowiki>%%center</nowiki>'' prints the following text, treated as a [[#text string definition|text string]] and centred.
  * ''<nowiki>%%begintext</nowiki>'' and ''<nowiki>%%endtext</nowiki>'' mark a section of lines, each of which start with ''<nowiki>%%</nowiki>'', followed by some text. It is an alternative to several ''<nowiki>%%text</nowiki>'' lines. [//Important note:// some [[#abc extensions|extensions]] offered by abc software programs relax the rule that each line between ''<nowiki>%%begintext</nowiki>'' and ''<nowiki>%%endtext</nowiki>'' must start with ''<nowiki>%%</nowiki>''. Whilst this should not cause problems for [[#typeset text definition|typeset text]] between tunes, [[#typeset text definition|typeset text]] within a [[#tune header definition|tune header]] or [[#tune body definition|tune body]] should respect this rule and, in particular, must not introduce blank lines.]
See [[#further information about directives|further information about directives]] for more details and to find out about additional parameters for these directives.

// Recommendation for users: // If you are using text directives for tune-specific information, consider instead using one of the [[#bdfsbackground information|background information fields]] together with a ''<nowiki>%%</nowiki>writefields'' directive (see [[#information directives|information directives]]) so that the information can correctly identified by databasing software.

=== 11.4.6 Information directives ===

// VOLATILE: // The ''<nowiki>%%</nowiki>writefields'' directive and its formatting options are likely to be enhanced when markup is considered in abc 2.3. See also the [[#disclaimer|section 11 disclaimer]].

  %%writefields <list of field identifiers> [<logical>]

The ''<nowiki>%%</nowiki>writefields'' directive allows users to choose which string-type [[#information field definition|information fields]] appear in the printed score (see the [[#information fields|information fields]] table for a list of string-type fields). It is followed by a list of field identifiers and, optionally, the logical value ''true'' or ''false''. If the logical value is missing it is taken as ''true''.

The ''<nowiki>%%</nowiki>writefields'' directive also applies to certain instruction fields - namely ''X:reference number'', ''P:parts'' and ''Q:tempo''.

The default is "''<nowiki>%%</nowiki>writefields TCOPQwW''" meaning that the title (T), composer (C), origin (O), parts (P), tempo (Q), aligned words (w) and other words (W) are printed out by default (see [[#typesetting information fields|typesetting information fields]] for how these should be typeset). Each subseqent ''<nowiki>%%</nowiki>writefields'' directive combines with this list, rather than overriding it.

// Examples: //
  %%writefields O false         % the O field is not printed out - other defaults remain
  %%writefields X               % the X: field is printed out
  %%writefields BCDFGHNORSTWwXZ % all string-type fields are printed out
  
Typesetting software conforming to abc 2.1 may format the information strings in any way it chooses.

// Comment: // The ''<nowiki>%%</nowiki>writefields'' directive can be used in place of a number of directives introduced in abc 2.0:
  * "''<nowiki>%%</nowiki>writefields X''" can be used as an alternative to "''<nowiki>%%</nowiki>withxrefs''"
  * "''<nowiki>%%</nowiki>writefields Ww false''" can be used as an alternative to"''<nowiki>%%</nowiki>musiconly''"
  * "''<nowiki>%%</nowiki>writefields''" is a partial alternative to "''<nowiki>%%</nowiki>writehistory''" and "''<nowiki>%%</nowiki>infoname''"
See [[#further information about directives|further information about directives]] for more details of the 2.0 alternatives.

=== 11.4.7 Separation directives ===

// VOLATILE: // See the [[#disclaimer|section 11 disclaimer]].

  %%sep     % draw a horizontal separator, i.e. a line
  %%vskip   % insert some vertical space
  %%newpage % start a new page
See [[#further information about directives|further information about directives]] for more details and to find out about additional parameters for these directives.

=== 11.4.8 Miscellaneous directives ===

// VOLATILE: // See the [[#disclaimer|section 11 disclaimer]].

  %%exprabove        <logical>
  %%exprbelow        <logical>
  %%graceslurs       <logical> % grace notes slur to main note
  %%infoline         <logical> % rhythm and origin on the same line
  %%oneperpage       <logical>
  %%vocalabove       <logical>
  %%freegchord       <logical> % print '#', 'b' and '=' as they are
  %%printtempo       <logical>
  
The default value for these directives is false.

==== 11.5 Application specific directives ====

Applications may introduce their own directives. These directives should start with the name of the application, followed a colon, folowed by the name of the directive.

// Example: //
  %%noteedit:fontcolor blue

==== 11.6 Further information about directives ====

Since [[#stylesheet directive definition|stylesheet directives]] are not formally part of the abc standard, only a subset is included here. For additional directives and further information about those listed here, see the user manuals for programs that implement them, in particular:
  * the ''format.txt'' file included with [[http://moinejf.free.fr/|abcm2ps]]
  * the ''abcguide.txt'' file included with [[http://abc.sourceforge.net/abcMIDI/|abcMIDI]]
  * the ''abctab2ps'' [[http://www.lautengesellschaft.de/cdmm/userguide/userguide.html|User's guide]]

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 12. Dialects, strict / loose interpretation and backwards compatibility =====

Unfortunately a number of dialects of abc have arisen over the years, partly due to differences in implementation, together with unfinished drafts of the abc standard and ambiguities within it.

Version 2.1 of the standard aims to address this fragmentation of abc notation with a robust, but tolerant approach that should accommodate as many users as possible for several years to come and, as far as possible, restore backwards compatibility.

There are three main approaches:
  * the introduction of new ''I:'' directives to allow for preferences in dialects;
  * the concepts of strict and loose interpretation of the standard (together with recommendations to software developers for dealing with loose interpretations);
  * statistically-based decisions about default settings.

The aim is that, even under strict interpretation, most current dialects are still available via the new ''I:'' directives.

// Comment: // Dialects not available under strict interpretation are those where one symbol is used for two different purposes - for example, a ''!'' symbol used to denote both line-breaks and decorations; fortunately, of the 160,000 tunes currently available in the [[http://abcnotation.com/search|abcnotation.com tune search]] only around 60 (0.04%) employ this usage.

==== 12.1 Dialect differences ====

The main differences that have arisen are line-breaks, decoration delimiters and chord delimiters.

=== 12.1.1 Line-breaking dialects ===

By default, a (forced) [[#score line-break definition|score line-break]] is typeset by using a [[#code line-break definition|code line-break]] - see [[#typesetting_line-breaks|typesetting line-breaks]].

In the past the ''!'' symbol has instead been used to indicate [[#score line-break definition|score line-breaks]] - this symbol is now used to denote decorations.

// Comment: // The ''!'' symbol was introduced by abc2win, a very popular program in its time, although now moribund. Of the 160,000 tunes currently available in the [[http://abcnotation.com/search|abcnotation.com tune search]], only around 1,600 (10%) use the ! symbol to denote line-breaks.

Although the use of the ''!'' symbol for line-breaking is now [[#outdated syntax|deprecated]] (see [[#outdated line-breaking|outdated line-breaking]]), users who wish to continue using the ''!'' symbol for line-breaking merely need to include the "''I:linebreak !''" directive, either in the [[#file header definition|file header]] or individually tune by tune - see [[#typesetting_line-breaks|typesetting line-breaks]].

// Example: // The following abc code would result in two lines of music.
  I:linebreak !
  K:G
  ABC DEF|!FED ABC|]
  
Finally a new line-breaking symbol, ''$'', has been introduced as an alternative to using [[#code line-break definition|code line-breaks]].

// Comment: // The ''$'' symbol is effectively a replacement for ''!''. It is aimed at those users who want ''!'' as the decoration delimiter but who prefer to use [[#code line-break definition|code line-breaks]] without generating corresponding [[#score line-break definition|score line-breaks]].

=== 12.1.2 Decoration dialects ===

Decorations are delimited using the ''!'' symbol - see [[#decorations|decorations]].

In the past the ''+'' symbol has instead been used to denote decorations - this symbol is now [[#outdated syntax|deprecated]] for decorations.

// Comment: // Decorations were first introduced in draft standard 1.7.6 (which was never formally adopted) with the ''!'' symbol. In abc 2.0 (adopted briefly whilst discussions about abc 2.1 were taking place) this was changed to the ''+'' symbol. Neither are in widespread use, but the ''!'' symbol is much more common - of the 160,000 tunes currently available in the [[http://abcnotation.com/search|abcnotation.com tune search]], only around 100 (0.07%) use the ''+'' symbol to delimit decorations, whereas around 1,350 (0.85%) use the ''!'' symbol.

Users who wish to continue using the ''+'' symbol for decorations merely need to include the "''I:decoration +''" directive, either in the [[#file header definition|file header]] or individually tune by tune - see [[#decorations|decorations]]. All ''+...+'' decorations will then be treated as if they were the corresponding ''!...!'' decoration and any ''!...!'' decorations will generate an error message.

Note that the "''I:decoration +''" directive is automatically invoked by the "''I:linebreak !''" directive. Also note that the ''!+!'' decoration has no ''+'' equivalent - ''+plus+'' should be used instead.

// Recommendation for users: // Given the very small uptake of the ''+'' symbol for decorations, "''I:decoration +''" directive is not recommended. However, it is retained for users who wish to use the ''!'' symbol for line-breaking in legacy [[#abc file definition|abc files]].

For completeness the "''I:decoration !''", the default setting, is also available to allow individual tunes to use ''!...!'' decorations in a file where "''I:decoration +''" is set in the [[#file header definition|file header]].

=== 12.1.3 Chord dialects ===

Chords are delimited using ''[]'' symbols - see [[#chords_and_unisons|chords and unisons]].

In the past the ''+'' symbol has instead been used to delimit chords - this symbol is no longer in use for chords.

// Comment: // In early versions of the abc standard (1.2 to 1.5), chords were delimited with ''+'' symbols. However, this made it hard to see where one chord ended and another began and the chord delimiters were changed to ''[]'' in 1.6 (November 1996). Of the 160,000 tunes currently available in the [[http://abcnotation.com/search|abcnotation.com tune search]], only around 420 (0.25%) use the ''+'' symbol to delimit chords. Given the small uptake and the successful introduction of the ''[]'' symbols, there is no ''I:'' directive available which allows the use of ''+'' symbols and this usage is now [[#outdated syntax|obsolete]].

==== 12.2 Loose interpretation ====

// Comment: // There are around 160,000 tunes currently available in the [[http://abcnotation.com/search|abcnotation.com tune search]] - loose interpretation of the abc standard maintains backwards compatibility without any changes required for this huge and valuable resource.

Any [[#abc file definition|abc file]] without a version number, or with a version number of 2.0 or less (see [[#abc_file_identification|abc file identification]] and [[#version_field|version field]]), should be interpreted loosely. Developers should do their best to provide programs that understand legacy [[#abc file definition|abc files]], but users should be aware that loose interpretations may different from one abc program to another.

// Recommendation for users: // Try to avoid loose interpretation if possible; loose interpretation means that if you pass abc notated tunes on to friends, or post them on the web, they may not appear as you hoped.

// Recommendation 1 for developers: // Do your best! The most difficult tunes to deal with are those which use the same symbol for two different purposes - in particular the ! symbol for both decorations and line-breaking. Here is an algorithm for helping to deal with ''!decoration!'' syntax and ''!'' line-breaks in the same tune:

When encountering a !, scan forward. If you find another ! before encountering any of ''|[:]'', a space, or the end of a line, then you have a decoration, otherwise it is a line-break. 

// Recommendation 2 for developers: // Although moving towards strict interpretations should make life easier for everybody (developers and users alike), you should allow users to switch easily between strict and loose interpretation, perhaps via a command line switch or a GUI check-box. For example, a user who imports an old [[#abc file definition|abc file]] may wish to see how it would be interpreted strictly, perhaps to establish how many strict errors need fixing.

==== 12.3 Strict interpretation ====

Any [[#abc file definition|abc file]] with an abc version number greater than or equal to 2.1 (see [[#abc_file_identification|abc file identification]] and [[#version_field|version field]]) should be interpreted strictly, with errors indicated to the user as such.

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 13. Sample abc tunes =====

==== 13.1 English.abc ====

  %abc-2.1
  H:This file contains some example English tunes
  % note that the comments (like this one) are to highlight usages
  %  and would not normally be included in such detail
  O:England             % the origin of all tunes is England
  
  X:1                   % tune no 1
  T:Dusty Miller, The   % title
  T:Binny's Jig         % an alternative title
  C:Trad.               % traditional
  R:DH                  % double hornpipe
  M:3/4                 % meter
  K:G                   % key
  B>cd BAG|FA Ac BA|B>cd BAG|DG GB AG:|
  Bdd gfg|aA Ac BA|Bdd gfa|gG GB AG:|
  BG G/2G/2G BG|FA Ac BA|BG G/2G/2G BG|DG GB AG:|
  W:Hey, the dusty miller, and his dusty coat;
  W:He will win a shilling, or he spend a groat.
  W:Dusty was the coat, dusty was the colour;
  W:Dusty was the kiss, that I got frae the miller.
  
  X:2
  T:Old Sir Simon the King
  C:Trad.
  S:Offord MSS          % from Offord manuscript
  N:see also Playford   % reference note
  M:9/8
  R:SJ                  % slip jig
  N:originally in C     % transcription note
  K:G
  D|GFG GAG G2D|GFG GAG F2D|EFE EFE EFG|A2G F2E D2:|
  D|GAG GAB d2D|GAG GAB c2D|[1 EFE EFE EFG|A2G F2E D2:|\ % no line-break in score
  M:12/8                % change of meter
  [2 E2E EFE E2E EFG|\  % no line-break in score
  M:9/8                 % change of meter
  A2G F2E D2|]
  
  X:3
  T:William and Nancy
  T:New Mown Hay
  T:Legacy, The
  C:Trad.
  O:England; Gloucs; Bledington % place of origin
  B:Sussex Tune Book            % can be found in these books
  B:Mally's Cotswold Morris vol.1 2
  D:Morris On                   % can be heard on this record
  P:(AB)2(AC)2A                 % play the parts in this order
  M:6/8
  K:G                        
  [P:A] D|"G"G2G GBd|"C"e2e "G"dBG|"D7"A2d "G"BAG|"C"E2"D7"F "G"G2:|
  [P:B] d|"G"e2d B2d|"C"gfe "G"d2d| "G"e2d    B2d|"C"gfe    "D7"d2c|
          "G"B2B Bcd|"C"e2e "G"dBG|"D7"A2d "G"BAG|"C"E2"D7"F "G"G2:|
  % changes of meter, using inline fields
  [T:Slows][M:4/4][L:1/4][P:C]"G"d2|"C"e2 "G"d2|B2 d2|"Em"gf "A7"e2|"D7"d2 "G"d2|\
         "C"e2 "G"d2|[M:3/8][L:1/8] "G"B2 d |[M:6/8] "C"gfe "D7"d2c|
          "G"B2B Bcd|"C"e2e "G"dBG|"D7"A2d "G"BAG|"C"E2"D7"F "G"G2:|

==== 13.2 Strspys.abc ====

  %abc-2.1
  M:4/4
  O:Scottish
  R:Strathspey
  
  X:1
  T:A. A. Cameron's
  K:D
  e<A A2 B>G d>B|e<A A2 d>g (3fed|e<A A2 B>G d>B|B<G G>B d>g (3fed:|
  B<e e>f g>e a>f|B<e e>f g>e (3fed|B<e e>f g>e a>f|d<B G>B d>g (3fed:|
  
  X:2
  T:Atholl Brose
  % in this example, which reproduces Highland Bagpipe gracing,
  %  the large number of grace notes mean that it is more convenient to be specific about
  %  score line-breaks (using the $ symbol), rather than using code line breaks to indicate them
  I:linebreak $
  K:D
  {gcd}c<{e}A {gAGAG}A2 {gef}e>A {gAGAG}Ad|
  {gcd}c<{e}A {gAGAG}A>e {ag}a>f {gef}e>d|
  {gcd}c<{e}A {gAGAG}A2 {gef}e>A {gAGAG}Ad|
  {g}c/d/e {g}G>{d}B {gf}gG {dc}d>B:|$
  {g}c<e {gf}g>e {ag}a>e {gf}g>e|
  {g}c<e {gf}g>e {ag}a2 {GdG}a>d|
  {g}c<e {gf}g>e {ag}a>e {gf}g>f|
  {gef}e>d {gf}g>d {gBd}B<{e}G {dc}d>B|
  {g}c<e {gf}g>e {ag}a>e {gf}g>e|
  {g}c<e {gf}g>e {ag}a2 {GdG}ad|
  {g}c<{GdG}e {gf}ga {f}g>e {g}f>d|
  {g}e/f/g {Gdc}d>c {gBd}B<{e}G {dc}d2|]

==== 13.3 Reels.abc ====

  %abc-2.1
  M:4/4
  O:Irish
  R:Reel
  
  X:1
  T:Untitled Reel
  C:Trad.
  K:D
  eg|a2ab ageg|agbg agef|g2g2 fgag|f2d2 d2:|\
  ed|cecA B2ed|cAcA E2ed|cecA B2ed|c2A2 A2:|
  K:G
  AB|cdec BcdB|ABAF GFE2|cdec BcdB|c2A2 A2:|
  
  X:2
  T:Kitchen Girl
  C:Trad.
  K:D
  [c4a4] [B4g4]|efed c2cd|e2f2 gaba|g2e2 e2fg|
  a4 g4|efed cdef|g2d2 efed|c2A2 A4:|
  K:G
  ABcA BAGB|ABAG EDEG|A2AB c2d2|e3f edcB|ABcA BAGB|
  ABAG EGAB|cBAc BAG2|A4 A4:|

==== 13.4 Canzonetta.abc ====

  %abc-2.1
  %%pagewidth      21cm
  %%pageheight     29.7cm
  %%topspace       0.5cm
  %%topmargin      1cm
  %%botmargin      0cm
  %%leftmargin     1cm
  %%rightmargin    1cm
  %%titlespace     0cm
  %%titlefont      Times-Bold 32
  %%subtitlefont   Times-Bold 24
  %%composerfont   Times 16
  %%vocalfont      Times-Roman 14
  %%staffsep       60pt
  %%sysstaffsep    20pt
  %%musicspace     1cm
  %%vocalspace     5pt
  %%measurenb      0
  %%barsperstaff   5
  %%scale          0.7
  X: 1
  T: Canzonetta a tre voci
  C: Claudio Monteverdi (1567-1643)
  M: C
  L: 1/4
  Q: "Andante mosso" 1/4 = 110
  %%score [1 2 3]
  V: 1 clef=treble name="Soprano"sname="A"
  V: 2 clef=treble name="Alto"   sname="T"
  V: 3 clef=bass middle=d name="Tenor"  sname="B"
  %%MIDI program 1 75 % recorder
  %%MIDI program 2 75
  %%MIDI program 3 75
  K: Eb
  % 1 - 4
  [V: 1] |:z4  |z4  |f2ec         |_ddcc        |
  w: Son que-sti~i cre-spi cri-ni~e
  w: Que-sti son gli~oc-chi che mi-
  [V: 2] |:c2BG|AAGc|(F/G/A/B/)c=A|B2AA         |
  w: Son que-sti~i cre-spi cri-ni~e que - - - - sto~il vi-so e
  w: Que-sti son~gli oc-chi che mi-ran - - - - do fi-so mi-
  [V: 3] |:z4  |f2ec|_ddcf        |(B/c/_d/e/)ff|
  w: Son que-sti~i cre-spi cri-ni~e que - - - - sto~il
  w: Que-sti son~gli oc-chi che mi-ran - - - - do
  % 5 - 9
  [V: 1] cAB2     |cAAA |c3B|G2!fermata!Gz ::e4|
  w: que-sto~il vi-so ond' io ri-man-go~uc-ci-so. Deh,
  w: ran-do fi-so, tut-to re-stai con-qui-so.
  [V: 2] AAG2     |AFFF |A3F|=E2!fermata!Ez::c4|
  w: que-sto~il vi-so ond' io ri-man-go~uc-ci-so. Deh,
  w: ran-do fi-so tut-to re-stai con-qui-so.
  [V: 3] (ag/f/e2)|A_ddd|A3B|c2!fermata!cz ::A4|
  w: vi - - - so ond' io ti-man-go~uc-ci-so. Deh,
  w: fi - - - so tut-to re-stai con-qui-so.
  % 10 - 15
  [V: 1] f_dec |B2c2|zAGF  |\
  w: dim-me-lo ben mi-o, che que-sto\
  =EFG2          |1F2z2:|2F8|] % more notes
  w: sol de-si-o_. % more lyrics
  [V: 2] ABGA  |G2AA|GF=EF |(GF3/2=E//D//E)|1F2z2:|2F8|]
  w: dim-me-lo ben mi-o, che que-sto sol de-si - - - - o_.
  [V: 3] _dBc>d|e2AF|=EFc_d|c4             |1F2z2:|2F8|]
  w: dim-me-lo ben mi-o, che que-sto sol de-si-o_.

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>

===== 14. Appendix =====

==== 14.1 Supported accents & ligatures ====

Conforming abc software must support the following encodings for accents and ligatures. It may offer support for other named entities and hex unicode representations (which may be adopted by the standard at a later date).

For more details see [[#text strings|text strings]] and for further information see, for example:
  * http://www.w3.org/TR/html4/sgml/entities.html
  * http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
  * http://en.wikipedia.org/wiki/List_of_Unicode_characters
  * http://www.fileformat.info/info/unicode/char/search.htm - unicode character search

**Accents:**

^  Character  ^  Mnemonic  ^  Named html entity  ^  16-bit hex unicode  ^
|  <html>&Agrave;</html>  |  ''\`A''  |  ''&Agrave;''   |  ''\u00c0''  |
|  <html>&agrave;</html>  |  ''\`a''  |  ''&agrave;''   |  ''\u00e0''  |
|  <html>&Egrave;</html>  |  ''\`E''  |  ''&Egrave;''   |  ''\u00c8''  |
|  <html>&egrave;</html>  |  ''\`e''  |  ''&egrave;''   |  ''\u00e8''  |
|  <html>&Igrave;</html>  |  ''\`I''  |  ''&Igrave;''   |  ''\u00cc''  |
|  <html>&igrave;</html>  |  ''\`i''  |  ''&igrave;''   |  ''\u00ec''  |
|  <html>&Ograve;</html>  |  ''\`O''  |  ''&Ograve;''   |  ''\u00d2''  |
|  <html>&ograve;</html>  |  ''\`o''  |  ''&ograve;''   |  ''\u00f2''  |
|  <html>&Ugrave;</html>  |  ''\`U''  |  ''&Ugrave;''   |  ''\u00d9''  |
|  <html>&ugrave;</html>  |  ''\`u''  |  ''&ugrave;''   |  ''\u00f9''  |
|  <html>&Aacute;</html>  |  ''\'A''  |  ''&Aacute;''   |  ''\u00c1''  |
|  <html>&aacute;</html>  |  ''\'a''  |  ''&aacute;''   |  ''\u00e1''  |
|  <html>&Eacute;</html>  |  ''\'E''  |  ''&Eacute;''   |  ''\u00c9''  |
|  <html>&eacute;</html>  |  ''\'e''  |  ''&eacute;''   |  ''\u00e9''  |
|  <html>&Iacute;</html>  |  ''\'I''  |  ''&Iacute;''   |  ''\u00cd''  |
|  <html>&iacute;</html>  |  ''\'i''  |  ''&iacute;''   |  ''\u00ed''  |
|  <html>&Oacute;</html>  |  ''\'O''  |  ''&Oacute;''   |  ''\u00d3''  |
|  <html>&oacute;</html>  |  ''\'o''  |  ''&oacute;''   |  ''\u00f3''  |
|  <html>&Uacute;</html>  |  ''\'U''  |  ''&Uacute;''   |  ''\u00da''  |
|  <html>&uacute;</html>  |  ''\'u''  |  ''&uacute;''   |  ''\u00fa''  |
|  <html>&Yacute;</html>  |  ''\'Y''  |  ''&Yacute;''   |  ''\u00dd''  |
|  <html>&yacute;</html>  |  ''\'y''  |  ''&yacute;''   |  ''\u00fd''  |
|  <html>&Acirc;</html>   |  ''\^A''  |  ''&Acirc;''    |  ''\u00c2''  |
|  <html>&acirc;</html>   |  ''\^a''  |  ''&acirc;''    |  ''\u00e2''  |
|  <html>&Ecirc;</html>   |  ''\^E''  |  ''&Ecirc;''    |  ''\u00ca''  |
|  <html>&ecirc;</html>   |  ''\^e''  |  ''&ecirc;''    |  ''\u00ea''  |
|  <html>&Icirc;</html>   |  ''\^I''  |  ''&Icirc;''    |  ''\u00ce''  |
|  <html>&icirc;</html>   |  ''\^i''  |  ''&icirc;''    |  ''\u00ee''  |
|  <html>&Ocirc;</html>   |  ''\^O''  |  ''&Ocirc;''    |  ''\u00d4''  |
|  <html>&ocirc;</html>   |  ''\^o''  |  ''&ocirc;''    |  ''\u00f4''  |
|  <html>&Ucirc;</html>   |  ''\^U''  |  ''&Ucirc;''    |  ''\u00db''  |
|  <html>&ucirc;</html>   |  ''\^u''  |  ''&ucirc;''    |  ''\u00fb''  |
|  <html>&Ycirc;</html>   |  ''\^Y''  |  ''&Ycirc;''    |  ''\u0176''  |
|  <html>&ycirc;</html>   |  ''\^y''  |  ''&ycirc;''    |  ''\u0177''  |
|  <html>&Atilde;</html>  |  ''\~A''  |  ''&Atilde;''   |  ''\u00c3''  |
|  <html>&atilde;</html>  |  ''\~a''  |  ''&atilde;''   |  ''\u00e3''  |
|  <html>&Ntilde;</html>  |  ''\~N''  |  ''&Ntilde;''   |  ''\u00d1''  |
|  <html>&ntilde;</html>  |  ''\~n''  |  ''&ntilde;''   |  ''\u00f1''  |
|  <html>&Otilde;</html>  |  ''\~O''  |  ''&Otilde;''   |  ''\u00d5''  |
|  <html>&otilde;</html>  |  ''\~o''  |  ''&otilde;''   |  ''\u00f5''  |
|  <html>&Auml;</html>    |  ''\"A''  |  ''&Auml;''     |  ''\u00c4''  |
|  <html>&auml;</html>    |  ''\"a''  |  ''&auml;''     |  ''\u00e4''  |
|  <html>&Euml;</html>    |  ''\"E''  |  ''&Euml;''     |  ''\u00cb''  |
|  <html>&euml;</html>    |  ''\"e''  |  ''&euml;''     |  ''\u00eb''  |
|  <html>&Iuml;</html>    |  ''\"I''  |  ''&Iuml;''     |  ''\u00cf''  |
|  <html>&iuml;</html>    |  ''\"i''  |  ''&iuml;''     |  ''\u00ef''  |
|  <html>&Ouml;</html>    |  ''\"O''  |  ''&Ouml;''     |  ''\u00d6''  |
|  <html>&ouml;</html>    |  ''\"o''  |  ''&ouml;''     |  ''\u00f6''  |
|  <html>&Uuml;</html>    |  ''\"U''  |  ''&Uuml;''     |  ''\u00dc''  |
|  <html>&uuml;</html>    |  ''\"u''  |  ''&uuml;''     |  ''\u00fc''  |
|  <html>&Yuml;</html>    |  ''\"Y''  |  ''&Yuml;''     |  ''\u0178''  |
|  <html>&yuml;</html>    |  ''\"y''  |  ''&yuml;''     |  ''\u00ff''  |
|  <html>&Ccedil;</html>  |  ''\cC''  |  ''&Ccedil;''   |  ''\u00c7''  |
|  <html>&ccedil;</html>  |  ''\cc''  |  ''&ccedil;''   |  ''\u00e7''  |
|  <html>&Aring;</html>   |  ''\AA''  |  ''&Aring;''    |  ''\u00c5''  |
|  <html>&aring;</html>   |  ''\aa''  |  ''&aring;''    |  ''\u00e5''  |
|  <html>&Oslash;</html>  |  ''\/O''  |  ''&Oslash;''   |  ''\u00d8''  |
|  <html>&oslash;</html>  |  ''\/o''  |  ''&oslash;''   |  ''\u00f8''  |
|  <html>&Abreve;</html>  |  ''\uA''  |  ''&Abreve;''   |  ''\u0102''  |
|  <html>&abreve;</html>  |  ''\ua''  |  ''&abreve;''   |  ''\u0103''  |
|  <html>&#x114;</html>   |  ''\uE''  |  not available  |  ''\u0114''  |
|  <html>&#x115;</html>   |  ''\ue''  |  not available  |  ''\u0115''  |
|  <html>&Scaron;</html>  |  ''\vS''  |  ''&Scaron;''   |  ''\u0160''  |
|  <html>&scaron;</html>  |  ''\vs''  |  ''&scaron;''   |  ''\u0161''  |
|  <html>&Zcaron;</html>  |  ''\vZ''  |  ''&Zcaron;''   |  ''\u017d''  |
|  <html>&zcaron;</html>  |  ''\vz''  |  ''&zcaron;''   |  ''\u017e''  |
|  <html>&#x150;</html>   |  ''\HO''  |  not available  |  ''\u0150''  |
|  <html>&#x151;</html>   |  ''\Ho''  |  not available  |  ''\u0151''  |
|  <html>&#x170;</html>   |  ''\HU''  |  not available  |  ''\u0170''  |
|  <html>&#x171;</html>   |  ''\Hu''  |  not available  |  ''\u0171''  |

**Ligatures, etc:**

^  Character  ^  Mnemonic  ^  Named html entity  ^  16-bit hex unicode  ^
|  <html>&AElig;</html>   |  ''\AE''  |  ''&AElig;''    |  ''\u00c6''  |
|  <html>&aelig;</html>   |  ''\ae''  |  ''&aelig;''    |  ''\u00e6''  |
|  <html>&OElig;</html>   |  ''\OE''  |  ''&OElig;''    |  ''\u0152''  |
|  <html>&oelig;</html>   |  ''\oe''  |  ''&oelig;''    |  ''\u0153''  |
|  <html>&szlig;</html>   |  ''\ss''  |  ''&szlig;''    |  ''\u00df''  |
|  <html>&ETH;</html>     |  ''\DH''  |  ''&ETH;''      |  ''\u00d0''  |
|  <html>&eth;</html>     |  ''\dh''  |  ''&eth;''      |  ''\u00f0''  |
|  <html>&THORN;</html>   |  ''\TH''  |  ''&THORN;''    |  ''\u00de''  |
|  <html>&thorn;</html>   |  ''\th''  |  ''&thorn;''    |  ''\u00fe''  |

==== 14.2 Errata ====

The following corrections have been made since the standard was published:
  * [[#terminology definitions|Section 1.1.1 Terminology / definitions]]: The definition of //VOLATILE// has been clarified; it is used to indicate "sections which are under active discussion and/or are likely to change in some future version of the standard" rather than "sections which are under active discussion or likely to change at some point in the future" (8th Jan 2012).
  * [[#typesetting line-breaks|Section 6.1.1 Typesetting line-breaks]]: Typo: ''setbarno'' corrected to ''setbarnb'' in two places (8th Jan 2012).
  * [[#text strings|Section 8.2 Text strings]]: Typos for accent mnemonics (cedilla and ring): "''\,C \,c''" and "''\oA \oa''" corrected to "''\cC \cc''" and "''\AA \aa''", respectively, as per [[#supported accents ligatures|Section 14.1 Supported accents & ligatures]] (8th Jan 2012).\\ // TODO: // ''\,'' and ''\o'' are non-standard accent mnemonics introduced in abc 2.0; however, it is probably sensible to support them in addition to the standard, but less memorable, ''\c'' and ''\a''.
  * [[#information directives|Section 11.4.6 Information directives]]: The statement "Note that the ''<nowiki>%%</nowiki>writefields'' directive does not apply to instruction-type fields, such as parts (P) and tempo (Q)" has now been removed, as it conflicted with other information in the same section (8th Jan 2012).
  * [[#chord symbols|Section 4.18 Chord symbols]]: Typo: ''sustained'' corrected to ''suspended'' (26th May 2012).

----
<HTML><p align="center" style="font-size:75%;"><a href="#">Back to top</a></p></HTML>
./doc/abc_v2.1_toc.txt	[[[1
134
Table of Contents
  * introduction | 1. Introduction]]
    * how_to_read_this_document | 1.1 How to read this document]]
      * terminology_definitions | 1.1.1 Terminology / definitions]]
    * how_to_avoid_reading_this document | 1.2 How to avoid reading this document]]
    * abc_tutorials | 1.3 Abc tutorials]]
    * abc_extensions | 1.4 Abc extensions]]
    * further_information_and_changes | 1.5 Further information and changes]]
    * document_locations | 1.6 Document locations]]
  * abc_files_tunes_and_fragments | 2. Abc files, tunes and fragments]]
    * abc_file_identification | 2.1 Abc file identification]]
    * abc_file_structure | 2.2 Abc file structure]]
      * abc_tune | 2.2.1 Abc tune]]
      * file_header | 2.2.2 File header]]
      * free_text_and_typeset_text | 2.2.3 Free text and typeset text]]
      * empty_lines_and_line-breaking | 2.2.4 Empty lines and line-breaking]]
      * comments_and_remarks | 2.2.5 Comments and remarks]]
      * continuation_of_input_lines | 2.2.6 Continuation of input lines]]
    * embedded_abc_and_abc_fragments | 2.3 Embedded abc and abc fragments]]
      * embedded_abc_fragment | 2.3.1 Embedded abc fragment]]
      * embedded_abc_tune | 2.3.2 Embedded abc tune]]
      * embedded_file_header | 2.3.3 Embedded file header]]
      * embedded_abc_file | 2.3.4 Embedded abc file]]
  * information_fields | 3. Information fields]]
    * description_of_information_fields | 3.1 Description of information fields]]
      * xreference_number | 3.1.1 X: - reference number]]
      * ttune_title | 3.1.2 T: - tune title]]
      * ccomposer | 3.1.3 C: - composer]]
      * oorigin | 3.1.4 O: - origin]]
      * aarea | 3.1.5 A: - area]]
      * mmeter | 3.1.6 M: - meter]]
      * lunit note length | 3.1.7 L: - unit note length]]
      * qtempo | 3.1.8 Q: - tempo]]
      * pparts | 3.1.9 P: - parts]]
      * ztranscription | 3.1.10 Z: - transcription]]
      * nnotes | 3.1.11 N: - notes]]
      * ggroup | 3.1.12 G: - group]]
      * hhistory | 3.1.13 H: - history]]
      * kkey | 3.1.14 K: - key]]
      * rrhythm | 3.1.15 R: - rhythm]]
      * bdfsbackground_information | 3.1.16 B:, D:, F:, S: - background information]]
      * iinstruction | 3.1.17 I: - instruction]]
      * other_fields | 3.1.18 Other fields]]
    * use_of_fields_within_the_tune_body | 3.2 Use of fields within the tune body]]
    * field_continuation | 3.3 Field continuation]]
  * the_tune_body | 4. The tune body]]
    * pitch | 4.1 Pitch]]
    * accidentals | 4.2 Accidentals]]
    * note_lengths | 4.3 Note lengths]]
    * broken_rhythm | 4.4 Broken rhythm]]
    * rests | 4.5 Rests]]
    * clefs_and_transposition | 4.6 Clefs and transposition]]
    * beams | 4.7 Beams]]
    * repeat_bar_symbols | 4.8 Repeat/bar symbols]]
    * first_and_second_repeats | 4.9 First and second repeats]]
    * variant_endings | 4.10 Variant endings]]
    * ties_and_slurs | 4.11 Ties and slurs]]
    * grace_notes | 4.12 Grace notes]]
    * duplets_triplets_quadruplets_etc | 4.13 Duplets, triplets, quadruplets, etc.]]
    * decorations | 4.14 Decorations]]
    * symbol_lines | 4.15 Symbol lines]]
    * redefinable_symbols | 4.16 Redefinable symbols]]
    * chords_and_unisons | 4.17 Chords and unisons]]
    * chord_symbols | 4.18 Chord symbols]]
    * annotations | 4.19 Annotations]]
    * order_of_abc_constructs | 4.20 Order of abc constructs]]
  * lyrics | 5. Lyrics]]
    * alignment | 5.1 Alignment]]
    * verses | 5.2 Verses]]
    * numbering | 5.3 Numbering]]
  * typesetting_and_playback | 6. Typesetting and playback]]
    * typesetting | 6.1 Typesetting]]
      * typesetting_line-breaks | 6.1.1 Typesetting line-breaks]]
      * typesetting_extra_space | 6.1.2 Typesetting extra space]]
      * typesetting_information_fields | 6.1.3 Typesetting information fields]]
    * playback | 6.2 Playback]]
  * multiple_voices | 7. Multiple voices]]
    * voice_properties | 7.1 Voice properties]]
    * breaking_lines | 7.2 Breaking lines]]
    * inline_fields | 7.3 Inline fields]]
    * voice_overlay | 7.4 Voice overlay]]
  * abc_data_format | 8. abc data format]]
    * tune_body | 8.1 Tune body]]
    * text_strings | 8.2 Text strings]]
  * macros | 9. Macros]]
    * static_macros | 9.1 Static macros]]
    * transposing_macros | 9.2 Transposing macros]]
  * outdated_syntax | 10. Outdated syntax]]
    * outdated_information field syntax | 10.1 Outdated information field syntax]]
    * outdated_dialects | 10.2 Outdated dialects]]
      * outdated_line-breaking | 10.2.1 Outdated line-breaking]]
      * outdated_decorations | 10.2.2 Outdated decorations]]
      * outdated_chords | 10.2.3 Outdated chords]]
    * outdated_continuations | 10.3 Outdated continuations]]
    * outdated_directives | 10.4 Outdated directives]]
    * outdated_file_structure | 10.5 Outdated file structure]]
      * outdated_tune_header_syntax | 10.5.1 Outdated tune header syntax]]
      * outdated_defaults | 10.5.1 Outdated defaults]]
    * outdated_lyrics_alignment | 10.6 Outdated lyrics alignment]]
    * other_outdated_syntax | 10.7 Other outdated syntax]]
      * disallowed_voice_overlay | 10.7.1 Disallowed voice overlay]]
  * stylesheet_directives_and_pseudo-comments | 11. Stylesheet directives and pseudo-comments]]
    * introduction_to_directives | 11.0 Introduction to directives]]
      * disclaimer | 11.0.1 Disclaimer]]
      * stylesheet_directives | 11.0.2 Stylesheet directives]]
    * voice_grouping | 11.1 Voice grouping]]
    * instrumentation_directives | 11.2 Instrumentation directives]]
    * accidental_directives | 11.3 Accidental directives]]
    * formatting_directives | 11.4 Formatting directives]]
      * page_format_directives | 11.4.1 Page format directives]]
      * font_directives | 11.4.2 Font directives]]
      * space_directives | 11.4.3 Space directives]]
      * measure_directives | 11.4.4 Measure directives]]
      * text_directives | 11.4.5 Text directives]]
      * information_directives | 11.4.6 Information directives]]
      * separation_directives | 11.4.7 Separation directives]]
      * miscellaneous_directives | 11.4.8 Miscellaneous directives]]
    * application_specific_directives | 11.5 Application specific directives]]
    * further_information_about_directives | 11.6 Further information about directives]]
  * dialects_strict_loose_interpretation_and_backwards_compatibility | 12. Dialects, strict / loose interpretation and backwards compatibility]]
    * dialect_differences | 12.1 Dialect differences]]
      * line-breaking_dialects | 12.1.1 Line-breaking dialects]]
      * decoration_dialects | 12.1.2 Decoration dialects]]
      * chord_dialects | 12.1.3 Chord dialects]]
    * loose_interpretation | 12.2 Loose interpretation]]
    * strict_interpretation | 12.3 Strict interpretation]]
  * sample_abc_tunes | 13. Sample abc tunes]]
    * englishabc | 13.1 English.abc]]
    * strspysabc | 13.2 Strspys.abc]]
    * reelsabc | 13.3 Reels.abc]]
    * canzonettaabc | 13.4 Canzonetta.abc]]
  * appendix | 14. Appendix]]
    * supported_accents_&_ligatures | 14.1 Supported accents & ligatures]]
    * errata | 14.2 Errata]]
./doc/pi_abc.txt	[[[1
387
*abc-vim.txt*    For Vim version 7.3.  Last change: 2012 Jun 14

                  -------------------------------
                  abc Music Notation, version 2.1
                  -------------------------------

Author:  Lee Savide <laughingman182@gmail.com>, or <laughingman182@yahoo.com>
Copyright: (c) 2012 by Lee Savide                *abc-vim-copyright*
    |pi_abc.txt| by Lee Savide is licensed under a Creative Commons
    Attribution-NonCommercial-ShareAlike 3.0 Unported License. Please
    read the license deed at
    http://creativecommons.org/licenses/by-nc-sa/3.0/.

==============================================================================
CONTENTS                                                    *abc-vim-contents*

    1. Introduction                  |abc-vim|
    2. Prerequisites                 |abc-vim-prerequisites|
    3. Why abc-vim?                  |abc-vim-why|
    4. abc Intro                     |abc-vim-intro|
        4.1.                            
        4.2. 
        4.3. 
    5. abc syntax                    |abc-vim-syntax|
        5.1.                         |abc-vim-syntax-|
        5.2.                         |abc-vim-syntax-|
        5.3.                         |abc-vim-syntax-|
        5.4.                         |abc-vim-syntax-|
        5.5.                         |abc-vim-syntax-|
        5.6.                         |abc-vim-syntax-|
        5.7.                         |abc-vim-syntax-|
        5.8.                         |abc-vim-syntax-|
        5.9.                         |abc-vim-syntax-|
        5.10.                        |abc-vim-syntax-|
        5.11.                        |abc-vim-syntax-|
        5.12.                        |abc-vim-syntax-|
        5.13.                        |abc-vim-syntax-|
        5.14.                        |abc-vim-syntax-|
    6. Folding                       |abc-vim-folding|
    7. Placeholders                  |abc-vim-placeholders|
    8. Compilers                     |abc-vim-compilers|
    9. Omnicompletion                |abc-vim-omni|
    10.                              |abc-vim-|
    11. Options                      |abc-vim-options|
       11.1. Registered Tunes        |abc-vim-register-files|
       11.2. Temporary Tunes         |abc-vim-temporary-files|
       11.3. Per-Tune Options        |abc-vim-local-options|
       11.4. Global Options          |abc-vim-global-options|
    12. Help                         |abc-vim-help|
    13. Developers                   |abc-vim-developers|
    14. Changelog                    |abc-vim-changelog|
    15. Licenses                     |abc-vim-licenses|
    16. Todo                         |abc-vim-todo|

==============================================================================
1. Introduction                                                      *abc-vim*

abc-vim is an update for the syntax highlighting for the abc music notation
language that comes standard in Vim, and also provides features for the abc
music notation languages by making full use of all the things that make Vim
such a wonderful text editor.

For the moment, the only part of the scripts that will be worked on is the
syntax script, since that lets all the other scripts that will be worked on in
the future something to work from.

==============================================================================
2. Prerequisites                                       *abc-vim-prerequisites*

Make sure you have these settings in your vimrc file: >
    'set nocompatible'
    'filetype plugin on'
    'syntax on'
    'set omnifunc=syntaxcomplete#Complete'

Without them abc-vim will not work properly.

Additionally, I would suggest that you first be able to understand common
concepts in music theory. For any one who may be new to writing music,
I suggest using this guide as a means to get familiar with the abc standard,
while also learning how music notation works in general: >

    http://abcplus.sourceforge.net/#ABCGuide

If it interests you, you can also learn to make a tin whistle from PVC pipe: >

    http://www.ggwhistles.com/howto/

Both the guide and the how-to on making tin whistles are written by the same
author, Dr. Guido Gonzato, from Verona, Italy. Both guides are written very well,
especially for someone who has addmitted to me in an email that English was
not his first language. Both guides are free to download at your leasure. The
ABC PLus guide is under a GNU GPL license(technically, I think that makes it
FDL, though, but oh well), and the how-to guide is licensed under a Creative
Commons Attribution-NonCommercial-NoDerivs 3.0 Unported license. Please read
the Creative Commons deed for the how-to guide at: >
 
    http://creativecommons.org/licenses/by-nc-nd/3.0/

And also read the terms and conditions of the GNU GPL at: >

    http://www.gnu.org/licenses/gpl-3.0.txt

Or in HTML at: >

    http://www.gnu.org/licenses/gpl-3.0-standalone.html

==============================================================================
3. Why abc-vim?                                                  *abc-vim-why*

You're probably wondering why you should use abc to notate music. Why use
something new that you've probably never heard of, if you're so used to using
some other tool, like Finale or Sibelius? Why switch?

Of all the reasons I could list, the biggest reasons are learning curve & SPEED.

In both Finale & Sibelius, and in other music notation software, including
non-commercial and open source applications, like MuseScore, and even in
software that's not as well known, like NoteWorthy Composer, the design of
the software feels as if it's going out of it's way to make writing music
even more difficult than it is if you were to write it by hand. They don't
even give you any sort of means to do certain things, like transposition in
some cases, without having to start all over from the beginning. And even when
writing music by hand, there are situations where the objective you're trying
to accomplish in the music requires you to rewrite the whole song!

Then a wise man named Chris Walshaw improvised a means for a standard of
music notation that software would be able to conform around, as opposed to
conforming the music notation around the software. He named it abc music
notation.

Even in it's initial version, it was clear that abc had a very clear and
definitive standing as a music notation format. But not because it's
implementing software was better than the others (although that is debatable),
but because it was designed entirely around the fundamentals of music theory
as a whole. The format TAUGHT it's users how music works in an entirely
hands-on way that made abc popular.

Even so, abc was still "just another music notation format". What made it
stand out? And yet during the same time that it was made, it had also taken
it's root as the lingua franca for traditional Irish folk tunes, and had
incorporated support for certain forms of music, most specifically, for that
of Highland bagpipe music. This, along with it's low learning curve, provided
the foundation of a format that has contributed to hundreds of thousands of
thousands of written songs, all as abc music.

With that said, I began these scripts for a number of reasons:
    1. Because I love music, and I live in music, and will die with music.
    2. Because abc.vim is heavily outdated. The syntax groups currently used
    cause improper matching with the newer format.
    3. Because there ought to be a default editor for abc, particularily one
    that can be extended easily, and in a multitude of ways.
    4. Out of disrespect & contempt of Finale and Sibelius; Mostly of Finale.
    Sibelius slightly redeemed itself to me by providing examples and ear
    training examples within the program, but in Finale they literally leave
    you stranded, like Micro$oft...WHICH IS A VERY ACCURATE COMPARISON, IF I
    MUST SAY. >:T

Now that I've gotten that off my chest, I can talk about the scripts. :3

==============================================================================
4. ABC Intro                                                   *abc-vim-intro*

Author: John Chambers <jc@trillian.mit.edu>
-----------------------------------------------------------------------------
               An Introduction to ABC Music Notation                        ~
                        by John Chambers                                    ~
                       <jc@trillian.mit.edu>                                ~
-----------------------------------------------------------------------------
Here's a simple example of ABC notation for a well-known Irish jig: >

X: 1
T: The Kesh Jig
T: The Kincora Jig
R: jig
M: 6/8
L: 1/8
K: G
D \
| "G"~G3       GAB | "D7"~A3     ABd | "G"edd gdd | "D7"edB   dBA \
| "G"~G3 "(Em)"GAB | "Am"~A3 "D7"ABd | "G"edd gdB | "D7"AGF "G"G2 :|
|: A \
| "G"~B3 dBd | "C"ege "G"dBG | "G"~B3 dBG | "Am"~A3 "D7"AGA \
| "G"~B3 dBd | "C"ege "G"dBd | "C"~g3 aga | "D7"bgf  "G"g2 :|
<

This is fairly easy to read, and once you understand it, you can quickly
start typing in your own tunes.

-----------------------------------------------------------------------------
4.1 Headers                                        *abc-vim-abc-intro-headers*

First, there are a bunch of "header" lines that say things about the tune as
a whole. The X: line merely gives an index number. If a file has several
tunes, they should all be given different X numbers. Some ABC software lets
you use the X: number to extract tunes from collections, sort of like the way
that some CD players let you pick the order of play.

The T:  lines give titles. This tune has two titles. I put "The Kesh Jig"
first because, in my experience, that's the one that is the best known.
Printing software will typically show the first title in a larger font than
others, which are considered "subtitles".

The R: line ("rhythm") says it's a jig. This is also used by some software.
For example, f you're on a Unix-like system you could use a command like: >
   grep -li "R: *jig" *.abc
<
to locate all the jigs in a directory of abc files.

The M: line gives the meter, 6/8 in this case. You can use M:C and M:C| for
the obvious "common" (4/4) and "cut" (2/2) times. You can also say M:none for
no time signature at all.

The L: line gives the basic or default length of a note. In this case, L:1/8
says that a note without any time modifier is an eighths note (semiquaver).
This is only used in converting ABC to printed music.

The K: line gives the key. In this case, the key is G major. "K: Gm" would
mean G minor. The abc standard also includes the classical modes, so that "K:
Gdor" means G dorian (one flat), and "K:  Amix" means A Mixolydian (two
sharps). The mode can be spelled out or abbreviated to three characters, and
minor can be abbreviated to just m.

ABC's rules say that the X: and T: lines must be first, and the K: line is
the last of the header lines. Then comes the fun part, the music.

-----------------------------------------------------------------------------
4.2 Music                                               *abc-vim-intro-music*

First, if you play a melody instrument, you can ignore all the stuff in
double quotes. Those are called "accompaniment chords". They are to be played
on guitar or accordion or harp or whatever. Now that you know what they are,
you can probably understand the chords in this tune. So we can ignore them,
and the first part of the tune is:

   D \
   | ~G3 GAB | ~A3 ABd | edd gdd | edB dBA \

The backslash means "continued on next line", and is used to merge several
lines of abc into one staff. When reading, we can ignore backslashes, and the
result is:
   D | ~G3 GAB | ~A3 ABd | edd gdd | edB dBA

The letters A-G and a-g are notes. Large notes are the bottom half of the
staff, and lower case is the upper half. The scale actually runs CDEFGAB,
with C being the C below the staff, and B being the line in the middle of the
treble staff. Similarly, cdefgab is the scale from the c in the middle of the
staff to the b above the staff. Programmers hate this, but musicians will see
why it's a good idea.

A number after a note is a note length. So G3 means a G three times as long
as the L: value. In this case, it's a G of length 3/8, or a dotted quarter
note.  You can also use fractions if you wish. So G3/2 would mean a G of
length 3/16, or a dotted eighth note. You can omit a numerator of 1 or a
denominator of 2, so G1/2, G/2 and G/ all mean the same thing, a G of length
1/16 in this tune.

The only thing left to understand the above line is knowing that ~ is
notation for a "turn". It is displayed as a large ~ symbol above or below the
note, and played however you feel like playing it.

So, to translate this all into rather coarse ASCII graphics, here are the
first two bars of the above line:

                                                                 ,|
                                           ,|                  ,/ |
         |\                 ~            ,/ |     ~          ,/   |
     ----|/--#----------|--------------,/---|-|------------,/-|---|-|
         /              |            ,/ |   | |   |       |   |   | |
     ---/|-----6--------|---|-------|---|---|-|---|-------|---|-(*)-|
       / |              |   |       |   |   | |   |       |   |     |
     -/--|----------|\--|---|-------|---|-(*)-|---|-------|-(*)-----|
     (  /| \        | | |   | .     | (*)     | (*) .   (*)         |
     -\--|-/---8----|-|-|-(*)-----(*)---------|---------------------|
       \ |/         | ' |                     |                     |
     ----|----------|---|---------------------|---------------------|
         J        (*)

Wow, that was difficult to type! The ABC notation is much easier, especially
if you're a keyboard player. But anyone who plays any instrument should find
ABC fairly easy to type.

-----------------------------------------------------------------------------
Let's see, what else do you need to know? Oh, yes; in the above tune, you'll
see |: and :| symbols. You guessed right; these are repeat symbols. I left
out the |: at the beginning, as is done in a lot of printed music. You can
also indicate first and second endings:
    |: ...  |1 ...  :|2 ...  ||
where ... represents any music. The || symbol represents a double bar, and
you can use [| and |] to get the thick+thin or thin+thick styles of double
bars. You can also use :: in the middle of a line as a shorthand for :||:,
that is, double bars with repeats on both sides.

There's also notation for two more octaves. It is sort of pictorial, using a
comma (,) for "one octave down" and an apostrophe (') for "one octave up. So
G,A,B, are the three lowest notes on a fiddle or mandolin, and c' is the
second leger line above the treble staff.

It's also useful to be able to include rests. The ABC symbol for a rest is
the letter 'z' (and note that it's lower case). It is used just like a note,
and takes lengths in the same manner.

Something not covered in the above example is accidentals. There is an
obvious problem with the ASCII character set: It has a sharp sign, but no
natural or flat sign. The solution is simple: _G is a G flat; =G is a G
natural, and ^G is a G sharp. Note that this is a bit inconsistent with the
notation for keys and chords: K:Gb and K:G# are how you indicate keys of G
flat and G sharp; "Gbm" and "G#7" are G flat minor and G sharp seventh
chords. But since 'b' is used for a note, it can't be used with notes to
indicate a flat. So the pictorial _=^ symbols are used.

You can also indicate ties and slurs. A tie (or single-note slur) can be
indicated with a hyphen. If the above tune had started G3- GAB it would have
meant to tie the G to the G in the second group of notes. To get a slur, put
parentheses around a group of notes. Thus, in the above example, you might
indicate a generic jig bowing by writing:
   D | ~G2G (GA)B | ~A2A (AB)d | (ed)d (gd)d | (ed)B (dB)A |

A few words about spacing: I've used more spaces in the above examples than
you really need. About the only spaces that are needed within the music are
the ones that separate groups of notes. This is used by abc display or print
programs to determine how notes are beamed together. If the third bar had
been |eddgdd|, the result would be six notes all beamed together. If you
write |ed dg dd| you would get a waltz-type beaming, with three groups of two
notes each. |edd gdd| gives two groups of three notes each.

Spaces around the bar lines aren't needed, but they help a lot if you want
your ABC to be readable by humans. Also, the header lines don't need spaces
after the colons, but they add slightly to readability.

There are some other useful header lines. C: is used to indicate the
Composer. O: is used to comment on the Origin. S: is used to give a Source.
B: is used to list Books where the music can be found. D: means discography
(recordings). H: is used for Historical notes. N: is used for random other
notes. And you should put your name and email address on a Z: line, which is
used to indicate who did the transcription. (T: was already taken.) You can
see O:Trad in a lot of old tunes. And Q:120 or Q:1/4=110 may be used to
indicate a metronome setting.

There's more to ABC, but this is all you need to know to read or write
typical folk tunes. Now go to your favorite editor and type in a few tunes.
And check out the ABC home page: >
   http://abcnotation.org.uk/
You'll find pointers to lots of software and music collections there.
-----------------------------------------------------------------------------

This is the second file from my set of ABC documents. Some others: >
  http://trillian.mit.edu/~jc/music/abc/doc/ABCtrivial.txt
  http://trillian.mit.edu/~jc/music/abc/doc/ABCintro.txt    (this file)
  http://trillian.mit.edu/~jc/music/abc/doc/ABCprimer.html
  http://trillian.mit.edu/~jc/music/abc/doc/ABCtut.html
<
==============================================================================
5.                                                            *abc-vim-syntax*

==============================================================================
6.                                                           *abc-vim-folding*

==============================================================================
7.                                                      *abc-vim-placeholders*

==============================================================================
8.                                                         *abc-vim-compilers*

==============================================================================
9.                                                              *abc-vim-omni*

==============================================================================
10.                                                          *abc-vim-options*

==============================================================================
11.                                                             *abc-vim-help*

==============================================================================
12.                                                       *abc-vim-developers*

==============================================================================
13.                                                        *abc-vim-changelog*

==============================================================================
15.                                                         *abc-vim-licenses*

==============================================================================
16. Todo                                                        *abc-vim-todo*


 vim:tw=78:ts=8:ft=help
./doc/rfc2234.txt	[[[1
787






Network Working Group                                     D. Crocker, Ed.
Request for Comments: 2234                       Internet Mail Consortium
Category: Standards Track                                      P. Overell
                                                      Demon Internet Ltd.
                                                            November 1997


             Augmented BNF for Syntax Specifications: ABNF


Status of this Memo

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

Copyright Notice

   Copyright (C) The Internet Society (1997).  All Rights Reserved.

TABLE OF CONTENTS

   1. INTRODUCTION ..................................................  2

   2. RULE DEFINITION ...............................................  2
   2.1 RULE NAMING ..................................................  2
   2.2 RULE FORM ....................................................  3
   2.3 TERMINAL VALUES ..............................................  3
   2.4 EXTERNAL ENCODINGS ...........................................  5

   3. OPERATORS .....................................................  5
   3.1 CONCATENATION    RULE1     RULE2 .............................  5
   3.2 ALTERNATIVES RULE1 / RULE2 ...................................  6
   3.3 INCREMENTAL ALTERNATIVES   RULE1 =/ RULE2 ....................  6
   3.4 VALUE RANGE ALTERNATIVES   %C##-## ...........................  7
   3.5 SEQUENCE GROUP (RULE1 RULE2) .................................  7
   3.6 VARIABLE REPETITION *RULE ....................................  8
   3.7 SPECIFIC REPETITION NRULE ....................................  8
   3.8 OPTIONAL SEQUENCE [RULE] .....................................  8
   3.9 ; COMMENT ....................................................  8
   3.10 OPERATOR PRECEDENCE .........................................  9

   4. ABNF DEFINITION OF ABNF .......................................  9

   5. SECURITY CONSIDERATIONS ....................................... 10




Crocker & Overell           Standards Track                     [Page 1]

RFC 2234             ABNF for Syntax Specifications        November 1997


   6. APPENDIX A - CORE ............................................. 11
   6.1 CORE RULES ................................................... 11
   6.2 COMMON ENCODING .............................................. 12

   7. ACKNOWLEDGMENTS ............................................... 12

   8. REFERENCES .................................................... 13

   9. CONTACT ....................................................... 13

   10. FULL COPYRIGHT STATEMENT ..................................... 14

1.   INTRODUCTION

   Internet technical specifications often need to define a format
   syntax and are free to employ whatever notation their authors deem
   useful.  Over the years, a modified version of Backus-Naur Form
   (BNF), called Augmented BNF (ABNF), has been popular among many
   Internet specifications.  It balances compactness and simplicity,
   with reasonable representational power.  In the early days of the
   Arpanet, each specification contained its own definition of ABNF.
   This included the email specifications, RFC733 and then RFC822 which
   have come to be the common citations for defining ABNF.  The current
   document separates out that definition, to permit selective
   reference.  Predictably, it also provides some modifications and
   enhancements.

   The differences between standard BNF and ABNF involve naming rules,
   repetition, alternatives, order-independence, and value ranges.
   Appendix A (Core) supplies rule definitions and encoding for a core
   lexical analyzer of the type common to several Internet
   specifications.  It is provided as a convenience and is otherwise
   separate from the meta language defined in the body of this document,
   and separate from its formal status.

2.   RULE DEFINITION

2.1  Rule Naming

   The name of a rule is simply the name itself; that is, a sequence of
   characters, beginning with  an alphabetic character, and followed by
   a combination of alphabetics, digits and hyphens (dashes).

        NOTE:     Rule names are case-insensitive

   The names <rulename>, <Rulename>, <RULENAME> and <rUlENamE> all refer
   to the same rule.




Crocker & Overell           Standards Track                     [Page 2]

RFC 2234             ABNF for Syntax Specifications        November 1997


   Unlike original BNF, angle brackets ("<", ">") are not  required.
   However, angle brackets may be used around a rule name whenever their
   presence will facilitate discerning the use of  a rule name.  This is
   typically restricted to rule name references in free-form prose, or
   to distinguish partial rules that combine into a string not separated
   by white space, such as shown in the discussion about repetition,
   below.

2.2  Rule Form

   A rule is defined by the following sequence:

        name =  elements crlf

   where <name> is the name of the rule, <elements> is one or more rule
   names or terminal specifications and <crlf> is the end-of- line
   indicator, carriage return followed by line feed.  The equal sign
   separates the name from the definition of the rule.  The elements
   form a sequence of one or more rule names and/or value definitions,
   combined according to the various operators, defined in this
   document, such as alternative and repetition.

   For visual ease, rule definitions are left aligned.  When a rule
   requires multiple lines, the continuation lines are indented.  The
   left alignment and indentation are relative to the first lines of the
   ABNF rules and need not match the left margin of the document.

2.3  Terminal Values

   Rules resolve into a string of terminal values, sometimes called
   characters.  In ABNF a character is merely a non-negative integer.
   In certain contexts a specific mapping (encoding) of values into a
   character set (such as ASCII) will be specified.

   Terminals are specified by one or more numeric characters with the
   base interpretation of those characters indicated explicitly.  The
   following bases are currently defined:

        b           =  binary

        d           =  decimal

        x           =  hexadecimal








Crocker & Overell           Standards Track                     [Page 3]

RFC 2234             ABNF for Syntax Specifications        November 1997


   Hence:

        CR          =  %d13

        CR          =  %x0D

   respectively specify the decimal and hexadecimal representation of
   [US-ASCII] for carriage return.

   A concatenated string of such values is specified compactly, using a
   period (".") to indicate separation of characters within that value.
   Hence:

        CRLF        =  %d13.10

   ABNF permits specifying literal text string directly, enclosed in
   quotation-marks.  Hence:

        command     =  "command string"

   Literal text strings are interpreted as a concatenated set of
   printable characters.

        NOTE:     ABNF strings are case-insensitive and
                  the character set for these strings is us-ascii.

   Hence:

        rulename = "abc"

   and:

        rulename = "aBc"

   will match "abc", "Abc", "aBc", "abC", "ABc", "aBC", "AbC" and "ABC".

                To specify a rule which IS case SENSITIVE,
                   specify the characters individually.

   For example:

        rulename    =  %d97 %d98 %d99

   or

        rulename    =  %d97.98.99





Crocker & Overell           Standards Track                     [Page 4]

RFC 2234             ABNF for Syntax Specifications        November 1997


   will match only the string which comprises only lowercased
   characters, abc.

2.4  External Encodings

   External representations of terminal value characters will vary
   according to constraints in the storage or transmission environment.
   Hence, the same ABNF-based grammar may have multiple external
   encodings, such as one for a 7-bit US-ASCII environment, another for
   a binary octet environment and still a different one when 16-bit
   Unicode is used.  Encoding details are beyond the scope of ABNF,
   although Appendix A (Core) provides definitions for a 7-bit US-ASCII
   environment as has been common to much of the Internet.

   By separating external encoding from the syntax, it is intended that
   alternate encoding environments can be used for the same syntax.

3.   OPERATORS

3.1  Concatenation                                  Rule1 Rule2

   A rule can define a simple, ordered string of values -- i.e., a
   concatenation of contiguous characters -- by listing a sequence of
   rule names.  For example:

        foo         =  %x61           ; a

        bar         =  %x62           ; b

        mumble      =  foo bar foo

        So that the rule <mumble> matches the lowercase string "aba".

        LINEAR WHITE SPACE:  Concatenation is at the core of the ABNF
        parsing model.  A string of contiguous characters (values) is
        parsed according to the rules defined in ABNF.  For Internet
        specifications, there is some history of permitting linear white
        space (space and horizontal tab) to be freelyPand
        implicitlyPinterspersed around major constructs, such as
        delimiting special characters or atomic strings.

        NOTE:     This specification for ABNF does not
                  provide for implicit specification of linear white
                  space.

   Any grammar which wishes to permit linear white space around
   delimiters or string segments must specify it explicitly.  It is
   often useful to provide for such white space in "core" rules that are



Crocker & Overell           Standards Track                     [Page 5]

RFC 2234             ABNF for Syntax Specifications        November 1997


   then used variously among higher-level rules.  The "core" rules might
   be formed into a lexical analyzer or simply be part of the main
   ruleset.

3.2  Alternatives                               Rule1 / Rule2

   Elements separated by forward slash ("/") are alternatives.
   Therefore,

        foo / bar

   will accept <foo> or <bar>.

        NOTE:     A quoted string containing alphabetic
                  characters is special form for specifying alternative
                  characters and is interpreted as a non-terminal
                  representing the set of combinatorial strings with the
                  contained characters, in the specified order but with
                  any mixture of upper and lower case..

3.3  Incremental Alternatives                    Rule1 =/ Rule2

   It is sometimes convenient to specify a list of alternatives in
   fragments.  That is, an initial rule may match one or more
   alternatives, with later rule definitions adding to the set of
   alternatives.  This is particularly useful for otherwise- independent
   specifications which derive from the same parent rule set, such as
   often occurs with parameter lists.  ABNF permits this incremental
   definition through the construct:

        oldrule     =/ additional-alternatives

   So that the rule set

        ruleset     =  alt1 / alt2

        ruleset     =/ alt3

        ruleset     =/ alt4 / alt5

   is the same as specifying

        ruleset     =  alt1 / alt2 / alt3 / alt4 / alt5








Crocker & Overell           Standards Track                     [Page 6]

RFC 2234             ABNF for Syntax Specifications        November 1997


3.4  Value Range Alternatives                           %c##-##

   A range of alternative numeric values can be specified compactly,
   using dash ("-") to indicate the range of alternative values.  Hence:

        DIGIT       =  %x30-39

   is equivalent to:

        DIGIT       =  "0" / "1" / "2" / "3" / "4" / "5" / "6" /

                           "7" / "8" / "9"

   Concatenated numeric values and numeric value ranges can not be
   specified in the same string.  A numeric value may use the dotted
   notation for concatenation or it may use the dash notation to specify
   one value range.  Hence, to specify one printable character, between
   end of line sequences, the specification could be:

        char-line = %x0D.0A %x20-7E %x0D.0A

3.5  Sequence Group                             (Rule1 Rule2)

   Elements enclosed in parentheses are treated as a single element,
   whose contents are STRICTLY ORDERED.   Thus,

        elem (foo / bar) blat

   which matches (elem foo blat) or (elem bar blat).

        elem foo / bar blat

   matches (elem foo) or (bar blat).

        NOTE:     It is strongly advised to use grouping
                  notation, rather than to rely on proper reading of
                  "bare" alternations, when alternatives consist of
                  multiple rule names or literals.

   Hence it is recommended that instead of the above form, the form:

        (elem foo) / (bar blat)

   be used.  It will avoid misinterpretation by casual readers.

   The sequence group notation is also used within free text to set off
   an element sequence from the prose.




Crocker & Overell           Standards Track                     [Page 7]

RFC 2234             ABNF for Syntax Specifications        November 1997


3.6  Variable Repetition                                *Rule

   The operator "*" preceding an element indicates repetition. The full
   form is:

        <a>*<b>element

   where <a> and <b> are optional decimal values, indicating at least
   <a> and at most <b> occurrences of element.

   Default values are 0 and infinity so that *<element> allows any
   number, including zero; 1*<element> requires at  least  one;
   3*3<element> allows exactly 3 and 1*2<element> allows one or two.

3.7  Specific Repetition                                  nRule

   A rule of the form:

        <n>element

   is equivalent to

        <n>*<n>element

   That is, exactly  <N>  occurrences  of <element>. Thus 2DIGIT is a
   2-digit number, and 3ALPHA is a string of three alphabetic
   characters.

3.8  Optional Sequence                                   [RULE]

   Square brackets enclose an optional element sequence:

        [foo bar]

   is equivalent to

        *1(foo bar).

3.9  ; Comment

   A semi-colon starts a comment that continues to the end of line.
   This is a simple way of including useful notes in parallel with the
   specifications.








Crocker & Overell           Standards Track                     [Page 8]

RFC 2234             ABNF for Syntax Specifications        November 1997


3.10 Operator Precedence

   The various mechanisms described above have the following precedence,
   from highest (binding tightest) at the top, to lowest and loosest at
   the bottom:

        Strings, Names formation
        Comment
        Value range
        Repetition
        Grouping, Optional
        Concatenation
        Alternative

   Use of the alternative operator, freely mixed with concatenations can
   be confusing.

        Again, it is recommended that the grouping operator be used to
        make explicit concatenation groups.

4.   ABNF DEFINITION OF ABNF

   This syntax uses the rules provided in Appendix A (Core).

        rulelist       =  1*( rule / (*c-wsp c-nl) )

        rule           =  rulename defined-as elements c-nl
                               ; continues if next line starts
                               ;  with white space

        rulename       =  ALPHA *(ALPHA / DIGIT / "-")

        defined-as     =  *c-wsp ("=" / "=/") *c-wsp
                               ; basic rules definition and
                               ;  incremental alternatives

        elements       =  alternation *c-wsp

        c-wsp          =  WSP / (c-nl WSP)

        c-nl           =  comment / CRLF
                               ; comment or newline

        comment        =  ";" *(WSP / VCHAR) CRLF

        alternation    =  concatenation
                          *(*c-wsp "/" *c-wsp concatenation)




Crocker & Overell           Standards Track                     [Page 9]

RFC 2234             ABNF for Syntax Specifications        November 1997


        concatenation  =  repetition *(1*c-wsp repetition)

        repetition     =  [repeat] element

        repeat         =  1*DIGIT / (*DIGIT "*" *DIGIT)

        element        =  rulename / group / option /
                          char-val / num-val / prose-val

        group          =  "(" *c-wsp alternation *c-wsp ")"

        option         =  "[" *c-wsp alternation *c-wsp "]"

        char-val       =  DQUOTE *(%x20-21 / %x23-7E) DQUOTE
                               ; quoted string of SP and VCHAR
                                  without DQUOTE

        num-val        =  "%" (bin-val / dec-val / hex-val)

        bin-val        =  "b" 1*BIT
                          [ 1*("." 1*BIT) / ("-" 1*BIT) ]
                               ; series of concatenated bit values
                               ; or single ONEOF range

        dec-val        =  "d" 1*DIGIT
                          [ 1*("." 1*DIGIT) / ("-" 1*DIGIT) ]

        hex-val        =  "x" 1*HEXDIG
                          [ 1*("." 1*HEXDIG) / ("-" 1*HEXDIG) ]

        prose-val      =  "<" *(%x20-3D / %x3F-7E) ">"
                               ; bracketed string of SP and VCHAR
                                  without angles
                               ; prose description, to be used as
                                  last resort


5.   SECURITY CONSIDERATIONS

   Security is truly believed to be irrelevant to this document.











Crocker & Overell           Standards Track                    [Page 10]

RFC 2234             ABNF for Syntax Specifications        November 1997


6.   APPENDIX A - CORE

   This Appendix is provided as a convenient core for specific grammars.
   The definitions may be used as a core set of rules.

6.1  Core Rules

   Certain  basic  rules  are  in uppercase, such as SP, HTAB, CRLF,
   DIGIT, ALPHA, etc.

        ALPHA          =  %x41-5A / %x61-7A   ; A-Z / a-z

        BIT            =  "0" / "1"

        CHAR           =  %x01-7F
                               ; any 7-bit US-ASCII character,
                                  excluding NUL

        CR             =  %x0D
                               ; carriage return

        CRLF           =  CR LF
                               ; Internet standard newline

        CTL            =  %x00-1F / %x7F
                               ; controls

        DIGIT          =  %x30-39
                               ; 0-9

        DQUOTE         =  %x22
                               ; " (Double Quote)

        HEXDIG         =  DIGIT / "A" / "B" / "C" / "D" / "E" / "F"

        HTAB           =  %x09
                               ; horizontal tab

        LF             =  %x0A
                               ; linefeed

        LWSP           =  *(WSP / CRLF WSP)
                               ; linear white space (past newline)

        OCTET          =  %x00-FF
                               ; 8 bits of data

        SP             =  %x20



Crocker & Overell           Standards Track                    [Page 11]

RFC 2234             ABNF for Syntax Specifications        November 1997


                               ; space

        VCHAR          =  %x21-7E
                               ; visible (printing) characters

        WSP            =  SP / HTAB
                               ; white space

6.2  Common Encoding

   Externally, data are represented as "network virtual ASCII", namely
   7-bit US-ASCII in an 8-bit field, with the high (8th) bit set to
   zero.  A string of values is in "network byte order" with the
   higher-valued bytes represented on the left-hand side and being sent
   over the network first.

7.   ACKNOWLEDGMENTS

   The syntax for ABNF was originally specified in RFC 733.  Ken L.
   Harrenstien, of SRI International, was responsible for re-coding the
   BNF into an augmented BNF that makes the representation smaller and
   easier to understand.

   This recent project began as a simple effort to cull out the portion
   of RFC 822 which has been repeatedly cited by non-email specification
   writers, namely the description of augmented BNF.  Rather than simply
   and blindly converting the existing text into a separate document,
   the working group chose to give careful consideration to the
   deficiencies, as well as benefits, of the existing specification and
   related specifications available over the last 15 years and therefore
   to pursue enhancement.  This turned the project into something rather
   more ambitious than first intended.  Interestingly the result is not
   massively different from that original, although decisions such as
   removing the list notation came as a surprise.

   The current round of specification was part of the DRUMS working
   group, with significant contributions from Jerome Abela , Harald
   Alvestrand, Robert Elz, Roger Fajman, Aviva Garrett, Tom Harsch, Dan
   Kohn, Bill McQuillan, Keith Moore, Chris Newman , Pete Resnick and
   Henning Schulzrinne.











Crocker & Overell           Standards Track                    [Page 12]

RFC 2234             ABNF for Syntax Specifications        November 1997


8.   REFERENCES

   [US-ASCII]     Coded Character Set--7-Bit American Standard Code for
   Information Interchange, ANSI X3.4-1986.

   [RFC733]  Crocker, D., Vittal, J., Pogran, K., and D. Henderson,
   "Standard for the Format of ARPA Network Text Message," RFC 733,
   November 1977.

   [RFC822]  Crocker, D., "Standard for the Format of ARPA Internet Text
   Messages", STD 11, RFC 822, August 1982.

9.   CONTACT

   David H. Crocker                 Paul Overell

   Internet Mail Consortium         Demon Internet Ltd
   675 Spruce Dr.                   Dorking Business Park
   Sunnyvale, CA 94086 USA          Dorking
                                    Surrey, RH4 1HN
                                    UK

   Phone:    +1 408 246 8253
   Fax:      +1 408 249 6205
   EMail:    dcrocker@imc.org       paulo@turnpike.com


























Crocker & Overell           Standards Track                    [Page 13]

RFC 2234             ABNF for Syntax Specifications        November 1997


10.  Full Copyright Statement

   Copyright (C) The Internet Society (1997).  All Rights Reserved.

   This document and translations of it may be copied and furnished to
   others, and derivative works that comment on or otherwise explain it
   or assist in its implementation may be prepared, copied, published
   and distributed, in whole or in part, without restriction of any
   kind, provided that the above copyright notice and this paragraph are
   included on all such copies and derivative works.  However, this
   document itself may not be modified in any way, such as by removing
   the copyright notice or references to the Internet Society or other
   Internet organizations, except as needed for the purpose of
   developing Internet standards in which case the procedures for
   copyrights defined in the Internet Standards process must be
   followed, or as required to translate it into languages other than
   English.

   The limited permissions granted above are perpetual and will not be
   revoked by the Internet Society or its successors or assigns.

   This document and the information contained herein is provided on an
   "AS IS" basis and THE INTERNET SOCIETY AND THE INTERNET ENGINEERING
   TASK FORCE DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING
   BUT NOT LIMITED TO ANY WARRANTY THAT THE USE OF THE INFORMATION
   HEREIN WILL NOT INFRINGE ANY RIGHTS OR ANY IMPLIED WARRANTIES OF
   MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
























Crocker & Overell           Standards Track                    [Page 14]

./ftplugin/README.txt	[[[1
24
The ftplugin directory is for Vim plugin scripts that are only used for a
specific filetype.

All files ending in .vim in this directory and subdirectories will be sourced
by Vim when it detects the filetype that matches the name of the file or
subdirectory.
For example, these are all loaded for the "c" filetype:

	c.vim
	c_extra.vim
	c/settings.vim

Note that the "_" in "c_extra.vim" is required to separate the filetype name
from the following arbitrary name.

The filetype plugins are only loaded when the ":filetype plugin" command has
been used.

The default filetype plugin files contain settings that 95% of the users will
want to use.  They do not contain personal preferences, like the value of
'shiftwidth'.

If you want to do additional settings, or overrule the default filetype
plugin, you can create your own plugin file.  See ":help ftplugin" in Vim.
./indent/README.txt	[[[1
45
This directory contains files to automatically compute the indent for a
type of file.

If you want to add your own indent file for your personal use, read the docs
at ":help indent-expression".  Looking at the existing files should give you
inspiration.

If you make a new indent file which would be useful for others, please send it
to Bram@vim.org.  Include instructions for detecting the file type for this
language, by file name extension or by checking a few lines in the file.
And please stick to the rules below.

If you have remarks about an existing file, send them to the maintainer of
that file.  Only when you get no response send a message to Bram@vim.org.

If you are the maintainer of an indent file and make improvements, e-mail the
new version to Bram@vim.org.


Rules for making an indent file:

You should use this check for "b:did_indent":

	" Only load this indent file when no other was loaded yet.
	if exists("b:did_indent")
	  finish
	endif
	let b:did_indent = 1

Always use ":setlocal" to set 'indentexpr'.  This avoids it being carried over
to other buffers.

To trigger the indenting after typing a word like "endif", add the word to the
'cinkeys' option with "+=".

You normally set 'indentexpr' to evaluate a function and then define that
function.  That function only needs to be defined once for as long as Vim is
running.  Add a test if the function exists and use ":finish", like this:
	if exists("*GetMyIndent")
	  finish
	endif

The user may have several options set unlike you, try to write the file such
that it works with any option settings.  Also be aware of certain features not
being compiled in.
./keymap/README.txt	[[[1
26
keymap files for Vim

One of these files is loaded when the 'keymap' option is set.

The name of the file consists of these parts:

	{language}[-{layout}][_{encoding}].vim

{language}	Name of the language (e.g., "hebrew", "greek")

{layout}	Optional: name of the keyboard layout (e.g., "spanish",
		"russian3").  When omitted the layout of the standard
		US-english keyboard is assumed.

{encoding}	Optional: character encoding for which this keymap works.
		When omitted the "normal" encoding for the language is
		assumed.
		Use the value the 'encoding' option: lower case only, use '-'
		instead of '_'.

Each file starts with a header, naming the maintainer and the date when it was
last changed.  If you find a problem in a keymap file, check if you have the
most recent version.  If necessary, report a problem to the maintainer.

The format of the keymap lines below "loadkeymap" is explained in the Vim help
files, see ":help keymap-file-format".
./macros/README.txt	[[[1
30
The macros in the maze, hanoi and urm directories can be used to test Vim for
vi compatibility.  They have been written for vi to show its unlimited
possibilities.	The life macros can be used for performance comparisons.

hanoi	Macros that solve the tower of hanoi problem.
life	Macros that run Conway's game of life.
maze	Macros that solve a maze (amazing!).
urm	Macros that simulate a simple computer: "Universal Register Machine"


The other files contain some handy utilities.  They also serve as examples for
how to use Vi and Vim functionality.

dvorak			for when you use a Dvorak keyboard

justify.vim		user function for justifying text

matchit.vim + matchit.txt  make % match if-fi, HTML tags, and much more

less.sh + less.vim	make Vim work like less (or more)

shellmenu.vim		menus for editing shell scripts in the GUI version

swapmous.vim		swap left and right mouse buttons

editexisting.vim	when editing a file that is already edited with
			another Vim instance

This one is only for Unix.  It can be found in the extra archive:
file_select.vim		macros that make a handy file selector
./plugin/README.txt	[[[1
19
The plugin directory is for standard Vim plugin scripts.

All files here ending in .vim will be sourced by Vim when it starts up.
Look in the file for hints on how it can be disabled without deleting it.

getscriptPlugin.vim  get latest version of Vim scripts
gzip.vim	     edit compressed files
matchparen.vim	     highlight paren matching the one under the cursor
netrwPlugin.vim	     edit files over a network and browse (remote) directories
rrhelper.vim	     used for --remote-wait editing
spellfile.vim	     download a spellfile when it's missing
tarPlugin.vim	     edit (compressed) tar files
tohtml.vim	     convert a file with syntax highlighting to HTML
vimballPlugin.vim    create and unpack .vba files
zipPlugin.vim	     edit zip archives

Note: the explorer.vim plugin is no longer here, the netrw.vim plugin has
taken over browsing directories (also for remote directories).

./syntax/README.txt	[[[1
38
This directory contains Vim scripts for syntax highlighting.

These scripts are not for a language, but are used by Vim itself:

syntax.vim	Used for the ":syntax on" command.  Uses synload.vim.

manual.vim	Used for the ":syntax manual" command.  Uses synload.vim.

synload.vim	Contains autocommands to load a language file when a certain
		file name (extension) is used.  And sets up the Syntax menu
		for the GUI.

nosyntax.vim	Used for the ":syntax off" command.  Undo the loading of
		synload.vim.


A few special files:

2html.vim	Converts any highlighted file to HTML (GUI only).
colortest.vim	Check for color names and actual color on screen.
hitest.vim	View the current highlight settings.
whitespace.vim  View Tabs and Spaces.


If you want to write a syntax file, read the docs at ":help usr_44.txt".

If you make a new syntax file which would be useful for others, please send it
to Bram@vim.org.  Include instructions for detecting the file type for this
language, by file name extension or by checking a few lines in the file.
And please write the file in a portable way, see ":help 44.12".

If you have remarks about an existing file, send them to the maintainer of
that file.  Only when you get no response send a message to Bram@vim.org.

If you are the maintainer of a syntax file and make improvements, send the new
version to Bram@vim.org.

For further info see ":help syntax" in Vim.
