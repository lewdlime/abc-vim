" Vim syntax file
" Language: abc music notation
" Maintainer: Lee Savide <laughingman182@yahoo.com>
" License: http://apache.org/licenses/LICENSE-2.0.txt
" Use vundle to keep this script up to date!
" https://github.com/gmarik/vundle/

if version < 600
    syntax clear
elseif exists('b:current_syntax')
    finish
endif

if version >= 600
    setlocal iskeyword=33-127,^(,^),^<,^>,^[,^],^{,^},^/,^\\,^%,^
else
    set iskeyword=33-127,^(,^),^<,^>,^[,^],^{,^},^/,^\\,^%,^
endif

syn include @PS $VIMRUNTIME/syntax/postscr.vim

" Datatypes {{{
syn case ignore
syn keyword abcTodo contained TODO
syn match abcStringDelimiter +"+
syn match abcInteger '\<[+-]\=\d\+\>' contained
syn match abcFloat '\<[+-]\=\d\+\.\>' contained
syn match abcFloat '\<[+-]\=\d\+\.\d*\(e[+-]\=\d\+\)\=\>' contained
syn match abcFloat '\<[+-]\=\.\d\+\(e[+-]\=\d\+\)\=\>' contained
syn match abcFloat '\<[+-]\=\d\+e[+-]\=\d\+\>' contained
syn cluster abcNumber contains=abcInteger,abcFloat
syn keyword abcMode contained maj[or] m[inor] ion[ian] aeo[lian] mix[olydian] dor[ian] phr[ygian] lyd[ian] loc[rian] nextgroup=abcKeyExplicit skipwhite
syn case match
syn match abcSpecialChar '\\u00[aA]9' contained conceal cchar=©
syn match abcSpecialChar '\\u266[dD]' contained conceal cchar=♭
syn match abcSpecialChar '\\u266[eE]' contained conceal cchar=♮
syn match abcSpecialChar '\\u266[fF]' contained conceal cchar=♯
syn match abcUnit '\<[1-9]\d*\%(\.\d*\)\=\%(in\|cm\|mm\|pt\)\>' contains=abcFloat contained
syn match abcNoteChar '[A-Ga-g][b#]\=' contained
syn match abcBoolean 'yes\|no\|true\|false\|on\|off\|[01]' contained
syn match abcEncoding 'us-ascii\|utf-8\|native' contained
syn match abcFontEncoding 'us-ascii\|utf-8\|native' contained nextgroup=abcInteger skipwhite
syn match abcFontOperator '\$[0-4]' contained

