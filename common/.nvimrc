call plug#begin('~/.vim/plugged')

" Plugin bundles
Plug 'scrooloose/nerdtree' { 'on' : 'NERDTreeToggle' }
Plug 'tpope/vim-fugitive' " git addon, Gadd, Gcommit, Gdiff
Plug 'tpope/vim-sensible' " a bunch of set commands that should be default
Plug 'airblade/vim-gitgutter' " git gutter +/- signs to the left of the file
Plug 'benekastah/neomake' " syntax checking
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" File status plugins
Plug 'kien/ctrlp.vim' " fuzzysearch of filenames
Plug 'bling/vim-airline' " a smooth status/tabline for vim
Plug 'rking/ag.vim' " super fast text search within files, :Ag {options}

"""""""""""""""""" 

" Language bundles
Plug 'mattn/emmet-vim' " HTML
Plug 'godlygeek/tabular' " table arrangment
Plug 'tpope/vim-markdown' " markdown

"""""""""""""""""" 

" Go - code
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go', { 'for' : 'go' }


"""""""""""""""""" 

" Color scheme
Plug 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
" Add plugins to &runtimepath
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" For neocompletion to be able at start
let g:neocomplete#enable_at_startup = 1

" Use different colorschemes dependant on filetype
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" good colorschemes
" jellybeans, wombat256mod
autocmd BufEnter * colorscheme wombat256mod

" GENERAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

set hidden
syntax on
set encoding=utf-8 termencoding=utf-8
set tabstop=2
set backspace=indent,eol,start
set nowrap
set number
set expandtab
set shiftwidth=2
set nowritebackup
set noswapfile
set nobackup
set clipboard=unnamed,unnamedplus
set ignorecase
set smartcase
set noshowmode
set splitright
set laststatus=2

" Hide the mouse pointer while typing
set mouse=a
set mousehide

" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
" easy esc
inoremap jj <ESC>

" Neomake syntax checking
autocmd! BufWritePost * Neomake

" NerdTree
" Open up NerdTree in directory if nothing is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open up NerdTree with Ctrl + N
map <C-n> :NERDTreeToggle<CR>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
