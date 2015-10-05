call plug#begin('~/.vim/plugged')

Plug 'Shougo/neocomplete.vim'
" On-demand loading
Plug 'scrooloose/nerdtree'

" Plugin bundles
Plug 'tpope/vim-fugitive' " git addon
Plug 'airblade/vim-gitgutter' " git gutter +/- signs to the left of the file
Plug 'scrooloose/syntastic' " syntax highlighting
Plug 'kien/ctrlp.vim' " buffer search
Plug 'bling/vim-airline' " a smooth status/tabline for vim

" Language bundles
Plug 'mattn/emmet-vim' " HTML
Plug 'godlygeek/tabular' " table arrangment
Plug 'tpope/vim-markdown' " markdown

" Color scheme
Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized' " good solarized background 

" All of your Plugins must be added before the following line
" Add plugins to &runtimepath
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" For neocompletion to be able at start
let g:neocomplete#enable_at_startup = 1

" Use different colorschemes dependant on filetype
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" good colorschemes
" jellybeans
autocmd BufEnter * colorscheme 256-grayvim
autocmd BufEnter *.html colorscheme 256-jungle

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

" Open up NerdTree with Ctrl + N
map <C-n> :NERDTreeToggle<CR>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