syn match abcFieldIdentifier '^[\a+]:' contained
syn match abcBodyFieldIdentifier '\[[\a]:' contained
" }}}
" Fonts {{{
" Font Keywords {{{
syn keyword abcFontKeyword contained nextgroup=abcEncoding skipwhite \ AlbertusMT AlbertusMT-Italic AlbertusMT-Light Apple-Chancery Apple-ChanceryCE \ AntiqueOlive-Roman AntiqueOlive-Italic AntiqueOlive-Bold AntiqueOlive-Compact \ AntiqueOliveCE-Roman AntiqueOliveCE-Italic AntiqueOliveCE-Bold \ AntiqueOliveCE-Compact ArialMT Arial-ItalicMT Arial-LightMT Arial-BoldMT \ Arial-BoldItalicMT ArialCE ArialCE-Italic ArialCE-Light ArialCE-Bold \ ArialCE-BoldItalic AvantGarde-Book AvantGarde-BookOblique AvantGarde-Demi \ AvantGarde-DemiOblique AvantGardeCE-Book AvantGardeCE-BookOblique \ AvantGardeCE-Demi AvantGardeCE-DemiOblique Bodoni Bodoni-Italic Bodoni-Bold \ Bodoni-BoldItalic Bodoni-Poster Bodoni-PosterCompressed BodoniCE BodoniCE-Italic \ BodoniCE-Bold BodoniCE-BoldItalic BodoniCE-Poster BodoniCE-PosterCompressed \ Bookman-Light Bookman-LightItalic Bookman-Demi Bookman-DemiItalic \ BookmanCE-Light BookmanCE-LightItalic BookmanCE-Demi BookmanCE-DemiItalic Carta \ Chicago ChicagoCE Clarendon Clarendon-Light Clarendon-Bold ClarendonCE \ ClarendonCE-Light ClarendonCE-Bold CooperBlack CooperBlack-Italic \ Copperplate-ThirtyTwoBC CopperPlate-ThirtyThreeBC Coronet-Regular \ CoronetCE-Regular CourierCE CourierCE-Oblique CourierCE-Bold \ CourierCE-BoldOblique Eurostile Eurostile-Bold Eurostile-ExtendedTwo \ Eurostile-BoldExtendedTwo Eurostile EurostileCE-Bold EurostileCE-ExtendedTwo \ EurostileCE-BoldExtendedTwo Geneva GenevaCE GillSans GillSans-Italic \ GillSans-Bold GillSans-BoldItalic GillSans-BoldCondensed GillSans-Light \ GillSans-LightItalic GillSans-ExtraBold GillSansCE-Roman GillSansCE-Italic \ GillSansCE-Bold GillSansCE-BoldItalic GillSansCE-BoldCondensed GillSansCE-Light \ GillSansCE-LightItalic GillSansCE-ExtraBold Goudy Goudy-Italic Goudy-Bold \ Goudy-BoldItalic Goudy-ExtraBould HelveticaCE HelveticaCE-Oblique \ HelveticaCE-Bold HelveticaCE-BoldOblique Helvetica-Condensed \ Helvetica-Condensed-Oblique Helvetica-Condensed-Bold Helvetica-Condensed-BoldObl \ HelveticaCE-Condensed HelveticaCE-Condensed-Oblique HelveticaCE-Condensed-Bold \ HelveticaCE-Condensed-BoldObl Helvetica-Narrow Helvetica-Narrow-Oblique \ Helvetica-Narrow-Bold Helvetica-Narrow-BoldOblique HelveticaCE-Narrow \ HelveticaCE-Narrow-Oblique HelveticaCE-Narrow-Bold \ HelveticaCE-Narrow-BoldOblique HoeflerText-Regular HoeflerText-Italic \ HoeflerText-Black HoeflerText-BlackItalic HoeflerText-Ornaments \ HoeflerTextCE-Regular HoeflerTextCE-Italic HoeflerTextCE-Black \ HoeflerTextCE-BlackItalic JoannaMT JoannaMT-Italic JoannaMT-Bold \ JoannaMT-BoldItalic JoannaMTCE JoannaMTCE-Italic JoannaMTCE-Bold \ JoannaMTCE-BoldItalic LetterGothic LetterGothic-Slanted LetterGothic-Bold \ LetterGothic-BoldSlanted LetterGothicCE LetterGothicCE-Slanted \ LetterGothicCE-Bold LetterGothicCE-BoldSlanted LubalinGraph-Book \ LubalinGraph-BookOblique LubalinGraph-Demi LubalinGraph-DemiOblique \ LubalinGraphCE-Book LubalinGraphCE-BookOblique LubalinGraphCE-Demi \ LubalinGraphCE-DemiOblique Marigold Monaco MonacoCE MonaLisa-Recut Oxford Symbol \ Tekton NewCennturySchlbk-Roman NewCenturySchlbk-Italic NewCenturySchlbk-Bold \ NewCenturySchlbk-BoldItalic NewCenturySchlbkCE-Roman NewCenturySchlbkCE-Italic \ NewCenturySchlbkCE-Bold NewCenturySchlbkCE-BoldItalic NewYork NewYorkCE Optima \ Optima-Italic Optima-Bold Optima-BoldItalic OptimaCE OptimaCE-Italic \ OptimaCE-Bold OptimaCE-BoldItalic Palatino-Roman Palatino-Italic Palatino-Bold \ Palatino-BoldItalic PalatinoCE-Roman PalatinoCE-Italic PalatinoCE-Bold \ PalatinoCE-BoldItalic StempelGaramond-Roman StempelGaramond-Italic \ StempelGaramond-Bold StempelGaramond-BoldItalic StempelGaramondCE-Roman \ StempelGaramondCE-Italic StempelGaramondCE-Bold StempelGaramondCE-BoldItalic \ TimesCE-Roman TimesCE-Italic TimesCE-Bold TimesCE-BoldItalic TimesNewRomanPSMT \ TimesNewRomanPS-ItalicMT TimesNewRomanPS-BoldMT TimesNewRomanPS-BoldItalicMT \ TimesNewRomanCE TimesNewRomanCE-Italic TimesNewRomanCE-Bold \ TimesNewRomanCE-BoldItalic Univers Univers-Oblique Univers-Bold \ Univers-BoldOblique UniversCE-Medium UniversCE-Oblique UniversCE-Bold \ UniversCE-BoldOblique Univers-Light Univers-LightOblique UniversCE-Light \ UniversCE-LightOblique Univers-Condensed Univers-CondensedOblique \ Univers-CondensedBold Univers-CondensedBoldOblique UniversCE-Condensed \ UniversCE-CondensedOblique UniversCE-CondensedBold \ UniversCE-CondensedBoldOblique Univers-Extended Univers-ExtendedObl \ Univers-BoldExt Univers-BoldExtObl UniversCE-Extended UniversCE-ExtendedObl \ UniversCE-BoldExt UniversCE-BoldExtObl Wingdings-Regular \ ZapfChancery-MediumItalic ZapfChanceryCE-MediumItalic ZapfDingBats
" }}}
syn match abcFont '\h[\w-]*\s\+\%(us-ascii\|utf-8\|native\)\=\s\+\d\+' contained contains=abcFontKeyword,abcFontEncoding,abcInteger
syn match abcFont '\h[\w-]*\s\+\%(us-ascii\|utf-8\|native\)\=\s\+\d\+\%(\.\d*\)\=' contained contains=abcFontKeyword,abcFontEncoding,abcFloat
" }}}
" Directives {{{
" Directive arguments
syn match abcDefine excludenl '[^%]*$' contained
" Regex
syn match abcBreak '\(\d\%(:\d/\d\+\)\)\%([,\| ]\1\)*' contained
syn match abcClip '\(\d\%(:\d/\d\+\)\)\=-\1\=' contained
syn match abcSelect '\d\%(:\d/\d\+\)' contained contains=abcInteger
syn match abcSelectList '\d\+\%([,-]\d\+\)*' contained contains=abcInteger
syn match abcRegexNormal contained transparent '\\^\|\\$\|\\|\|\\.\|\\*\|\\?\|\\+\|\\\[\|\\\]\|\\(\|\\)'
syn match abcRegexOperator contained '^\|$\||\|.\|*\|?\|+\|\[^\=\|\]\|(\|)'
syn match abcRegexChar contained '\\x\x\{,2}'
syn cluster abcRegexCluster contains=abcRegexNormal,abcRegexOperator,abcRegexChar
" Keywords {{{
syn keyword abcRegexKeyword contained nextgroup=abcClip skipwhite clip
syn keyword abcRegexKeyword contained nextgroup=abcBreak skipwhite break
syn keyword abcRegexKeyword contained nextgroup=@abcRegexCluster skipwhite select tune voice

