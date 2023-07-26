set nocompatible " Required by Vundle
filetype off     " Required by Vundle

" Set the runtime path to include Vundle and load all the plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  " Let Vundle manage Vundle
  Plugin 'gmarik/Vundle.vim'

  " Solarized theme
  "Plugin 'altercation/vim-colors-solarized'

  " Nord theme
  Plugin 'arcticicestudio/nord-vim'
  let g:nord_cursor_line_number_background = 1
  " use a uniform style for active and inactive status lines
  let g:nord_uniform_status_lines = 1
  " highlight the background of separators, making them appear more bold
  let g:nord_bold_vertical_split_line = 1

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
  Plugin 'itchyny/lightline.vim'
  let g:lightline = {
      \ 'colorscheme': 'nord',
      \  }
  set laststatus=2
  "Plugin 'vim-airline/vim-airline'
  "Plugin 'vim-airline/vim-airline-themes'

  " Integrate the statusline with the tmux status
  "Plugin 'edkolev/tmuxline.vim'
  "let g:tmuxline_powerline_separators = 0

  " Integrate the statusline with the shell prompt
  "Plugin 'edkolev/promptline.vim'
  "let g:promptline_powerline_symbols = 0

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

  " Syntax checking / linting
  Plugin 'dense-analysis/ale'
  " Shorten error/warning flags
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  " Tell me which linter the error/warning comes from
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  " Customise error and warning symbols
  let g:ale_sign_error = '✘✘'
  let g:ale_sign_warning = '⚠⚠'

  " Toggle signcolumn. Works on vim>=8.1 or NeoVim
  nnoremap <Leader>s :call ToggleSignColumn()<CR>
  function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
      set signcolumn=no
      let b:signcolumn_on=0
    else
      set signcolumn=yes
      let b:signcolumn_on=1
    endif
  endfunction

  " Enable/disable open and loc list at the bottom of vim 
  let g:ale_open_list = 0
  let g:ale_loclist = 0
  " Loc List open/close
  "map <leader>e :lopen<CR>
  "map <leader>w :lclose<CR>

  " Toggle ALE loc list
  noremap <Leader>l :call LocListToggle()<CR>
  function! LocListToggle()
    if exists("g:loclist_win")
      lclose
      unlet g:loclist_win
    else
      lopen 10
      let g:loclist_win = bufnr("$")
    endif
  endfunction

  " Toggle ALE quick list
  noremap <Leader>q :call QFixToggle()<CR>
  function! QFixToggle()
    if exists("g:qfix_win")
      cclose
      unlet g:qfix_win
    else
      copen 10
      let g:qfix_win = bufnr("$")
    endif
  endfunction

  " Use leader-j/k to move between errors
  nmap <silent> <leader>k <Plug>(ale_previous_wrap)
  nmap <silent> <leader>j <Plug>(ale_next_wrap)
  " Enable integration with airline.
  let g:airline#extensions#ale#enabled = 1
  " A pox on whitespace!
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \}

  " NERDTree
  Plugin 'scrooloose/nerdtree'
  " Open NERDTree using leader-n (\-n)
  map <leader>n :NERDTreeToggle<CR>
  " Open when no files were specified on vim launch
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  " Tag management, courtesy of TagBar and gutentags
  Plugin 'majutsushi/tagbar'
  " Open TagBar using leader-t (\-t)
  map <leader>t :TagbarToggle<CR>
  Plugin 'ludovicchabant/vim-gutentags'

  " Framework-specific magics
  Plugin 'tweekmonster/django-plus.vim'

  " Support for Golang
  Plugin 'fatih/vim-go'

  " Snippet magic
  Plugin 'SirVer/ultisnips'
  Plugin 'honza/vim-snippets'
  " Trigger configuration. Do not use <tab> if you use
  " https://github.com/Valloric/YouCompleteMe.
  let g:UltiSnipsExpandTrigger       = "<c-tab>"
  let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
  let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
  let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file
  " Use :UltiSnipsEdit to split your window to edit the snippets side-by-side.
  let g:UltiSnipsEditSplit = "vertical"
  " Load snippets from...
  let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
  let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"

  " See http://hashivim.github.io/ for syntax highlighting for Hashicorp products
  Plugin 'hashivim/vim-terraform'
call vundle#end()
filetype plugin indent on

" Trust vim modelines in the files we edit
set modeline

" Line numbers relative to the current position
set number
set relativenumber
" Toggle line numbering
nnoremap <Leader>n :set number!<CR>:set relativenumber!<CR>

" Toggle paste mode
nnoremap <Leader>p :set paste!<CR>

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

" Solarized/Node colorschemes, rely on Terminal.app/iTerm2 also having the
" scheme loaded
set background=dark
colorscheme nord
"colorscheme solarized

" If the terminal does not have the scheme loaded, try uncommenting the
" following 3 lines instead of using colorscheme:
"set term=xterm-256color
"set t_Co=256
"let g:solarized_termcolors=256

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

" Golang
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1

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

" Tabs at the beginning of a line are bad mmkay.
" Python: yes
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
