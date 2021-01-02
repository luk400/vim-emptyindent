import re

def get_next_nonempty_line(lines, idx):
    """
    Starting after the given index, finds the next non-empty line (i.e. a line 
    containing more than just a line break) and returns its index in the given
    list of lines.
    
    Parameters
    ----------
    lines : list of str
        List containing the lines of the file.
    idx : int
        Index in list after which to start searching for next non-empty line.
    """

    # starting from line after the given index, search for next non-empty-line
    lines_partial = lines[(idx + 1):]
    for i, line in enumerate(lines_partial):
        # if line contains non-whitespace characters, break
        if re.match(".*\S+.*", line): 
            break

    # return index of next non-empty line
    return idx + 1 + i

def indent_file(filename):
    """
    Given a filename, indents empty-lines to match indentation of corresponding 
    next non-empty lines.
        
    Parameters
    ----------
    filename : str
        Filename of the file for which to indent empty-lines.
    """

    with open(filename,"r") as f:
        lines=f.read().splitlines()
    
    i = 0
    while i < len(lines):
        line = lines[i]
        # check if current line is empty, and make sure we're not in the last 
        # line of the file
        if re.match("^$", line) and i < (len(lines) - 1): 
            # get index of next non-empty line
            idx_next = get_next_nonempty_line(lines, i) 
            # get indentation, i.e. number of spaces/tabs at beginning of next 
            # non-empty line
            next_indent = re.match("^\s+", lines[idx_next])
             
            # if the next non-empty line is indented, also indent current line
            # and all empty lines in-between
            if next_indent:
                for j in range(i, idx_next):
                    lines[j] = next_indent.group()
                i = idx_next + 1 # jump to line after next non-empty line
            else:
                i += 1
        else:
            i += 1

    return lines
