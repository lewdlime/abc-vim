" Vim syntax file
" Language: abc music notation
" Maintainer: Lee Savide <laughingman182@yahoo.com>
" License: http://apache.org/licenses/LICENSE-2.0.txt
" GetLatestVimScripts: 4100 1 abc-vim.vmb

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

syn include @PS <sfile>:p:h/postscr.vim

" Datatypes {{{
syn case ignore
syn keyword abcTodo contained TODO
syn match abcInteger '\<[+-]\=\d\+\>' contained
syn match abcFloat '\<[+-]\=\d\+\.\>' contained
syn match abcFloat '\<[+-]\=\d\+\.\d*\(e[+-]\=\d\+\)\=\>' contained
syn match abcFloat '\<[+-]\=\.\d\+\(e[+-]\=\d\+\)\=\>' contained
syn match abcFloat '\<[+-]\=\d\+e[+-]\=\d\+\>' contained
syn cluster abcNumber contains=abcInteger,abcFloat
syn keyword abcMode contained maj[or] m[inor] ion[ian] aeo[lian] mix[olydian] dor[ian] phr[ygian] lyd[ian] loc[rian]
            \ nextgroup=abcKeyExplicit skipwhite
syn case match
syn match abcNoteChar '[A-Ga-g]' contained
syn match abcBoolean 'yes no true false on off 1 0' contained
syn match abcEncoding 'us-ascii\|utf-8\|native' contained nextgroup=abcInteger skipwhite
" }}}
" Fonts {{{
syn keyword abcFontKeyword contained nextgroup=abcEncoding skipwhite
        \ AlbertusMT AlbertusMT-Italic AlbertusMT-Light Apple-Chancery Apple-ChanceryCE
        \ AntiqueOlive-Roman AntiqueOlive-Italic AntiqueOlive-Bold AntiqueOlive-Compact
        \ AntiqueOliveCE-Roman AntiqueOliveCE-Italic AntiqueOliveCE-Bold
        \ AntiqueOliveCE-Compact ArialMT Arial-ItalicMT Arial-LightMT Arial-BoldMT
        \ Arial-BoldItalicMT ArialCE ArialCE-Italic ArialCE-Light ArialCE-Bold
        \ ArialCE-BoldItalic AvantGarde-Book AvantGarde-BookOblique AvantGarde-Demi
        \ AvantGarde-DemiOblique AvantGardeCE-Book AvantGardeCE-BookOblique
        \ AvantGardeCE-Demi AvantGardeCE-DemiOblique Bodoni Bodoni-Italic Bodoni-Bold
        \ Bodoni-BoldItalic Bodoni-Poster Bodoni-PosterCompressed BodoniCE BodoniCE-Italic
        \ BodoniCE-Bold BodoniCE-BoldItalic BodoniCE-Poster BodoniCE-PosterCompressed
        \ Bookman-Light Bookman-LightItalic Bookman-Demi Bookman-DemiItalic
        \ BookmanCE-Light BookmanCE-LightItalic BookmanCE-Demi BookmanCE-DemiItalic Carta
        \ Chicago ChicagoCE Clarendon Clarendon-Light Clarendon-Bold ClarendonCE
        \ ClarendonCE-Light ClarendonCE-Bold CooperBlack CooperBlack-Italic
        \ Copperplate-ThirtyTwoBC CopperPlate-ThirtyThreeBC Coronet-Regular
        \ CoronetCE-Regular CourierCE CourierCE-Oblique CourierCE-Bold
        \ CourierCE-BoldOblique Eurostile Eurostile-Bold Eurostile-ExtendedTwo
        \ Eurostile-BoldExtendedTwo Eurostile EurostileCE-Bold EurostileCE-ExtendedTwo
        \ EurostileCE-BoldExtendedTwo Geneva GenevaCE GillSans GillSans-Italic
        \ GillSans-Bold GillSans-BoldItalic GillSans-BoldCondensed GillSans-Light
        \ GillSans-LightItalic GillSans-ExtraBold GillSansCE-Roman GillSansCE-Italic
        \ GillSansCE-Bold GillSansCE-BoldItalic GillSansCE-BoldCondensed GillSansCE-Light
        \ GillSansCE-LightItalic GillSansCE-ExtraBold Goudy Goudy-Italic Goudy-Bold
        \ Goudy-BoldItalic Goudy-ExtraBould HelveticaCE HelveticaCE-Oblique
        \ HelveticaCE-Bold HelveticaCE-BoldOblique Helvetica-Condensed
        \ Helvetica-Condensed-Oblique Helvetica-Condensed-Bold Helvetica-Condensed-BoldObl
        \ HelveticaCE-Condensed HelveticaCE-Condensed-Oblique HelveticaCE-Condensed-Bold
        \ HelveticaCE-Condensed-BoldObl Helvetica-Narrow Helvetica-Narrow-Oblique
        \ Helvetica-Narrow-Bold Helvetica-Narrow-BoldOblique HelveticaCE-Narrow
        \ HelveticaCE-Narrow-Oblique HelveticaCE-Narrow-Bold
        \ HelveticaCE-Narrow-BoldOblique HoeflerText-Regular HoeflerText-Italic
        \ HoeflerText-Black HoeflerText-BlackItalic HoeflerText-Ornaments
        \ HoeflerTextCE-Regular HoeflerTextCE-Italic HoeflerTextCE-Black
        \ HoeflerTextCE-BlackItalic JoannaMT JoannaMT-Italic JoannaMT-Bold
        \ JoannaMT-BoldItalic JoannaMTCE JoannaMTCE-Italic JoannaMTCE-Bold
        \ JoannaMTCE-BoldItalic LetterGothic LetterGothic-Slanted LetterGothic-Bold
        \ LetterGothic-BoldSlanted LetterGothicCE LetterGothicCE-Slanted
        \ LetterGothicCE-Bold LetterGothicCE-BoldSlanted LubalinGraph-Book
        \ LubalinGraph-BookOblique LubalinGraph-Demi LubalinGraph-DemiOblique
        \ LubalinGraphCE-Book LubalinGraphCE-BookOblique LubalinGraphCE-Demi
        \ LubalinGraphCE-DemiOblique Marigold Monaco MonacoCE MonaLisa-Recut Oxford Symbol
        \ Tekton NewCennturySchlbk-Roman NewCenturySchlbk-Italic NewCenturySchlbk-Bold
        \ NewCenturySchlbk-BoldItalic NewCenturySchlbkCE-Roman NewCenturySchlbkCE-Italic
        \ NewCenturySchlbkCE-Bold NewCenturySchlbkCE-BoldItalic NewYork NewYorkCE Optima
        \ Optima-Italic Optima-Bold Optima-BoldItalic OptimaCE OptimaCE-Italic
        \ OptimaCE-Bold OptimaCE-BoldItalic Palatino-Roman Palatino-Italic Palatino-Bold
        \ Palatino-BoldItalic PalatinoCE-Roman PalatinoCE-Italic PalatinoCE-Bold
        \ PalatinoCE-BoldItalic StempelGaramond-Roman StempelGaramond-Italic
        \ StempelGaramond-Bold StempelGaramond-BoldItalic StempelGaramondCE-Roman
        \ StempelGaramondCE-Italic StempelGaramondCE-Bold StempelGaramondCE-BoldItalic
        \ TimesCE-Roman TimesCE-Italic TimesCE-Bold TimesCE-BoldItalic TimesNewRomanPSMT
        \ TimesNewRomanPS-ItalicMT TimesNewRomanPS-BoldMT TimesNewRomanPS-BoldItalicMT
        \ TimesNewRomanCE TimesNewRomanCE-Italic TimesNewRomanCE-Bold
        \ TimesNewRomanCE-BoldItalic Univers Univers-Oblique Univers-Bold
        \ Univers-BoldOblique UniversCE-Medium UniversCE-Oblique UniversCE-Bold
        \ UniversCE-BoldOblique Univers-Light Univers-LightOblique UniversCE-Light
        \ UniversCE-LightOblique Univers-Condensed Univers-CondensedOblique
        \ Univers-CondensedBold Univers-CondensedBoldOblique UniversCE-Condensed
        \ UniversCE-CondensedOblique UniversCE-CondensedBold
        \ UniversCE-CondensedBoldOblique Univers-Extended Univers-ExtendedObl
        \ Univers-BoldExt Univers-BoldExtObl UniversCE-Extended UniversCE-ExtendedObl
        \ UniversCE-BoldExt UniversCE-BoldExtObl Wingdings-Regular
        \ ZapfChancery-MediumItalic ZapfChanceryCE-MediumItalic ZapfDingBats
