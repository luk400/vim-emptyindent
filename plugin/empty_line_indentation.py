import re

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
