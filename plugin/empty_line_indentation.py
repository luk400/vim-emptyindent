import re

def get_next_nonempty_line(lines, idx):
    """
    Starting from the given index, finds the next non-empty line (i.e. a line 
    containing more than just a line break) and returns its index in the given
    list of lines.
    
    Parameters
    ----------
    lines : list of str
        List containing the lines of the file.
    idx : int
        Index in list from which to start searching for next non-empty line.
    """

    # starting from given index, search for next nonempty-line
    lines_partial = lines[(idx+1):]
    for i, line in enumerate(lines_partial):
        if re.match(".*\S+.*", line): # if line contains non-whitespace characters
            break

    return idx + i + 1

def indent_file(filename):
    """
    Given a filename, indents empty-lines to match indentation of next
    non-empty line.
        
    Parameters
    ----------
    filename : str
        Filename of the file for which to indent empty-lines.
    """

    with open(filename,"r") as f:
        lines=f.read().splitlines()
    
    # find empty lines and indent them if next non-empty 
    # line is indented
    i = 0
    while i < len(lines):
        line = lines[i]
        # check if current line contains just a line break, and make sure
        # we're not in the last line of the file
        if re.match("^$", line) and i < (len(lines) - 1): 
            # get index of next non-empy line
            idx_next = get_next_nonempty_line(lines, i) 
            # get number of whitespaces/tabs at beginning of next nonempty line
            next_indent = re.match("^\s+", lines[idx_next])
             
            # if the next non-empty line is indented, also indent current line
            # and all empty lines inbetween
            if next_indent:
                for j in range(i, idx_next):
                    lines[j] = next_indent.group()
                i = idx_next+1
            else:
                i += 1
        else:
            i += 1
    return lines
