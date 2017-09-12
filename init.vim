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
Plug 'benekastah/neomake' " syntax checking
Plug 'easymotion/vim-easymotion' "navgiation in file, via ,+,
Plug 'pearofducks/ansible-vim' " ansible syntax

"""""""""""""""""""""""""""""""""

" File status plugins
Plug 'scrooloose/nerdtree' " self explainatory
Plug 'bling/vim-airline' " a smooth status/tabline for vim
Plug 'christoomey/vim-tmux-navigator' " tmux, vim windows with <Ctrl-h,j,k,l>
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " :FZF
Plug 'junegunn/fzf.vim'


" Own personal vimwiki
Plug 'vimwiki/vimwiki' " open it with ,ww . But be sure to sync it to github
"""""""""""""""""" 

" Language bundles

"""""""""""""""""" 

" Go - code
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go', { 'for': 'go' }

" HTML
Plug 'mattn/emmet-vim'

" Javascript
Plug 'othree/yajs.vim', {'for': 'javascript'} " syntax highlighting for ES6

" Color scheme
Plug 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
" Add plugins to &runtimepath
call plug#end()


" GENERAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

syntax on
set encoding=utf-8 termencoding=utf-8
set backspace=indent,eol,start
set relativenumber number
set expandtab
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
set splitbelow splitright    " spawn vertical splits to the right instead of left"

" python specific
let python_highlight_all=1
" python PEP8 standard
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix

"" Use different colorschemes dependant on filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" good colorschemes

" Solarized theme
set background=dark
colorscheme wombat256

" Plugin specific setup""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" FZF
set rtp+=~/.fzf
nnoremap <C-p> :FZF! <CR>

" For neocompletion to be able at start
let g:neocomplete#enable_at_startup = 1

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

" Tab between buffers
noremap <tab> <c-w>w
noremap <S-tab> <c-w>W

" Switch between last two buffers
nnoremap <leader><leader> <C-^>

" To map <Esc> to exit terminal-mode:
:tnoremap <Esc> <C-\><C-n>

" <leader>,y makes the python formatting acording to yapf
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>

" Neomake syntax checking
autocmd! BufWritePost * Neomake

" NerdTree
" Open up NerdTree with Ctrl + N
map <C-n> :NERDTreeToggle<CR>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