syn keyword abcPreProcKeyword contained nextgroup=abcDefine skipwhite abc2pscompat alignbars aligncomposer annotationfont autoclef barnumbers barsperstaff breakoneoln bgcolor botmargin bstemdown cancelkey comball combinevoices composerfont composerspace contbarnb continueall custos dateformat deco decoration dynalign dynamic encoding flatbeams font footer footerfont format gchord gchordbox gchordfont graceslurs gracespace gstemdir header headerfont historyfont hyphencont indent infofont infoline infoname infospace landscape leftmargin linebreak lineskipfac linewarn maxshrink maxstaffsep maxsysstaffsep measurebox measurefirst measurefont measurenb micronewps musiconly musicspace notespacingfactor oneperpage ornament pageheight pagewidth pango parskipfac partsbox partsfont partsspace pdfmark postscript repeatfont rightmargin scale setdefl setfont-1 setfont-2 setfont-3 setfont-4 shiftunisson slurheight splittune squarebreve staffnonote staffsep staffwidth stemdir stemheight straightflags stretchlast stretchstaff subtitlefont subtitlespace sysstaffsep tempofont textfont textspace timewarn titlecaps titlefont titleformat titleleft titlespace titletrim topmargin topspace tuplets vocal vocalabove vocalfont vocalspace voicefont volume wordsfont wordsspace writefields
syn match abcPreProc '%%\h[\w-]*' contains=abcPreProcKeyword nextgroup=abcDefine skipwhite
syn match abcMIDI '%%MIDI' contains=abcPreProcKeyword nextgroup=abcMIDIKeyword skipwhite