syn match abcFont '\h[\w-]*\s\+\%(us-ascii\|utf-8\|native\)\=\s\+\d\+' contained contains=abcFontKeyword,abcEncoding,abcInteger
syn match abcFont '\h[\w-]*\s\+\%(us-ascii\|utf-8\|native\)\=\s\+\d\.\d*\+' contained contains=abcFontKeyword,abcEncoding,abcFloat
" }}}
" Directives {{{
syn keyword abcPreProcKeyword contained nextgroup=abcDefine skipwhite
            \ abc2pscompat alignbars aligncomposer annotationfont autoclef
            \ barnumbers barsperstaff breakoneoln bgcolor botmargin bstemdown
cancelkey comball combinevoices composerfont composerspace contbarnb continueall custos dateformat deco decoration dynalign dynamic encoding flatbeams font footer footerfont format gchord gchordbox gchordfont graceslurs gracespace gstemdir header headerfont historyfont hyphenfont indent infofont infoline infoname infospace landscape leftmargin linebreak lineskipfac linewarn maxshrink maxstaffsep maxsysstaffsep measurebox measurefirst measurefont measurenb micronewps musiconly musicspace notespacingfactor oneperpage ornament pageheight pagewidth pango parskipfac partsbox partsfont partsspace pdfmark repeatfont rightmargin scale setdefl setfont-1 setfont-2 setfont-3 setfont-4 shiftunisson slurheight splittune squarebreve staffnonote staffsep staffwidth stemdir stemheight straightflags stretchlast stretchstaff subtitlefont subtitlespace sysstaffsep tempofont textfont textoption textspace timewarn titlecaps titlefont titleformat titleleft titlespace titletrim topmargin tuplets vocal vocalabove vocalfont voicefont volume wordsfont writefields break clip select tune voice clef newpage repbra repeat score sep setbarnb staff staffbreak staves tablature transpose vskip EPS multicol MIDI
syn keyword abcPreProcMIDIGlobal contained nextgroup=abcDefine skipwhite C
            \ nobarlines barlines fermatafixed fermataproportional ratio
            \ chordname deltaloudness
