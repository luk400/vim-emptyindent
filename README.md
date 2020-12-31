# vim-emptyindent

Indents empty lines (i.e. lines with only a line break) in file to match indentation of next non-empty lines.

This tool was created because of a regular annoyance I experienced when working with python scripts in interactive manner where I wished to execute and interact with parts of the code as is possible for example in jupyter-notebook. 
I regularly work with vim and an open terminal running python in a split window mode, and send lines from the opened file to the terminal. The plugin I use for this is [vim-sendtowindow](https://github.com/karoliskoncevicius/vim-sendtowindow). 
Often however, there are empty lines without indentation in the files I work with, which causes problems if there's e.g. such an empty line in a function definition, since it signals the end of the function when I send such a line to the python pane. 

This tool looks for the next non-empty lines after an empty line and matches its indentation.


## Getting Started

### Dependencies

* vim compiled with python version >= 3.6
* installed python modules: re, vim

### Installation

With your plugin manager of choice. E.g.:

Plug 'luk400/vim-emptyindent'

Or copy the contents of the plugin folder to your ./vim/plugin directory.

### Usage

By default, the mapping `<Leader>ind` is used to indent the currently opened file:
To define your own mapping, e.g. to use ',id' to indent the current file, simply use:
```
nnoremap ,id <Plug>IndentCurrentFile
```

To indent a file other than the current one, use
```
:call IndentEmptyLines(/path/to/file)
```
