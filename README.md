# vim-emptyindent

Indents empty lines (i.e. lines with only a line break) in file to match indentation of corresponding next non-empty lines.

This tool was created because of a regular annoyance I experienced when working with python scripts in an interactive manner where I execute and interact with parts of the code analagously to when using e.g. jupyter-notebook. 

I regularly work with vim and an open terminal running python in a split window mode, and send lines from the opened file to the terminal. The plugin I use for this is [vim-sendtowindow](https://github.com/karoliskoncevicius/vim-sendtowindow). 
Often however, there are empty lines without indentation in the files I work with, which causes problems if there's e.g. such an empty line in a function definition, since it signals the end of the function when I send such a line to the python buffer. 
This tool solves this problem by looking for the next non-empty line after each empty line in the file and adjusting the indentation to match that of the respective following non-empty line. 

 ![Problem Example 1](https://github.com/luk400/vim-emptyindent/blob/media/problem1.gif?raw=true)
 ![Problem Example 2](https://github.com/luk400/vim-emptyindent/blob/media/problem2.gif?raw=true)
 ![Solution Example 1](../media/solution1.gif?raw=true)
 ![Solution Example 2](../media/solution2.gif?raw=true)


## Getting Started

### Requirements

* vim compiled with python3

### Installation

With your plugin manager of choice, e.g.:

```
Plug 'luk400/vim-emptyindent' 
```

### Usage

By default, the mapping `<Leader>in` is used to indent the currently opened file.
To define your own mapping, simply set
```
let g:indentempty_use_defaults = 0
```
in your .vimrc before the Plugin is loaded and set the desired mapping by substituting `<Leader>in` in the following:
```
nmap <Leader>in <Plug>IndentCurrentFile
```
&nbsp;

If you later want to remove the whitespaces in the indented empty lines again, you can do this by default using `<Leader>rin`, or set your own mapping in your .vimrc by defining
```
nnoremap <Leader>rin :%s/^\s\+$//g<cr><c-o>
```
where you substitute your own mapping for `<Leader>rin`.
