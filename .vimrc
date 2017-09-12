" plugin Setup
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
Plug 'easymotion/vim-easymotion' "navgiation in file, via ,+,

"""""""""""""""""""""""""""""""""

" File status plugins
Plug 'scrooloose/nerdtree' " self explainatory
Plug 'bling/vim-airline' " a smooth status/tabline for vim
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
Plug 'othree/yajs.vim', {'for': 'javascript'} " syntax highlighting for ES6

Plug '
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
set clipboard=unnamed

" no backupfiles
set nowritebackup noswapfile nobackup

" case sensitivity
set ignorecase smartcase

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

" splits
set splitbelow    " spawn horizontal splits below instead of above"
set splitright    " spawn vertical splits to the right instead of left"

"" Use different colorschemes dependant on filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" good colorschemes

" Solarized theme
set background=dark
colorscheme wombat256

" Plugin specific setup""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" some plugins use python 
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
" FZF
set rtp+=~/.fzf
"nnoremap <C-p> :call fzf#run({'sink': 'e', 'window': 'enew'})<CR>
nnoremap <C-p> :FZF! <CR>

"" Powerline fonts and enablers
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled=1
"
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

" easy esc
:imap jj <ESC>
:imap jk <Esc>
:imap kj <Esc>

" <leader>,y makes the python formatting acording to yapf
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>

" NerdTree
" Open up NerdTree with Ctrl + N
map <C-n> :NERDTreeToggle<CR>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
