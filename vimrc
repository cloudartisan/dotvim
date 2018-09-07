set nocompatible " Required by Vundle
filetype off     " Required by Vundle

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Set the runtime path to include Vundle and load all the plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  " Let Vundle manage Vundle
  Plugin 'gmarik/Vundle.vim'

  " Adds code (un)commenting commands
  " e.g., :gcap will comment the current paragraph
  "       :gc5j will comment the current line and 5 lines below
  Plugin 'tomtom/tcomment_vim'
  
  " Adds sorting commands
  " e.g., :gsap will sort the current paragraph
  Plugin 'christoomey/vim-sort-motion'

  " Enables moving between vim splits and tmux splits seamlessly
  Plugin 'christoomey/vim-tmux-navigator'
  
  " Adds replace commands
  " e.g., :griw will replace the current word with the register
  Plugin 'vim-scripts/ReplaceWithRegister'

  " Text alignment
  Plugin 'godlygeek/tabular'

  " Git/Gist
  Plugin 'tpope/vim-fugitive'    " Handy git commands
  Plugin 'tpope/vim-git'         " Syntax, indent, and filetype
  Plugin 'vim-scripts/Gist.vim'  " Managing gists

  " Improve the statusline, always show it
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  set laststatus=2

  " Integrate the statusline with the tmux status
  Plugin 'edkolev/tmuxline.vim'
  let g:tmuxline_powerline_separators = 0

  " Integrate the statusline with the shell prompt
  Plugin 'edkolev/promptline.vim'
  let g:promptline_powerline_symbols = 0

  " Syntax checking
  Plugin 'scrooloose/syntastic'

  " Always open the location list if errors are detected and close
  " when there are no more errors. Limit the size of the location
  " list to no more than 5 lines. Check on open, but not on quit.
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_loc_list_height = 5
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

  " Filetype specific magics
  Plugin 'tpope/vim-markdown'
  Plugin 'tweekmonster/django-plus.vim'
  Plugin 'hashivim/vim-hashicorp-tools'
  Plugin 'rodjek/vim-puppet'

  " Some nice colours to have around
  Plugin 'altercation/vim-colors-solarized'

  " Code completion
  Plugin 'Valloric/YouCompleteMe'

  let g:ycm_collect_identifiers_from_tags_files = 1        " Let YCM read tags from Ctags file
  let g:ycm_use_ultisnips_completer = 1                    " Default 1, just ensure
  let g:ycm_seed_identifiers_with_syntax = 1               " Completion for programming language's keyword
  let g:ycm_complete_in_comments = 1                       " Completion in comments
  let g:ycm_complete_in_strings = 1                        " Completion in string

  " Closes the scratch/preview window once the completion/insertion is finished
  let g:ycm_autoclose_preview_window_after_insertion = 1
  let g:ycm_autoclose_preview_window_after_completion = 1

  " Snippet magic
  Plugin 'SirVer/ultisnips'
  Plugin 'honza/vim-snippets'

  " Trigger configuration. Do not use <tab> if you use
  " https://github.com/Valloric/YouCompleteMe.
  let g:UltiSnipsExpandTrigger       = "<c-j>"
  let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
  let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
  let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

  " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"
call vundle#end()
filetype plugin indent on

" Trust vim modelines in the files we edit
set modeline

" Line numbers relative to the current position
set number
set relativenumber

" Disable search annoyances
set noincsearch
set nohlsearch

" Disable backups
set nobackup

" Get rid of all bells
set noerrorbells
set visualbell
set vb t_vb=

" Interface tweaks
set ruler            " show me a ruler
set noshowmode       " don't show me that I'm in INSERT mode
set scrolloff=8      " 8 lines of context around the cursor at all times
set foldclose=       " disable automatic fold closing
set showcmd          " show the vi command in the ruler
set showmatch        " show me matching parentheses, braces, etc
set matchpairs+=<:>  " include < > when matching
set smartcase        " determine when I really want case-sensitive searching

" Enable syntax highlighting where possible
if has("syntax")
  syntax on
  let python_highlight_all=1
end