syn keyword abcPreProcMIDI contained nextgroup=abcDefine skipwhite bassprog beat beataccents beatmod
            \ beatstring chordattack chordprogram control droneon droneoff drum
            \ drumon drumoff drumbars drummap gchord grace gracedivider
            \ makechordchannels nobeataccents pitchblend portamento program
            \ ptstress randomchordattack ratio stressmodel snt tfranspose
            \ temperament temperamentlinear termperamentnormal
            \ transpose trim
syn keyword abcPreProcInt contained nextgroup=abcInteger skipwhite alignbars
            \ aligncomposer barsperstaff dynamic encoding gchord gstemdir
            \ measurefirst measurenb ornament pdfmark stemdir textoption tuplets
            \ vocal volume newpage setbarnb
syn match abcPreProcInt '%%transpose\s\+[+-]\d[#b]\=' contains=abcInteger
syn keyword abcPreProcBool contained nextgroup=abcBoolean skipwhite abc2pscompat
            \ autoclef breakoneoln bstemdown cancelkey comball combinevoices
            \ contbarnb continueall custos dynalign flatbeams gchordbox
            \ graceslurs hyphencont infoline landscape linewarn measurebox
            \ micronewps musiconly oneperpage pango partsbox setdefl
            \ shiftunisson splittune squarebreve staffnonote straightflags
            \ stretchlast stretchstaff timewarn titlecaps titleleft titletrim
            \ vocalabove writefields repbra
syn keyword abcPreProcFont contained nextgroup=abcFont skipwhite annotationfont composerfont font 

syn match abcPreProc excludenl '%%postscript\s\+.*$' contains=@PS
syn match abcPreProc excludenl '%%\I\i*\s\+.*$' contains=abcPreProc.*
syn match abcPreProc excludenl '%%MIDI ' nextgroup=abcPreProcMIDI.* skipwhite