" Typeset text
syn keyword abcTypeSetKeyword contained beginps beginsvg begintext endps endsvg endtext center clef EPS multicol newpage repbra repeat score sep setbarnb staff staffbreak staves tablature transpose vskip
syn keyword abcTypeSetKeyword contained nextgroup=abcTextOptionKeyword skipwhite begintext textoption
syn keyword abcTextOptionKeyword contained obeylines align justify ragged fill center skip right

syn region abcTypeSet matchgroup=abcTypeSetKeyword start='%%text' excludenl end='\_$' contains=abcFontOperator oneline
syn region abcTypeSet  matchgroup=abcTypeSetKeyword start='%%center' excludenl end='\_$' contains=abcFontOperator oneline
syn region abcTypeSet matchgroup=abcTypeSetKeyword start='%%begintext' skip='^\%(%%\)\=.*' end='%%endtext' fold keepend
" }}}
syn region abcPS start='%%postscript' contains=abcPreProcKeyword nextgroup=@PS skipwhite
syn region abcPS matchgroup=abcTypeSetKeyword start='%%beginps' end='%%endps' fold keepend contains=@PS
" }}}
" Tune Body {{{
syn keyword abcDecorationKeyword contained !trill! !trill(! !trill)! !lowermordent! !uppermordent! !mordent! !pralltriller! !roll! !turn! !turnx! !invertedturn! !invertedturnx! !arpeggia! !>! !accent! !emphasis! !fermata! !invertedfermata! !tenuto! !0! !1! !2! !3! !4! !5! !+! !plus! !snap! !slide! !wedge! !upbow! !downbow! !open! !thumb! !breath! !pppp! !ppp! !pp! !p! !mp! !mf! !f! !ff! !fff! !ffff! !sfz! !crescendo(! !<(! !crescendo)! !<)! !diminuendo(! !>(! !diminuendo)! !>)! !segno! !coda! !D.S.! !D.C.! !dacoda! !dacapo! !fine! !shortphrase! !mediumphrase! !longphrase! . ~ H L M O P S T u v
syn match abcKeyIdentifier '[A-G][b#]\=\%(exp\)\=' contained nextgroup=abcMode,abcExplicit skipwhite
syn region abcKeyExplicit start='\%(\s\+[_=^][a-g]\)*' contains=abcNote contained

syn match abcRest '[xz]' contained nextgroup=abcNoteLength
syn match abcRest 'Z\%([1-9]*\d*\)\=' contained contains=abcInteger
syn match abcSpacer '[yY]' contained nextgroup=abcFloat,abcChordString,abcDecoration
" Grace notes
syn region abcGrace start='{\/' end='}' contained nextgroup=abcChordString
syn match abcNote '[A-Ga-g][_=^]\{,2}' contained nextgroup=abcOctave
syn match abcOctave +[,']*+ contained nextgroup=abcNoteLength
syn match abcNoteLength '*[1-9]*\d*/[248]\=' contained
syn match abcTie +- \=+ contained

syn match abcNoteDelimiter '[`-/\\ ]*' contained
syn region abcSlur start='(' end=')' keepend contained
syn region abcChord start='\[' end='\]' keepend contained oneline
syn match abcTuplet '([1-9]\%(:[1-9]\)\{,2}' contained

syn match abcBarDelimiter '|\|\]\|\[\{1,2}' contained
syn match abcRepeatDelimiter '[:|][:|]' contained
syn match abcRepeatDelimiter ':\=[|\[\]][1-9]\%([,-][1-9]\d*\)*' contained

syn keyword abcChordStringType contained m[in] maj dim aug sus
syn match abcChordStringType '\%([1-9]\d*\)\|+' contained
syn region abcChordString matchgroup=abcStringDelimiter start=+"[A-G][b#]\=+ end=+"+ contains=abcChordStringType contained oneline

syn region abcAnnotation matchgroup=abcStringDelimiter start=+"\%(^\|_\|<\|>\|@\)+ skip='[^"]*' end=+"+ contains=@PS contained oneline
syn region abcDecoration start='!' end='!' contains=abcDecorationKeyword contained keepend oneline
" }}}
" Fields {{{
syn region abcFieldContinue matchgroup=abcFieldIdentifier start='^+:' excludenl matchgroup=NONE end='%\|\_$' keepend oneline contained
syn region abcField matchgroup=abcFieldIdentifier start='^[\a+]:' matchgroup=NONE excludenl end='%\|\_$' nextgroup=abcFieldContinue skipnl skipwhite
syn region abcBodyField start='\[\a:' end='\]' contains=abcFieldContent contained keepend oneline

