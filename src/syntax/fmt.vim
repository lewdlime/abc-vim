" Vim syntax file
" Language: abc format file
" Maintainer: Lee Savide <laughingman182@gmail.com>
" Last Change: 2012 Jul 19
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

" A format file contains lines giving the parameters values, format:
"
"	parameter [parameter list]

"In a format file, empty lines and lines starting with '%' are ignored.


if !exists("main_syntax")
    if version < 600
        syntax clear " Clear the syntax
        syn sync clear " Clear synchronization
    elseif has("b:current_syntax=1")
        finish
    endif
    let main_syntax = "fmt"
endif

" Take the priority for PostScript datatypes & primitives.
syn case ignore
" PostScript syntax items {{{
syn match fmtHex "\<\x\{2,}\>"
" Integers
syn match fmtInteger "\<[+-]\=\d\+\>"
" Radix
syn match fmtRadix "\d\+#\x\+\>"
" Reals - upper and lower case e is allowed
syn match fmtFloat "[+-]\=\d\+\.\>" contained
syn match fmtFloat "[+-]\=\d\+\.\d*\(e[+-]\=\d\+\)\=\>" contained
syn match fmtFloat "[+-]\=\.\d\+\(e[+-]\=\d\+\)\=\>" contained
syn match fmtFloat "[+-]\=\d\+e[+-]\=\d\+\>" contained
syn cluster fmtNumber contains=fmtInteger,fmtRadix,fmtFloat
" }}}
syn case match

