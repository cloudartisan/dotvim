" Define leader key explicitly to avoid conflicts
let mapleader = "\\"

call plug#begin()

  "
  " CORE PLUGINS & SENSIBLE DEFAULTS
  "
  " Sensible defaults that most people can agree on
  Plug 'tpope/vim-sensible'

  "
  " APPEARANCE
  "
  " Nord theme - Arctic, north-bluish clean and elegant theme
  Plug 'arcticicestudio/nord-vim'
  let g:nord_cursor_line_number_background = 1
  let g:nord_uniform_status_lines = 1         " uniform style for active/inactive status lines
  let g:nord_bold_vertical_split_line = 1     " bold separators for better visibility

  " Improved statusline with theme support
  Plug 'itchyny/lightline.vim'
  let g:lightline = {
      \ 'colorscheme': 'nord',
      \  }
  set laststatus=2
  
  "
  " NAVIGATION & FILE MANAGEMENT
  "
  " File explorer sidebar
  Plug 'scrooloose/nerdtree'                   " File tree explorer
  nnoremap <leader><tab> :NERDTreeToggle<CR>   " Toggle with \<tab>
  " Auto-open NERDTree when vim starts with no files
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  " Seamless navigation between tmux panes and vim splits
  Plug 'christoomey/vim-tmux-navigator'        " Navigate splits with Ctrl+hjkl

  "
  " EDITING ENHANCEMENTS
  "
  " Code manipulation tools
  Plug 'tomtom/tcomment_vim'                   " Smart commenting (gc to toggle comments)
  Plug 'christoomey/vim-sort-motion'           " Sorting motions (gs + motion)
  Plug 'vim-scripts/ReplaceWithRegister'       " Replace text with register (gr + motion)
  Plug 'godlygeek/tabular'                     " Text alignment (:Tab /pattern)

  "
  " CODE INTELLIGENCE
  " 
  " Completion engine
  Plug 'Valloric/YouCompleteMe'                " Intelligent code completion
  let g:ycm_collect_identifiers_from_tags_files = 1        " Use tags for completion
  let g:ycm_use_ultisnips_completer = 0                    " Disable UltiSnips integration
  let g:ycm_seed_identifiers_with_syntax = 1               " Use syntax keywords
  let g:ycm_complete_in_comments = 1                       " Complete in comments
  let g:ycm_complete_in_strings = 1                        " Complete in strings
  let g:ycm_autoclose_preview_window_after_insertion = 1   " Auto-close preview
  let g:ycm_autoclose_preview_window_after_completion = 1  " Auto-close preview

  " Linting and syntax checking
  Plug 'dense-analysis/ale'                    " Asynchronous Lint Engine
  let g:ale_echo_msg_error_str = 'E'                       " Error indicator
  let g:ale_echo_msg_warning_str = 'W'                     " Warning indicator
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]' " Message format
  let g:ale_sign_error = '✘✘'                              " Error symbol
  let g:ale_sign_warning = '⚠⚠'                            " Warning symbol
  let g:ale_open_list = 0                                  " Don't auto-open error list
  let g:ale_loclist = 0                                    " Don't auto-open location list
  " Auto-fix whitespace issues
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace']
  \}
  let g:airline#extensions#ale#enabled = 1                 " Enable airline integration
  
  " Error navigation keymaps
  nmap <silent> <leader>k <Plug>(ale_previous_wrap)        " Go to previous error
  nmap <silent> <leader>j <Plug>(ale_next_wrap)            " Go to next error
  
  " Toggle functions for UI elements
  nnoremap <Leader>s :call ToggleSignColumn()<CR>          " Toggle sign column
  function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
      set signcolumn=no
      let b:signcolumn_on=0
    else
      set signcolumn=yes
      let b:signcolumn_on=1
    endif
  endfunction

  noremap <Leader>l :call LocListToggle()<CR>              " Toggle location list
  function! LocListToggle()
    if exists("g:loclist_win")
      lclose
      unlet g:loclist_win
    else
      lopen 10
      let g:loclist_win = bufnr("$")
    endif
  endfunction

  noremap <Leader>q :call QFixToggle()<CR>                 " Toggle quickfix list
  function! QFixToggle()
    if exists("g:qfix_win")
      cclose
      unlet g:qfix_win
    else
      copen 10
      let g:qfix_win = bufnr("$")
    endif
  endfunction

  " Tag management for code navigation
  Plug 'majutsushi/tagbar'                     " Show tags in sidebar
  map <leader>t :TagbarToggle<CR>                          " Toggle tagbar
  Plug 'ludovicchabant/vim-gutentags'          " Automatic tag management

  " Code snippets
  Plug 'SirVer/ultisnips'                      " Snippet engine
  Plug 'honza/vim-snippets'                    " Snippet collection
  let g:UltiSnipsExpandTrigger       = "<c-tab>"           " Expand snippet
  let g:UltiSnipsJumpForwardTrigger  = "<c-j>"             " Jump forward in snippet
  let g:UltiSnipsJumpBackwardTrigger = "<c-p>"             " Jump backward in snippet
  let g:UltiSnipsListSnippets        = "<c-k>"             " List available snippets
  let g:UltiSnipsEditSplit = "vertical"                    " Split vertically when editing
  let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
  let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"

  "
  " VERSION CONTROL
  "
  " Git integration
  Plug 'tpope/vim-fugitive'                    " Git commands within vim
  Plug 'tpope/vim-git'                         " Git syntax highlighting
  Plug 'vim-scripts/Gist.vim'                  " GitHub gist integration

  "
  " LANGUAGE SUPPORT
  "
  " Framework support
  Plug 'tweekmonster/django-plus.vim'          " Django framework support
  
  " Language-specific plugins
  Plug 'fatih/vim-go'                          " Go language support
  Plug 'hashivim/vim-terraform'                " Terraform configuration support

