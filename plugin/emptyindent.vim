" Vim plugin for indenting empty lines according to corresponding next non-empty lines
" Last Change:  December 31, 2020
" Maintainer:	Lukas Pichlmann <pichlmannlukas@gmail.com>
" License:	This file is placed in the public domain.

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
    
	w " save current file
python3 << EOF
# check if necessary packages are installed
try:
    import vim
    import re
except ModuleNotFoundError as err:
    print(err)

def get_next_nonempty_line(lines, idx):
    lines=lines[(idx+1):]
    idx_nonempty = [i for i, line in enumerate(lines) if not re.match("^\s+$", line)]
    if len(idx_nonempty):
        return idx + idx_nonempty[0] + 1
    else: # if there's no more non-empty lines, return -1 as index to get last line
        return -1

def indent_file(filename):
    with open(filename,"r") as f:
        lines=f.readlines()
    
    # find empty lines and indent them if next non-empty 
    # line is indented
    for i, line in enumerate(lines):
        # check if current line contains just a line break
        if re.match("^\n$", line): 
            # get index of next non-empy line
            idx_next = get_next_nonempty_line(lines, i) 
            # get number of whitespaces at line beginning of next nonempty line
            ws_beginning = re.match("^\ +", lines[idx_next])
            num_whitesp_next = len(ws_beginning.group()) if ws_beginning else 0
             
            # if the line is indented, also indent current line 
            # TODO: make this more efficient by indenting all lines between
            #       current line and next non-empty line, then skipping
            #       in-between lines in next loop iteration
            if num_whitesp_next>0:
                lines[i]=" "*num_whitesp_next + "\n"
    
    with open(filename, "w") as f:
        f.writelines(lines)

filename = vim.eval("a:filename") 
indent_file(filename)
EOF
    " refresh current file
    execute "edit! " . a:filename 
endfun

nnoremap <silent> <Plug>IndentCurrentFile :<C-U> call <SID>IndentEmptyLines(expand('%:p'))<CR>

if !hasmapto('<Plug>IndentCurrentFile')
  map <unique> <Leader>ind <Plug>IndentCurrentFile
endif
