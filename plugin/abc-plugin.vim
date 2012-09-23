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