" Solarized colorscheme, relies on Terminal.app/iTerm2 also having the
" solarized scheme loaded; if not, uncomment following 3 lines
"set term=xterm-256color
"set t_Co=256
"let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" Use the system registry by default for the clipboard
if $TMUX == ''
  set clipboard+=unnamed
endif

" Allow Ctrl+PgUp/PgDn in tmux (Fn+Up/Dn in Mac OS/X)
set t_kN=[6;*~
set t_kP=[5;*~

" Enable automatic wrap, use par to format paragraphs, remove superfluous
" lines
set formatoptions+=t
set textwidth=79
set formatprg=par\ -w79re

" Default indentation handling
set expandtab             " convert my tab characters to spaces
set shiftwidth=2          " shift by 2 spaces
set tabstop=2             " tabs are 2 spaces
set softtabstop=2
set backspace=indent,eol  " sensible backspacing
set autoindent
set nosmartindent

" Set title string and push it to xterm/screen window title
set titlestring=vim\ %<%F%(\ %)%m%h%w%=%l/%L-%P
set titlelen=70
if &term == "screen" || &term == "tmux"
  set t_ts=k
  set t_fs=\
endif
if &term == "screen" || &term == "tmux" || &term == "xterm"
  set title
endif

" Support plugin documentation
if isdirectory("~/.vim/doc")
  helptags ~/.vim/doc
endif

" Python: 4 spaces (PEP8)
au BufRead,BufNewFile *.py,*.pyw
    \ set tabstop=4     |
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set textwidth=79  |
    \ set expandtab     |
    \ set autoindent    |
    \ set fileformat=unix

" Ruby: 2 spaces
" ERB: 2 spaces
au BufRead,BufNewFile *.rb,*.erb
    \ set tabstop=2     |
    \ set softtabstop=2 |
    \ set shiftwidth=2  |
    \ set expandtab     |
    \ set autoindent

" HTML: 2 spaces
" JS: 2 spaces
" CSS: 2 spaces
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2     |
    \ set softtabstop=2 |
    \ set shiftwidth=2  |
    \ set expandtab     |
    \ set autoindent

" YAML: 2 spaces
au BufRead,BufNewFile *.yml
    \ set tabstop=2     |
    \ set softtabstop=2 |
    \ set shiftwidth=2  |
    \ set expandtab     |
    \ set autoindent

" Markdown: 2 spaces
au BufRead,BufNewFile *.md
    \ set tabstop=2     |
    \ set softtabstop=2 |
    \ set shiftwidth=2  |
    \ set expandtab     |
    \ set autoindent

" Clojure: 2 spaces
au BufRead,BufNewFile *.clj
    \ set tabstop=2     |
    \ set softtabstop=2 |
    \ set shiftwidth=2  |
    \ set expandtab     |
    \ set autoindent

" C: tabs (pre-existing files) or 4 spaces (new files)
fu Select_c_style()
    if search('^\t', 'n', 150)
        set sw=8 ts=8 noexpandtab
    el
        set sw=4 ts=4 expandtab
    en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style()

" Makefile: no tab expansion
au BufRead,BufNewFile Makefile* set noexpandtab

" HCL: 2 spaces, no auto-wrap
au BufRead,BufNewFile *.tf
    \ set tabstop=2     |
    \ set softtabstop=2 |
    \ set shiftwidth=2  |
    \ set expandtab     |
    \ set autoindent    |
    \ set textwidth=0   |
    \ set nowrap

" Groovy:
au BufRead,BufNewFile *.groovy
    \ set tabstop=4     |
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set textwidth=79  |
    \ set expandtab     |
    \ set autoindent    |
    \ set fileformat=unix

" Jenkinsfiles: a Groovy-like syntax for Jenkins pipelines
au BufRead,BufNewFile Jenkinsfile* setf groovy

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

" Folding based on indentation
set foldmethod=marker

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Mappings to jump between window splits
" Ctrl-j move to the split below
" Ctrl-k move to the split above
" Ctrl-l move to the split to the right
" Ctrl-h move to the split to the left
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Mappings to jump me to the beginning of functions
nnoremap [[ ?{<CR>w99[{
nnoremap ][ /}<CR>b99]}
nnoremap ]] j0[[%/{<CR>
nnoremap [] k$][%?}<CR>
