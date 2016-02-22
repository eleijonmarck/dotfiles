﻿" plugin Setup
call plug#begin('~/.vim/plugged')

" Plugin tpope, making my life easier 
Plug 'tpope/vim-fugitive' " git addon, Gadd, Gcommit, Gdiff
Plug 'tpope/vim-markdown' " markdown
Plug 'tpope/vim-dispatch' " test asynchroncly
Plug 'tpope/vim-surround' " surronds the ',\" and {. :help surround
Plug 'tpope/vim-commentary' " comments with <gcc> , or <V-gc> for visual mode
Plug 'tpope/vim-repeat' " makes the . command repearable
Plug 'airblade/vim-gitgutter' " git gutter +/- signs to the left of the file

" Syntaxing and completion
Plug 'benekastah/neomake' " syntax checking
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'easymotion/vim-easymotion' "navgiation in file, via ,+,
Plug 'honza/vim-snippets' " snippet tool
" Plug 'ervandew/supertab' " so all completion happens with tab

"""""""""""""""""""""""""""""""""

" File status plugins
Plug 'scrooloose/nerdtree' " self explainatory
Plug 'kien/ctrlp.vim' " fuzzysearch of filenames
Plug 'bling/vim-airline' " a smooth status/tabline for vim
Plug 'rking/ag.vim' " super fast text search within files, :Ag {options}
Plug 'christoomey/vim-tmux-navigator' " tmux, vim windows with <Ctrl-h,j,k,l>
Plug 'lervag/vimtex' " tex
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " :FZF
Plug 'junegunn/fzf.vim'


"""""""""""""""""" 

" Language bundles
Plug 'mattn/emmet-vim' " HTML
Plug 'godlygeek/tabular' " table arrangment

"""""""""""""""""" 

" Go - code
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go', { 'for': 'go' }

" Javascript
Plug 'moll/vim-node', {'for': 'javascript'}
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'ahayman/vim-nodejs-complete', {'for': 'javascript'}
Plug 'ternjs/tern_for_vim', {'for': 'javascript', 'do': 'npm install'}

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'

" Color scheme
Plug 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
" Add plugins to &runtimepath
call plug#end()

" Settings ----------------------------------------------------------------------------------

" GENERAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

syntax on
set encoding=utf-8 termencoding=utf-8
set backspace=indent,eol,start
set relativenumber number
set expandtab
set shiftwidth=4 tabstop=4 textwidth=74

" no fucking backupfiles
set nowritebackup noswapfile nobackup
set clipboard=unnamed
set ignorecase smartcase
set splitright
" always show the status line
set laststatus=2

" indents
set autoindent
set smartindent

set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells

" Search
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

" Hide the mouse pointer while typing
set mouse=a

" set folding enabled with za,zM,zR
set foldmethod=indent

set splitbelow    " spawn horizontal splits below instead of above"
set splitright    " spawn vertical splits to the right instead of left"

"" Use different colorschemes dependant on filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" good colorschemes


" Solarized theme
set background=dark
colorscheme solarized
"colorscheme wombat256

" Plugin specific setup""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" FZF
set rtp+=~/.fzf
" nnoremap <leader>t :call fzf#run({'sink': 'e', 'window': 'enew'})<CR>
nnoremap <C-p> :call fzf#run({'sink': 'e', 'window': 'enew'})<CR>

" For neocompletion to be able at start
let g:neocomplete#enable_at_startup = 1

" Open up NerdTree in directory if nothing is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"" Powerline fonts and enablers
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled=1
"
" Text and latex specific settings
au FileType text,tex,markdown setlocal wrap linebreak nolist spell spelllang=en_us

" YouCompleteMe
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_filetype_blacklist = {
      \ 'tex' : 1,
      \ 'markdown' : 1,
      \ 'text' : 1
      \}

" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

" easy esc
:imap jj <ESC>
:imap jk <Esc>
:imap kj <Esc>


" Vim-ruby
autocmd FileType ruby,eruby compiler ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" Neomake syntax checking
autocmd! BufWritePost * Neomake

" NerdTree
" Open up NerdTree with Ctrl + N
map <C-n> :NERDTreeToggle<CR>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"Better window navigation with ctrl-w-hjkl
:tnoremap <C-w>h <C-\><C-n><C-w>h
:tnoremap <C-w>j <C-\><C-n><C-w>j
:tnoremap <C-w>k <C-\><C-n><C-w>k
:tnoremap <C-w>l <C-\><C-n><C-w>l
:nnoremap <C-w>h <C-w>h
:nnoremap <C-w>j <C-w>j
:nnoremap <C-w>k <C-w>k
:nnoremap <C-w>l <C-w>l
