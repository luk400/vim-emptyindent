" Vim plugin for indenting empty lines according to corresponding next non-empty lines
" Maintainer:	Lukas Pichlmann <pichlmannlukas@gmail.com>
" License:	This file is placed in the public domain.

if exists("g:loaded_emptyindent")
    finish
endif
let g:loaded_emptyindent = 1
let b:plugin_path = expand('<sfile>:p:h')

fun! s:IndentEmptyLines(filename)
    " check if vim is compiled with python3 
    if !has('python3')
        echo "Error: Requires Vim compiled with +python3"
        finish
    endif
	w

python3 << EOF
import vim 
import sys
plugin_path = vim.eval("b:plugin_path")
sys.path.append(plugin_path)
from empty_line_indentation import indent_file

filename = vim.eval("a:filename") 
reindented_text = indent_file(filename)
vim.command("let reindented_text = %s" % reindented_text)
EOF
    call setline(1, reindented_text)
endfun

nnoremap <silent> <Plug>IndentCurrentFile :<C-U> call <SID>IndentEmptyLines(expand('%:p'))<CR>

if !exists("g:indentempty_use_defaults") || g:indentempty_use_defaults
    nmap <Leader>in <Plug>IndentCurrentFile
    nmap <Leader>rmin :%s/^\s\+$//g<cr>
endif