syn match abcBreakSymbol '\(\d\%(:\d/\d\+\)\)\%([,\| ]\1\)*' contained
syn match abcClipSymbol '\(\d\%(:\d/\d\+\)\)\=-\1\=' contained
syn match abcSelectSymbol '\d\%(:\d/\d\+\)' contained contains=abcInteger
syn match abcSelectList '\d\+\%([,-]\d\+\)*' contained contains=abcInteger
syn match abcSelect '%%clip\s\+' contains=abcClipSymbol display skipwhite
syn match abcSelect '%%select ' nextgroup=abcSelectList display skipwhite
syn match abcRegexNormal contained transparent '\\^\|\\$\|\\|\|\\.\|\\*\|\\?\|\\+\|\\\[\|\\\]\|\\(\|\\)'
syn match abcRegexOperator contained '^\|$\||\|.\|*\|?\|+\|\[^\=\|\]\|(\|)'
syn match abcRegexCharacter contained '\\x\x\{,2}'
syn match abcSelect '%%select ' nextgroup=abcRegex.* display skipwhite
syn match abcSelect '%%tune ' nextgroup=abcRegex.* display skipwhite
syn match abcSelect '%%voice ' nextgroup=abcRegex.* display skipwhite
" Typeset Text
syn match abcTypeSet excludenl '%%text .*$'
syn match abcTypeSet excludenl '%%center .*$'
syn region abcTypeSet excludenl keepend matchgroup=abcTypeSetKeyword
            \ start='%%begintext\s\+\%(obeylines\|align\|justify\|ragged\|fill\|center\|skip\|right\)\='
            \ end='%%endtext'
syn match abcTypeSet excludenl '%%endtext'
syn region abcTypeSet matchgroup=abcTypeSetBegin start='%%begintext' skip='^\%(%%\)\=.*' matchgroup=abcTypeSetEnd end='%%endtext'
syn match abcTypeSetKeyword contained '%%\%(begintext\|endtext\|beginps\|endps\|beginsvg\|endsvg\)'
" 
syn match abcDefine excludenl '[^%]*$' contained
syn match abcPreProc '%%\I\i* ' nextgroup=abcDefine skipwhite
" }}}
" Fields {{{
syn match abcFieldContinue '^+:[^%]*'
syn match abcFieldIdentifier '^\a:'
syn match abcField '^[\a+]:[^%]*' nextgroup=abcFieldContinue skipnl skipwhite
syn region abcField start='\[\a:' skip='[^%\]]*' end='\]' contained oneline
" May be changed to make multiline field



syn match abcClefKeyword '\%(clef\)\|\%(m\%[iddle]\)\|\%(t\%[ranspose\]\)\|\%(o\%[ctave\]\)' contained
syn match abcClefName '\%(treble\|alto\|tenor\|bass\)\d\=\%([+-]8\)\=' contained
syn match abcClefName '\%(perc\|none\)' contained
syn match abcClefMiddle 'm\%[iddle]=' nextgroup=abcNoteChar display
syn match abcClefTranspose 't\%[ranspose]=' nextgroup=abcInteger display
syn match abcClefOctave 'o\%[ctave]=' nextgroup=abcInteger display
syn match abcClefStafflines 'stafflines=' nextgroup=abcInteger display
syn match abcClefCustom '\(\h\w*\):\1=' nextgroup=abcDefine contained
syn cluster abcClef contains=abcClef.*

syn match abcKey '^K:[^%]*' contains=@abcClef,abcDefine
syn match abcVoice '^V:[^%]*' contains=@abcClef,abcDefine

" }}}
" Tune Body {{{
syn match abcKeyIdentifier '[A-G][b#]\=\%(exp\)\=' contained nextgroup=abcMode,abcExplicit skipwhite
syn region abcKeyExplicit start='\%(\s\+[_=^][a-g]\)*' contains=abcNote contained

syn match abcRest 'z' contained nextgroup=abcNoteLength
syn match abcRest 'Z\%([1-9]*\d*\)\=' contained

"
syn region abcGrace start='{\/' end='}' contained nextgroup=abc
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

syn match abcStringDelimiter +"+
syn keyword abcChordStringType contained m[in] maj dim aug sus
syn match abcChordStringType '\%([1-9]\d*\)\|+' contained
syn region abcChordString matchgroup=abcStringDelimiter start=+"[A-G][b#]\=+ end=+"+ contains=abcChordString.* contained oneline

syn region abcAnnotation matchgroup=abcStringDelimiter start=++ end=+"+ contains= contained oneline

" }}}
" Top level {{{
syn region abcFreeText excludenl start='^\s*$' skip='^\%(\a:\|%%\)\@<!' excludenl end='^\s*$' transparent

