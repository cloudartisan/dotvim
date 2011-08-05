call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set hidden
set number
set vb t_vb=

" Disable backups
set nobackup

" Show the cursor position
set ruler

" Enable syntax highlighting
syntax on
set background=light

" Enable automatic wrap, use par to format paragraphs, remove superfluous
" lines
set formatoptions+=t
set textwidth=79
set formatprg=par\ -w79re

" Enable automatic indentation
set autoindent

" Default indentation handling.
"
" Leave tab characters unmolested, but display only 2 characters wide
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" Ruby: 2 spaces
" ERB: 2 spaces
" YAML: 2 spaces
" Clojure: 2 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
" Makefile: no tab expansion
au BufRead,BufNewFile *.py,*.pyw set sw=4 ts=4 sts=4 expandtab
au BufRead,BufNewFile *.rb,*.erb set sw=2 ts=2 sts=2 expandtab
au BufRead,BufNewFile *.yml set sw=2 ts=2 sts=2 expandtab
au BufRead,BufNewFile *.clj set sw=2 ts=2 sts=2 expandtab
fu Select_c_style()
    if search('^\t', 'n', 150)
        set sw=8 ts=8 noexpandtab
    el 
        set sw=4 ts=4 expandtab
    en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Django template tags
au Filetype htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>
" Django template variables
au Filetype htmldjango inoremap <buffer> <c-v> {{<space><space>}}<left><left><left>

" Use the below highlight group when displaying bad whitespace
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Flag trailing whitespace as bad.
" Python: yes
" Ruby: yes
" C: yes
au BufRead,BufNewFile *.py,*.pyw,*.rb,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79 
" Ruby: 79
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.rb,*.c,*.h set textwidth=79

" Highlight characters that go over the textwidth limit
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%79v.*'

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" Ruby: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" Ruby: yes
" C: yes
au BufNewFile *.py,*.pyw,*.rb,*.c,*.h set fileformat=unix

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Automatically indent based on file type
filetype indent on

" Folding based on indentation: ``set foldmethod=indent``

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``
