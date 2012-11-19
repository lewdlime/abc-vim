" Vim ftplugin file
" Language:   abc music programming language
" Maintainer: Lee Savide, <laughingman182@yahoo.com>
" Last Change: 2012 Jul 19
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

" Detect version
if !exists('b:abc_version')
    let ver_match = search('%abc\(-[1-9]\.\d\)\=', 'n', line('w$'))
    if ver_match == '%abc-1.5'
        let b:abc_version = '1.5'
    elseif ver_match == '%abc-1.6'
        let b:abc_version = '1.6'
    elseif ver_match == '%abc-1.7.6'
        let b:abc_version = '1.7'
    elseif ver_match == '%abc-2.0'
        let b:abc_version = '2.0'
    elseif ver_match == '%abc-2.1'
        let b:abc_version = '2.1'
" Preparing for future versions
"   elseif ver_match == '%abc-2.2'
"       let b:abc_version = '2.2'
"   elseif ver_match == '%abc-2.3'
"       let b:abc_version = '2.3'
"   elseif ver_match == '%abc-2.4'
"       let b:abc_version = '2.4'
    elseif ver_match == '%abc'
        let b:abc_version = '2.1' " If not given, latest version is used
    else
        let b:abc_version = '2.1' " If not found, latest version is used
    endif
endif

" If DocBook XML is being used, have it loaded
if 'xml' == b:docbk_type
    syn cluster xmlTagHook add=docbkKeyword
    syn cluster xmlRegionHook add=docbkRegion,docbkTitle,docbkRemark,docbkCite
endif