syn keyword abcClefKeyword clef= m[iddle]= t[ranspose\]= o[ctave]= contained
syn keyword abcClefName treble alto tenor bass nextgroup=abcClefOptional contained
syn keyword abcClefName perc none contained
syn match abcClefOptional '\d\=\%([+-]8\)\=' contained
syn match abcClefCustom '\(\h\w*\):\1=' nextgroup=abcDefine contained
syn cluster abcClef contains=abcClefKeyword,abcClefName,abcClefCustom
syn match abcClefMiddle 'm\%[iddle]=' nextgroup=abcNoteChar display
syn match abcClefTranspose 't\%[ranspose]=' nextgroup=abcInteger display
syn match abcClefOctave 'o\%[ctave]=' nextgroup=abcInteger display
syn match abcClefStafflines 'stafflines=' nextgroup=abcInteger display

syn region abcKey start='^K:' end='\ze%' contains=@abcClef
syn region abcVoice matchgroup=abcFieldIdentifier start='^V:' matchgroup=NONE excludenl end='\_$\|\ze%' contains=@abcClef
" }}}
" Top level {{{
syn match abcSpecialComment '^%abc\%(-[1-9]\.\d\)\='
syn cluster abcStringChars contains=abcFontOperator,abcSpecialCharacter

syn match abcFieldIdentifier '^[\a+]:' contained
syn match abcBodyFieldIdentifier '\[[\a]:' contained
syn match abcFieldContent '\a:\zs[^%]*' contained

syn region abcFileHeader start='^[A-DF-HIL-ORSUZmr]:' excludenl end='\_^s*\_$' contained contains=abcComment
syn region abcTuneHeader start='^X:' end='^K:' keepend fold display

