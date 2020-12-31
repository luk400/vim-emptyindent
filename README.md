# vim-emptyindent

Indents empty lines (i.e. lines with only a line break) in file to match indentation of next non-empty lines.

This tool was created because of a regular annoyance I experienced when working with python scripts in an interactive manner where I execute and interact with parts of the code analagously to when using e.g. jupyter-notebook. 

I regularly work with vim and an open terminal running python in a split window mode, and send lines from the opened file to the terminal. The plugin I use for this is [vim-sendtowindow](https://github.com/karoliskoncevicius/vim-sendtowindow). 
Often however, there are empty lines without indentation in the files I work with, which causes problems if there's e.g. such an empty line in a function definition, since it signals the end of the function when I send such a line to the python buffer. 
This tool looks for the next non-empty line after an empty line and matches its indentation.


## Getting Started

### Dependencies

* vim compiled with python version >= 3.6

### Installation

With your plugin manager of choice. E.g.:

```
Plug 'luk400/vim-emptyindent' 
```

Or copy the contents of the plugin folder to your ./vim/plugin directory.

### Usage

By default, the mapping `<Leader>ind` is used to indent the currently opened file.
To define your own mapping, e.g. to use ',id' to indent the current file, simply define
```
let g:indentempty_use_defaults = 0
```
in your .vimrc before the Plugin is loaded and set the desired mapping using
```
nmap ,id <Plug>IndentCurrentFile
```
