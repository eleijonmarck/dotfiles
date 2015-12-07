call plug#begin('~/.vim/plugged')

" Plugin bundles
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
Plug 'easymotion/vim-easymotion' "navgiation in file
Plug 'honza/vim-snippets' " snippet tool
Plug 'ervandew/supertab' " so all completion happens with tab

"""""""""""""""""""""""""""""""""

" File status plugins
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim' " fuzzysearch of filenames
Plug 'bling/vim-airline' " a smooth status/tabline for vim
Plug 'rking/ag.vim' " super fast text search within files, :Ag {options}
Plug 'christoomey/vim-tmux-navigator' " tmux, vim windows with <Ctrl-h,j,k,l>
Plug 'lervag/vimtex' " tex


"""""""""""""""""" 

" Language bundles
Plug 'mattn/emmet-vim' " HTML
Plug 'godlygeek/tabular' " table arrangment
Plug 'OmniSharp/omnisharp-vim' " C#

"""""""""""""""""" 

" Go - code
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go', { 'for': 'go' }

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
set relativenumber 
set number
set expandtab
set shiftwidth=2

" no fucking backupfiles
set nowritebackup
set noswapfile
set nobackup
set clipboard=unnamed
set ignorecase
set smartcase
set noshowmode
set splitright
set laststatus=2

" Hide the mouse pointer while typing
set mouse=a
set mousehide

" set folding enabled with za,zM,zR
set foldmethod=indent

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

" Powerline fonts and enablers
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='luna'