syn region abcPartBody matchgroup=abcFieldIdentifier start='^P:' excludenl matchgroup=abcFieldIdentifier end='^P:[^%]*$' matchgroup=NONE end='^\s*$' keepend fold
syn region abcPartBody matchgroup=abcFieldIdentifier start='\[P:[^%\]]*\]' end='\[P:' matchgroup=NONE excludenl end='^\s*$' keepend fold
syn region abcVoiceBody matchgroup=abcFieldIdentifier start='^V:' end='\%(^V:\)\|\%(^P:\)' matchgroup=NONE excludenl end='\%(\_^\s*\_$\)' keepend fold
syn region abcVoiceBody matchgroup=abcVoiceIdentifier start='\[V:[^%\]]*\]' matchgroup=abcBodyFieldIdentifier end='\%(\[V:\)\|\%(\[P:\)' matchgroup=NONE excludenl end='\_^\s*\_$' keepend fold
syn region abcFreeText excludenl start='^\s*$' skip='^\%(\a:\|%%\)\@<!' excludenl end='^\s*$' transparent fold
syn match abcComment excludenl '%.*\_$'
syn region abcPreProc matchgroup=abcPreProcKeyword start='%%\h[\w-]*' end='\_$' nextgroup=abcDefine skipwhite
syn match abcPreProc '^I:\h[\w-]*' contains=abcFieldIdentifier nextgroup=abcDefine skipwhite
syn region abcPreProc matchgroup=abcFieldIdentifier start='\[I:\h[\w-]*' end='\]' contains=abcDefine oneline keepend
syn region abcEmptyLine start='^\s*' excludenl end='\_$' transparent display keepend
" }}}
" Syncing {{{
" Sync on abc comments
syn sync ccomment abcComment
" Register line continuations
syn sync linecont '\\\_$'
" Sync between each barline
syn sync match abcStatementSync grouphere abcMeasure '|\|\[\|\]'
syn sync match abcStatementSync groupthere abcMeasure '|\|\[\|\]'
" Sync typeset text regions
syn sync match abcTypeSetSync grouphere abcTypeSet '%%begin'
syn sync match abcTypeSetSync groupthere abcTypeSet '%%end'
" Sync tuplet regions
syn sync match abcSlurSync grouphere abcSlur '([^\d]'
syn sync match abcSlurSync groupthere abcSlur ')'
" Sync chord note regions
syn sync match abcBracketSync grouphere abcChord '\['
syn sync match abcBracketSync groupthere abcChord '\]'
" Sync on inline fields
syn sync match abcBracketSync grouphere abcFieldIdentifier '\[\a:'
syn sync match abcBracketSync groupthere abcFieldIdentifier '\]'
" Sync grace note regions
syn sync match abcCurlySync grouphere abcGrace '{'
syn sync match abcCurlySync groupthere abcGrace '}'
" Sync tune headers
syn sync match abcHeaderSync grouphere abcTuneHeader '^X:'
syn sync match abcHeaderSync groupthere abcTuneHeader '^K:'
" Sync from a P: field in the body to the next P: field
" This also applies to the header, so thats fine
syn sync match abcPartBodySync grouphere abcPartBody '\%\_^P:\)\|\%(\[P:\)'
syn sync match abcPartBodySync groupthere abcPartBody '\%(\_^P:\)\|\%(\[P:\)\|\%(\_^\s*\_$\)'
" Sync from a V: field in the body to the next V: field
" This also applies to the header, so thats fine
" Also, sync up to the next part, since that takes higher precedence
syn sync match abcVoiceSync grouphere abcVoiceBody '\%(\_^V:\)\|\%(\[V:\)'
syn sync match abcVoiceSync grouphere abcVoiceBody '\%(\_^V:\)\|\%(\[V:\)\|\%(\_^P:\)\|\%(\[P:\)\|\%(\_^\s*\_$\)'
" Sync the file header
syn sync match abcFileHeaderSync grouphere abcFileHeader '%abc\%(-[1-9]\.\d\)\='
syn sync match abcFileHeaderSync groupthere abcFileHeader '\%(^\s*$\)\@<!'
" }}}
" Highlighting {{{
if version >= 508 || !exists('did_abc_syn_inits')
    if version < 508
        let did_abc_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    "HiLink abcRegex         vimPatRegion 
    HiLink abcRegex.*        String
    HiLink abcSelectSymbol   String
    " While this isn't the correct form of regex highlighting,
    " it's close enough
    HiLink abcSpecialComment  PreProc
    HiLink abcPreProc         PreProc
    HiLink abcFreeText        Normal
    HiLink abcFieldIdentifier Type
    HiLink abcField           Statement
    HiLink @abcClef           Keyword
    HiLink abcNote            Constant
    HiLink abcRest            Constant
    HiLink abcChord           Identifier
    HiLink abcBodyField       Statement
    HiLink abcBarDelimiter    Delimiter
    HiLink abcTie             Delimiter
    
    HiLink abcComment        Comment
    HiLink abcConstant       Constant
    HiLink abcString         String
    HiLink abcCharacter      Character
    HiLink abcNumber         Number
    HiLink abcBoolean        Boolean
    HiLink abcIdentifier     Identifier
    HiLink abcFunction       Function
    HiLink abcStatement      Statement
    HiLink abcConditional    Conditional
    HiLink abcRepeat         Repeat
    HiLink abcLabel          Label
    HiLink abcOperator       Operator
    HiLink abcKeyword        Keyword
    HiLink abcException      Exception
    HiLink abcPreProc        PreProc
    HiLink abcInclude        Include
    HiLink abcMacro          Macro
    HiLink abcPreCondit      PreCondit
    HiLink abcType           Type
    HiLink abcSpecial        Special
    HiLink abcSpecialChar    SpecialChar
    HiLink abcTag            Tag
    HiLink abcDelimiter      Delimiter
    HiLink abcSpecialComment SpecialComment
    HiLink abcDebug          Debug
    HiLink abcUnderlined     Underlined
    HiLink abcError          Error
    HiLink abcTodo           Todo

    delcommand HiLink
endif " }}}

let b:current_syntax = 'abc'
" vim: ts=4
