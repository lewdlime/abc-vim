# Makefile for abc-vim.
#TODO 	 src/compiler/abc/abcpp.vim
#TODO	 src/compiler/abc/music21.vim
#TODO	 src/compiler/abc/clam-chordata.vim
#TODO	 src/ftplugin/abc/abcpp.vim
#TODO	 src/ftplugin/abc/music21.vim
#TODO	 src/ftplugin/abc/clam-chordata.vim
# LICENSE {{{
#   Copyright 2012 Lee Savide
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
# }}} 

PLUGIN = abc-vim

DIRS = src/autoload/
DIRS += src/colors/
DIRS += src/compiler/
DIRS += src/compiler/abc/
#DIRS += src/compiler/postscr/
DIRS += src/ftplugin/
DIRS += src/ftplugin/abc/
#DIRS += src/ftplugin/postscr/
DIRS += src/doc/
DIRS += src/plugin/
DIRS += src/syntax/

SOURCE = src/autoload/abc.vim
SOURCE += src/autoload/abh.vim
SOURCE += src/autoload/fmt.vim
SOURCE += src/autoload/abc/tune_index.vim
#SOURCE += src/autoload/postscr.vim
#SOURCE += src/colors/musiccolors.vim
SOURCE += src/compiler/abc.vim
SOURCE += src/compiler/abc/abcm2ps.vim
SOURCE += src/compiler/abc/abc2midi.vim
SOURCE += src/compiler/abc/abc2abc.vim
#SOURCE += src/compiler/abc/abc2prt.vim
SOURCE += src/compiler/abc/abcmatch.vim
SOURCE += src/compiler/abc/abctab2ps.vim
SOURCE += src/compiler/abc/abcbarchk.vim
SOURCE += src/compiler/abc/midi2abc.vim
SOURCE += src/compiler/abc/yaps.vim
#SOURCE += src/compiler/postscr/adobe.vim
#SOURCE += src/compiler/postscr/ghostscript.vim
#SOURCE += src/compiler/postscr/gv.vim
SOURCE += src/ftplugin/abc.vim
SOURCE += src/ftplugin/abh.vim
SOURCE += src/ftplugin/fmt.vim
SOURCE += src/ftplugin/abc/opt.vim
SOURCE += src/ftplugin/abc/var.vim
SOURCE += src/ftplugin/abc/func.vim
#SOURCE += src/ftplugin/postscr.vim
SOURCE += src/doc/abc-vim.txt
SOURCE += src/plugin/abc-plugin.vim
SOURCE += src/syntax/abc.vim
SOURCE += src/syntax/abh.vim
SOURCE += src/syntax/fmt.vim

${PLUGIN}.vmb: ${SOURCE}
	vim --cmd 'let g:plugin_name="${PLUGIN}"' -S build.vim -cq!

prepare:
	mkdir ${DIRS}
	touch ${SOURCE}

install:
	rsync -Rv ${SOURCE} ${HOME}/.vim/

clean:
	rm ${PLUGIN}.vmb
