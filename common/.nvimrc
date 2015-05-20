set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'
" Plugin dependencies

" Plugin bundles
Plugin 'fatih/vim-go'
Plugin 'kien/ctrlp.vim'

" Language bundles
Plugin 'tpope/vim-markdown'
Plugin 'vim-ruby/vim-ruby'
Plugin 'itchyny/lightline.vim'

" Color scheme
Plugin 'nanotech/jellybeans.vim'
Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()
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