call plug#end()

filetype plugin indent on

"
" KEY MAPPINGS REFERENCE
" ======================
" Leader key is set to backslash (\)
"
" File Navigation:
"   \<tab>      - Toggle NERDTree file browser
"   Ctrl+h/j/k/l - Navigate between splits (left/down/up/right)
"
" Toggle UI Elements:
"   \n          - Toggle line numbers
"   \p          - Toggle paste mode
"   \s          - Toggle sign column (error/warning gutter)
"   \l          - Toggle location list
"   \q          - Toggle quickfix list
"   \t          - Toggle tag browser (Tagbar)
"
" Code & Errors:
"   \j          - Go to next error/warning
"   \k          - Go to previous error/warning
"   gc{motion}  - Toggle comment (e.g., gcc for current line, gcap for paragraph)
"   gs{motion}  - Sort text (e.g., gsap to sort a paragraph)
"   gr{motion}  - Replace with register (e.g., griw to replace word)
"
" Snippets:
"   Ctrl+Tab    - Expand snippet
"   Ctrl+j      - Jump forward in snippet
"   Ctrl+p      - Jump backward in snippet
"   Ctrl+k      - List available snippets
"

" Trust vim modelines in the files we edit
set modeline

" Line numbers relative to the current position
set number
set relativenumber
" Toggle line numbering (with \n)
nnoremap <Leader>n :set number!<CR>:set relativenumber!<CR>

" Toggle paste mode (with \p)
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
silent! colorscheme nord
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

"
" EDITOR CONFIGURATION
" ====================

" Default indentation handling
set expandtab             " convert tab characters to spaces
set shiftwidth=2          " shift by 2 spaces
set tabstop=2             " tabs are 2 spaces
set softtabstop=2         " backspace removes 2 spaces at once
set backspace=indent,eol  " sensible backspacing
set autoindent            " keep indentation on new line
set nosmartindent         " don't try to be too smart about indenting

" Terminal and window title configuration
set titlestring=vim\ %<%F%(\ %)%m%h%w%=%l/%L-%P
set titlelen=70
if &term == "screen" || &term == "tmux"
  set t_ts=k
  set t_fs=\
endif
if &term == "screen" || &term == "tmux" || &term == "xterm"
  set title
endif

" Documentation
if isdirectory("~/.vim/doc")
  helptags ~/.vim/doc
endif

"
" LANGUAGE-SPECIFIC SETTINGS
" ==========================
" Using FileType is better than BufRead/BufNewFile for most settings
" 
" Create augroup to avoid duplicate autocmds when sourcing vimrc again
augroup language_settings
  autocmd!

  " --- 2 SPACES ---
  " Web, config, and data file formats: 2 spaces, expand tabs
  autocmd FileType html,css,javascript,json,yaml,yml,ruby,eruby,markdown,clojure
        \ setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

  " --- 4 SPACES ---
  " Programming languages that commonly use 4 spaces
  autocmd FileType python,groovy,java
        \ setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab textwidth=79 fileformat=unix

  " --- SPECIAL CASES ---
  " Go uses tabs, not spaces
  autocmd FileType go 
        \ setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

  " Makefiles require tabs
  autocmd FileType make setlocal noexpandtab

  " C/C++ - use function to detect existing style or default to 4 spaces
  autocmd FileType c,cpp call Select_c_style()

  " Terraform/HCL - no text wrapping
  autocmd FileType terraform
        \ setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab textwidth=0 nowrap

  " Jenkinsfiles are Groovy
  autocmd BufRead,BufNewFile Jenkinsfile* setfiletype groovy

  " --- CODE QUALITY HIGHLIGHTS ---
  " Mark bad whitespace
  highlight BadWhitespace ctermbg=red guibg=red
  
  " Highlight tabs at beginning of Python files (against PEP8)
  autocmd FileType python match BadWhitespace /^\t\+/
  
  " Highlight trailing whitespace in several languages
  autocmd FileType python,ruby,c,cpp match BadWhitespace /\s\+$/
  
  " Set text width for specific file types
  autocmd FileType python,ruby,c,cpp setlocal textwidth=79
  
  " Highlight overflowing text
  highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
  autocmd FileType python,ruby,c,cpp match OverLength '\%79v.*'
  
  " Fix C comment formatting
  autocmd FileType c,cpp setlocal formatoptions-=c formatoptions-=o formatoptions-=r
  
  " Force UNIX line endings for new files
  autocmd BufNewFile *.py,*.rb,*.c,*.h setlocal fileformat=unix
augroup END

" Go syntax highlighting settings
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1

" C indent detection function
function! Select_c_style()
    if search('^\t', 'n', 150)
        setlocal sw=8 ts=8 noexpandtab
    else
        setlocal sw=4 ts=4 expandtab
    endif
endfunction

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
