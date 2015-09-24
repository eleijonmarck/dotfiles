call plug#begin('~/.vim/plugged')

Plug 'Shougo/neocomplete.vim'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Code to execute when the plugin is loaded on demand
Plug 'Valloric/YouCompleteMe'
" autocmd! User YouCompleteMe call youcompleteme#Enable()
"
" Plugin bundles
Plug 'kien/ctrlp.vim'

" Language bundles
Plug 'fatih/vim-go' 
Plug 'tpope/vim-markdown'
Plug 'itchyny/lightline.vim'

" Color scheme
Plug 'nanotech/jellybeans.vim'
Plug 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
" Add plugins to &runtimepath
call plug#end()
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
colorscheme 256-grayvim

" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
" easy esc
inoremap jj <ESC>