syn match abcSpecialCharacter '\\u00[aA]9' conceal cchar=©
syn match abcSpecialCharacter '\\u266[dD]' conceal cchar=♭
syn match abcSpecialCharacter '\\u266[eE]' conceal cchar=♮
syn match abcSpecialCharacter '\\u266[fF]' conceal cchar=♯
syn match abcSpecialComment '^%abc\%(-[1-9]\.\d\)\='

syn region abcFileHeader start='\%(^[\a+]:\)' excludenl end='\^s*$' contained contains=abcComment
syn region abcTuneHeader start='\%(^X:.*\)\{1}\%(^T:.*\)*' end='^K:'
" Negative look-behind is fine, since it looks for lines that aren't empty
syn region abcPart matchgroup=abcPartIdentifier start='^P:' end='\%(^\s*$\)\|\%(^P:[^%]*$\)' keepend fold
syn region abcPart matchgroup=abcPartIdentifier start='\[P:[^%\]]*\]' excludenl end='\%(^\s*$\)\|\[P:' keepend fold
syn region abcVoice matchgroup=abcVoiceIdentifier start='^V:'
            \ matchgroup=NONE excludenl end='\%(^V:\)\|\%(^P:\)\|\%(^\s*$\)' keepend fold
syn region abcVoice matchgroup=abcVoiceIdentifier start='\[V:[^%\]]*\]'
            \ matchgroup=abcField end='\%(\[V:\)\|\%(\[P:\)' excludenl end='^\s*$' keepend fold
syn match abcComment excludenl '%\{1}.*$'
" }}}
" Syncing {{{
syn sync ccomment abcComment
syn sync linecont '\\$'

syn sync region abcFieldBeginSync start='^\a:' excludenl end='$' nextgroup=abcFieldContinueSync skipwhite skipnl
syn sync match abcFieldContinueSync '^+:' extend
syn sync match abcFieldSync groupthere abcFieldBeginSync '^+:'
syn sync region abcFieldRegionSync start='^\a:' excludenl end='$' keepend oneline
syn sync region abcFieldRegionSync start='\[\a:' end='\]' keepend oneline
syn sync match abcFieldBeginSync '\[\a:'
syn sync match abcFieldSync groupthere abcFieldBeginSync '\]'

syn sync region abcTypeSetSync start='%%begin' end='%%end'
syn sync match abcTypeSetBegin '%%begin'
syn sync match abcTypeSetEnd '%%end'
syn sync match abcTypeSetSync grouphere abcTypeSetEnd '%%begin'
syn sync match abcTypeSetSync groupthere abcTypeSetBegin '%%end'

syn sync match abcSlurEndSync ')'
syn sync match abcSlurBeginSync '([^\d]'
syn sync match abcSlurSync grouphere abcSlurEndSync '([^\d]'
syn sync match abcSlurSync groupthere abcSlurBeginSync ')'

syn sync match abcTupletSync groupthere abcSlurBeginSync '[1-9]\%(:[1-9]\)\{,2}'

syn sync match abcChordBeginSync '\['
syn sync match abcChordEndSync '\]'
syn sync match abcChordGroupSync grouphere abcChordEndSync '\['
syn sync match abcChordGroupSync groupthere abcChordBeginSync '\]'

syn sync region abcHeaderRegionSync start='^X:' end='^K:' keepend
syn sync match abcHeaderSync grouphere abcHeaderRegionSync '^X:'

syn sync region abcBodyRegionSync start='^K:' excludenl end='^\s*$' keepend
syn sync match abcBodySync grouphere abcBodyRegionSync '\%(^\s*$\)\@<!'

syn sync region abcPartBodySync start='^P:' excludenl end='^P:\|\%(^\s*$\)'
syn sync region abcPartBodySync start='\[P:' excludenl end='\[P:\|\%(^\s*$\)'
syn sync match abcPartSync grouphere abcPartBody '^P:\|\[P:\|\%(^\s*$\)'

syn sync region abcVoiceIdentifierSync start='^V:' excludenl end='^V:\|^P:\|\%(^\s*$\)'
syn sync region abcVoiceIdentifierSync start='\[V:' excludenl end='\[V:\|\[P:\|\%(^\s*$\)'
syn sync match abcVoiceSync grouphere abcVoiceIdentifierSync '\%(^V:\)\|\%(\[V:\)'

syn sync region abcSpecialCommentSync start='^%abc\%(-[1-9]\.\d\)\=' excludenl end='^\s*$'
syn sync match abcFileHeaderSync groupthere abcSpecialCommentSync '\%(^\s*$\)\@<!'
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