" Entities {{{
" NOTE: Even though the Unicode C string sequences ought to allow mixed case for
" the hexadecimal characters, the initial '\u' is required to be lowercase, or
" the sequence would represent a 16-bit Unicode character. So case preserving it
" is.
syn match fmtEntity /\C\\`A\|&Agrave;\|\\u00c0/  contained conceal cchar=À
syn match fmtEntity /\C\\`a\|&agrave;\|\\u00e0/  contained conceal cchar=à
syn match fmtEntity /\C\\`E\|&Egrave;\|\\u00c8/  contained conceal cchar=È
syn match fmtEntity /\C\\`e\|&egrave;\|\\u00e8/  contained conceal cchar=è
syn match fmtEntity /\C\\`I\|&Igrave;\|\\u00cc/  contained conceal cchar=Ì
syn match fmtEntity /\C\\`i\|&igrave;\|\\u00ec/  contained conceal cchar=ì
syn match fmtEntity /\C\\`O\|&Ograve;\|\\u00d2/  contained conceal cchar=Ò
syn match fmtEntity /\C\\`o\|&ograve;\|\\u00f2/  contained conceal cchar=ò
syn match fmtEntity /\C\\`U\|&Ugrave;\|\\u00d9/  contained conceal cchar=Ù
syn match fmtEntity /\C\\`u\|&ugrave;\|\\u00f9/  contained conceal cchar=ù
syn match fmtEntity /\C\\'A\|&Aacute;\|\\u00c1/  contained conceal cchar=Á
syn match fmtEntity /\C\\'a\|&aacute;\|\\u00e1/  contained conceal cchar=á
syn match fmtEntity /\C\\'E\|&Eacute;\|\\u00c9/  contained conceal cchar=É
syn match fmtEntity /\C\\'e\|&eacute;\|\\u00e9/  contained conceal cchar=é
syn match fmtEntity /\C\\'I\|&Iacute;\|\\u00cd/  contained conceal cchar=Í
syn match fmtEntity /\C\\'i\|&iacute;\|\\u00ed/  contained conceal cchar=í
syn match fmtEntity /\C\\'O\|&Oacute;\|\\u00d3/  contained conceal cchar=Ó
syn match fmtEntity /\C\\'o\|&oacute;\|\\u00f3/  contained conceal cchar=ó
syn match fmtEntity /\C\\'U\|&Uacute;\|\\u00da/  contained conceal cchar=Ú
syn match fmtEntity /\C\\'u\|&uacute;\|\\u00fa/  contained conceal cchar=ú
syn match fmtEntity /\C\\'Y\|&Yacute;\|\\u00dd/  contained conceal cchar=Ý
syn match fmtEntity /\C\\'y\|&yacute;\|\\u00fd/  contained conceal cchar=ý
syn match fmtEntity /\C\\^A\|&Acirc;\|\\u00c2/   contained conceal cchar=Â
syn match fmtEntity /\C\\^a\|&acirc;\|\\u00e2/   contained conceal cchar=â
syn match fmtEntity /\C\\^E\|&Ecirc;\|\\u00ca/   contained conceal cchar=Ê
syn match fmtEntity /\C\\^e\|&ecirc;\|\\u00ea/   contained conceal cchar=ê
syn match fmtEntity /\C\\^I\|&Icirc;\|\\u00ce/   contained conceal cchar=Î
syn match fmtEntity /\C\\^i\|&icirc;\|\\u00ee/   contained conceal cchar=î
syn match fmtEntity /\C\\^O\|&Ocirc;\|\\u00d4/   contained conceal cchar=Ô
syn match fmtEntity /\C\\^o\|&ocirc;\|\\u00f4/   contained conceal cchar=ô
syn match fmtEntity /\C\\^U\|&Ucirc;\|\\u00db/   contained conceal cchar=Û
syn match fmtEntity /\C\\^u\|&ucirc;\|\\u00fb/   contained conceal cchar=û
syn match fmtEntity /\C\\^Y\|&Ycirc;\|\\u0176/   contained conceal cchar=Ŷ
syn match fmtEntity /\C\\^y\|&ycirc;\|\\u0177/   contained conceal cchar=ŷ
syn match fmtEntity /\C\\~A\|&Atilde;\|\\u00c3/  contained conceal cchar=Ã
syn match fmtEntity /\C\\~a\|&atilde;\|\\u00e3/  contained conceal cchar=ã
syn match fmtEntity /\C\\~N\|&Ntilde;\|\\u00d1/  contained conceal cchar=Ñ
syn match fmtEntity /\C\\~n\|&ntilde;\|\\u00f1/  contained conceal cchar=ñ
syn match fmtEntity /\C\\~O\|&Otilde;\|\\u00d5/  contained conceal cchar=Õ
syn match fmtEntity /\C\\~o\|&otilde;\|\\u00f5/  contained conceal cchar=õ
syn match fmtEntity /\C\\"A\|&Auml;\|\\u00c4/    contained conceal cchar=Ä
syn match fmtEntity /\C\\"a\|&auml;\|\\u00e4/    contained conceal cchar=ä
syn match fmtEntity /\C\\"E\|&Euml;\|\\u00cb/    contained conceal cchar=Ë
syn match fmtEntity /\C\\"e\|&euml;\|\\u00eb/    contained conceal cchar=ë
syn match fmtEntity /\C\\"I\|&Iuml;\|\\u00cf/    contained conceal cchar=Ï
syn match fmtEntity /\C\\"i\|&iuml;\|\\u00ef/    contained conceal cchar=ï
syn match fmtEntity /\C\\"O\|&Ouml;\|\\u00d6/    contained conceal cchar=Ö
syn match fmtEntity /\C\\"o\|&ouml;\|\\u00f6/    contained conceal cchar=ö
syn match fmtEntity /\C\\"U\|&Uuml;\|\\u00dc/    contained conceal cchar=Ü
syn match fmtEntity /\C\\"u\|&uuml;\|\\u00fc/    contained conceal cchar=ü
syn match fmtEntity /\C\\"Y\|&Yuml;\|\\u0178/    contained conceal cchar=Ÿ
syn match fmtEntity /\C\\"y\|&yuml;\|\\u00ff/    contained conceal cchar=ÿ
syn match fmtEntity /\C\\cC\|&Ccedil;\|\\u00c7/  contained conceal cchar=Ç
syn match fmtEntity /\C\\cc\|&ccedil;\|\\u00e7/  contained conceal cchar=ç
syn match fmtEntity /\C\\AA\|&Aring;\|\\u00c5/   contained conceal cchar=Å
syn match fmtEntity /\C\\aa\|&aring;\|\\u00e5/   contained conceal cchar=å
syn match fmtEntity /\C\\\/O\|&Oslash;\|\\u00d8/ contained conceal cchar=Ø
syn match fmtEntity /\C\\\/o\|&oslash;\|\\u00f8/ contained conceal cchar=ø
syn match fmtEntity /\C\\uA\|&Abreve;\|\\u0102/  contained conceal cchar=Ă
syn match fmtEntity /\C\\ua\|&abreve;\|\\u0103/  contained conceal cchar=ă
syn match fmtEntity /\C\\uE\|\\u0114/            contained conceal cchar=Ĕ
syn match fmtEntity /\C\\ue\|\\u0115/            contained conceal cchar=ĕ
syn match fmtEntity /\C\\vS\|&Scaron;\|\\u0160/  contained conceal cchar=Š
syn match fmtEntity /\C\\vs\|&scaron;\|\\u0161/  contained conceal cchar=š
syn match fmtEntity /\C\\vZ\|&Zcaron;\|\\u017d/  contained conceal cchar=Ž
syn match fmtEntity /\C\\vz\|&zcaron;\|\\u017e/  contained conceal cchar=ž
syn match fmtEntity /\C\\HO\|\\u0150/            contained conceal cchar=Ő
syn match fmtEntity /\C\\Ho\|\\u0151/            contained conceal cchar=ő
syn match fmtEntity /\C\\HU\|\\u0170/            contained conceal cchar=Ű
syn match fmtEntity /\C\\Hu\|\\u0171/            contained conceal cchar=ű
syn match fmtEntity /\C\\AE\|&AElig;\|\\u00c6/   contained conceal cchar=Æ
syn match fmtEntity /\C\\ae\|&aelig;\|\\u00e6/   contained conceal cchar=æ
syn match fmtEntity /\C\\OE\|&OElig;\|\\u0152/   contained conceal cchar=Œ
syn match fmtEntity /\C\\oe\|&oelig;\|\\u0153/   contained conceal cchar=œ
syn match fmtEntity /\C\\ss\|&szlig;\|\\u00df/   contained conceal cchar=ß
syn match fmtEntity /\C\\DH\|&ETH;\|\\u00d0/     contained conceal cchar=Ð
syn match fmtEntity /\C\\dh\|&eth;\|\\u00f0/     contained conceal cchar=ð
syn match fmtEntity /\C\\TH\|&THORN;\|\\u00de/   contained conceal cchar=Þ
syn match fmtEntity /\C\\th\|&thorn;\|\\u00fe/   contained conceal cchar=þ
syn match fmtEntity /\C&copy;\|\\u00a9/          contained conceal cchar=©
syn match fmtEntity /\c&266d;\|\\u266d/          contained conceal cchar=♭
syn match fmtEntity /\c&266e;\|\\u266e/          contained conceal cchar=♮
syn match fmtEntity /\c&266f;\|\\u266f/          contained conceal cchar=♯
syn match fmtEntity /\C&quot;\|\\u0022/ contained conceal cchar="
" }}}
syn match fmtEscapeChar /\\%/ contained
syn match fmtEscapeChar /\\\\/ contained
syn match fmtEscapeChar /\\\&/ contained

