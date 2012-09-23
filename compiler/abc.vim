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

