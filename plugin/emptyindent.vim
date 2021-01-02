" Vim plugin for indenting empty lines according to corresponding next non-empty lines
" Maintainer:   Lukas Pichlmann <pichlmannlukas@gmail.com>
" License:      This file is placed in the public domain.

if exists("g:loaded_emptyindent")
    finish
endif
let g:loaded_emptyindent = 1

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
from os.path import expanduser
# add plugin path so python module can be imported
sys.path.append(expanduser("~") + "/.vim/plugged/vim-emptyindent/plugin")
from empty_line_indentation import indent_file

# get filename from vimscript environment
filename = vim.eval("a:filename") 
# reindent file
reindented_text = indent_file(filename)
# pass reindented file as a list of lines to vimscript variable
vim.command("let reindented_text = %s" % reindented_text)
EOF

    call setline(1, reindented_text)
endfun

nnoremap <silent> <Plug>IndentCurrentFile :<C-U> call <SID>IndentEmptyLines(expand('%:p'))<CR>

if !exists("g:indentempty_use_defaults") || g:indentempty_use_defaults
    nmap <Leader>in <Plug>IndentCurrentFile
    " remove indentations again with the following mappping:
    nmap <Leader>rin :%s/^\s\+$//g<cr><c-o>
endif