syn match fmtSetFontChar /\$[0-4]/ contained

syn match fmtQuoteChar /"/ contained
syn match fmtReservedChar /#\|\*\|;\|?\|@/ contained
syn match fmtBarChar /\%(|\|\[\|\]\)\{1,2}/ contained


syn keyword fmtBoolean contained true false on off yes no
syn keyword fmtSize contained in cm pt
syn keyword fmtEncoding contained utf-8 us-ascii iso-8859-1 iso-8859-2 iso-8859-3 iso-8859-4 iso-8859-5 iso-8859-6 iso-8859-7 iso-8859-8 iso-8859-9 iso-8859-10
syn keyword fmtEncoding contained utf-8 us-ascii native
syn keyword fmtDirectiveLock contained lock
" Lock Keyword {{{ 'lock' is allowed in all directives, and must set that a setting is no longer
" able to be set any where else in the same tune. If contained on a global, it
" sets that the directive is unsettable in all tunes.
" }}}
" PostScript Fonts {{{
syn keyword fmtFont contained AlbertusMT AlbertusMT-Italic AlbertusMT-Light Apple-Chancery Apple-ChanceryCE
syn keyword fmtFont contained AntiqueOlive-Roman AntiqueOlive-Italic AntiqueOlive-Bold AntiqueOlive-Compact
syn keyword fmtFont contained AntiqueOliveCE-Roman AntiqueOliveCE-Italic AntiqueOliveCE-Bold AntiqueOliveCE-Compact
syn keyword fmtFont contained ArialMT Arial-ItalicMT Arial-LightMT Arial-BoldMT Arial-BoldItalicMT
syn keyword fmtFont contained ArialCE ArialCE-Italic ArialCE-Light ArialCE-Bold ArialCE-BoldItalic
syn keyword fmtFont contained AvantGarde-Book AvantGarde-BookOblique AvantGarde-Demi AvantGarde-DemiOblique
syn keyword fmtFont contained AvantGardeCE-Book AvantGardeCE-BookOblique AvantGardeCE-Demi AvantGardeCE-DemiOblique
syn keyword fmtFont contained Bodoni Bodoni-Italic Bodoni-Bold Bodoni-BoldItalic Bodoni-Poster Bodoni-PosterCompressed
syn keyword fmtFont contained BodoniCE BodoniCE-Italic BodoniCE-Bold BodoniCE-BoldItalic BodoniCE-Poster BodoniCE-PosterCompressed
syn keyword fmtFont contained Bookman-Light Bookman-LightItalic Bookman-Demi Bookman-DemiItalic
syn keyword fmtFont contained BookmanCE-Light BookmanCE-LightItalic BookmanCE-Demi BookmanCE-DemiItalic
syn keyword fmtFont contained Carta Chicago ChicagoCE Clarendon Clarendon-Light Clarendon-Bold
syn keyword fmtFont contained ClarendonCE ClarendonCE-Light ClarendonCE-Bold CooperBlack CooperBlack-Italic
syn keyword fmtFont contained Copperplate-ThirtyTwoBC CopperPlate-ThirtyThreeBC Coronet-Regular CoronetCE-Regular
syn keyword fmtFont contained CourierCE CourierCE-Oblique CourierCE-Bold CourierCE-BoldOblique
syn keyword fmtFont contained Eurostile Eurostile-Bold Eurostile-ExtendedTwo Eurostile-BoldExtendedTwo
syn keyword fmtFont contained Eurostile EurostileCE-Bold EurostileCE-ExtendedTwo EurostileCE-BoldExtendedTwo
syn keyword fmtFont contained Geneva GenevaCE GillSans GillSans-Italic GillSans-Bold GillSans-BoldItalic GillSans-BoldCondensed
syn keyword fmtFont contained GillSans-Light GillSans-LightItalic GillSans-ExtraBold
syn keyword fmtFont contained GillSansCE-Roman GillSansCE-Italic GillSansCE-Bold GillSansCE-BoldItalic GillSansCE-BoldCondensed
syn keyword fmtFont contained GillSansCE-Light GillSansCE-LightItalic GillSansCE-ExtraBold
syn keyword fmtFont contained Goudy Goudy-Italic Goudy-Bold Goudy-BoldItalic Goudy-ExtraBould
syn keyword fmtFont contained HelveticaCE HelveticaCE-Oblique HelveticaCE-Bold HelveticaCE-BoldOblique
syn keyword fmtFont contained Helvetica-Condensed Helvetica-Condensed-Oblique Helvetica-Condensed-Bold Helvetica-Condensed-BoldObl
syn keyword fmtFont contained HelveticaCE-Condensed HelveticaCE-Condensed-Oblique HelveticaCE-Condensed-Bold
syn keyword fmtFont contained HelveticaCE-Condensed-BoldObl Helvetica-Narrow Helvetica-Narrow-Oblique Helvetica-Narrow-Bold
syn keyword fmtFont contained Helvetica-Narrow-BoldOblique HelveticaCE-Narrow HelveticaCE-Narrow-Oblique HelveticaCE-Narrow-Bold
syn keyword fmtFont contained HelveticaCE-Narrow-BoldOblique HoeflerText-Regular HoeflerText-Italic HoeflerText-Black
syn keyword fmtFont contained HoeflerText-BlackItalic HoeflerText-Ornaments HoeflerTextCE-Regular HoeflerTextCE-Italic
syn keyword fmtFont contained HoeflerTextCE-Black HoeflerTextCE-BlackItalic
syn keyword fmtFont contained JoannaMT JoannaMT-Italic JoannaMT-Bold JoannaMT-BoldItalic
syn keyword fmtFont contained JoannaMTCE JoannaMTCE-Italic JoannaMTCE-Bold JoannaMTCE-BoldItalic
syn keyword fmtFont contained LetterGothic LetterGothic-Slanted LetterGothic-Bold LetterGothic-BoldSlanted
syn keyword fmtFont contained LetterGothicCE LetterGothicCE-Slanted LetterGothicCE-Bold LetterGothicCE-BoldSlanted
syn keyword fmtFont contained LubalinGraph-Book LubalinGraph-BookOblique LubalinGraph-Demi LubalinGraph-DemiOblique
syn keyword fmtFont contained LubalinGraphCE-Book LubalinGraphCE-BookOblique LubalinGraphCE-Demi LubalinGraphCE-DemiOblique
syn keyword fmtFont contained Marigold Monaco MonacoCE MonaLisa-Recut Oxford Symbol Tekton
syn keyword fmtFont contained NewCennturySchlbk-Roman NewCenturySchlbk-Italic NewCenturySchlbk-Bold NewCenturySchlbk-BoldItalic
syn keyword fmtFont contained NewCenturySchlbkCE-Roman NewCenturySchlbkCE-Italic NewCenturySchlbkCE-Bold
syn keyword fmtFont contained NewCenturySchlbkCE-BoldItalic NewYork NewYorkCE
syn keyword fmtFont contained Optima Optima-Italic Optima-Bold Optima-BoldItalic
syn keyword fmtFont contained OptimaCE OptimaCE-Italic OptimaCE-Bold OptimaCE-BoldItalic
syn keyword fmtFont contained Palatino-Roman Palatino-Italic Palatino-Bold Palatino-BoldItalic
syn keyword fmtFont contained PalatinoCE-Roman PalatinoCE-Italic PalatinoCE-Bold PalatinoCE-BoldItalic
syn keyword fmtFont contained StempelGaramond-Roman StempelGaramond-Italic StempelGaramond-Bold StempelGaramond-BoldItalic
syn keyword fmtFont contained StempelGaramondCE-Roman StempelGaramondCE-Italic StempelGaramondCE-Bold StempelGaramondCE-BoldItalic
syn keyword fmtFont contained TimesCE-Roman TimesCE-Italic TimesCE-Bold TimesCE-BoldItalic
syn keyword fmtFont contained TimesNewRomanPSMT TimesNewRomanPS-ItalicMT TimesNewRomanPS-BoldMT TimesNewRomanPS-BoldItalicMT
syn keyword fmtFont contained TimesNewRomanCE TimesNewRomanCE-Italic TimesNewRomanCE-Bold TimesNewRomanCE-BoldItalic
syn keyword fmtFont contained Univers Univers-Oblique Univers-Bold Univers-BoldOblique
syn keyword fmtFont contained UniversCE-Medium UniversCE-Oblique UniversCE-Bold UniversCE-BoldOblique
syn keyword fmtFont contained Univers-Light Univers-LightOblique UniversCE-Light UniversCE-LightOblique
syn keyword fmtFont contained Univers-Condensed Univers-CondensedOblique Univers-CondensedBold Univers-CondensedBoldOblique
syn keyword fmtFont contained UniversCE-Condensed UniversCE-CondensedOblique UniversCE-CondensedBold UniversCE-CondensedBoldOblique
syn keyword fmtFont contained Univers-Extended Univers-ExtendedObl Univers-BoldExt Univers-BoldExtObl
syn keyword fmtFont contained UniversCE-Extended UniversCE-ExtendedObl UniversCE-BoldExt UniversCE-BoldExtObl
syn keyword fmtFont contained Wingdings-Regular ZapfChancery-MediumItalic ZapfChanceryCE-MediumItalic ZapfDingBats

syn keyword fmtFontEncoding contained utf-8 us-ascii native
" }}}
" Boolean directives
syn keyword fmtDirective contained abc2pscompat autoclef breakoneoln 






"vim:ts=4:sw=4:fdm=marker:fdc=3
