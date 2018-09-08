" Vim-plug initalization

" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Active plugins
" You can disable or add new ones here:
call plug#begin('~/vim/plugged')

" Plugin tpope, making my life easier 
Plug 'tpope/vim-fugitive' " git addon, Gadd, Gcommit, Gdiff
Plug 'tpope/vim-markdown' " markdown
Plug 'tpope/vim-surround' " surronds the ',\" and {. :help surround
Plug 'tpope/vim-commentary' " comments with <gcc> , or <V-gc> for visual mode
Plug 'tpope/vim-repeat' " makes the . command repearable
Plug 'airblade/vim-gitgutter' " git gutter +/- signs to the left of the file

" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
Plug 'myusuf3/numbers.vim'

" File status plugins
" Nerdtree file/folder structure
Plug 'scrooloose/nerdtree' " 
" Airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Color scheme
Plug 'flazz/vim-colorschemes'
" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'
"""""""""""""""""""""""""""""""""

" Code handling
" Async autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'

" Indent text object
Plug 'michaeljsmith/vim-indent-object'

" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'

" Syntaxing and completion
Plug 'easymotion/vim-easymotion' "navgiation in file, via ,+,

" Search results counter
Plug 'vim-scripts/IndexedSearch'

" Linters
Plug 'neomake/neomake'
" TODO is it running on save? or when?
" TODO not detecting errors, just style, is it using pylint?
"""""""""""""""""" 

" Language bundles

"""""""""""""""""" 

" Python autocompletion
Plug 'zchee/deoplete-jedi', { 'for': 'python', 'do': ':UpdateRemotePlugins' }
" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" Automatically sort python imports
Plug 'fisadev/vim-isort'

" Go - code
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go', { 'for': 'go' }

" HTML
Plug 'mattn/emmet-vim'
" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" TODO is there a better option for neovim?

" Javascript
Plug 'othree/yajs.vim', {'for': 'javascript'} " syntax highlighting for ES6

" Better language packs
Plug 'sheerun/vim-polyglot'

" All of your Plugins must be added before the following line
" Add plugins to &runtimepath
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif


" python specific
let python_highlight_all=1
" python PEP8 standard
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=200 expandtab autoindent fileformat=unix

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" GENERAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash <Paste>
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

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

"" Use different colorschemes dependant on filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" good colorschemes

" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
	let &t_Co = 256
    colorscheme fisa
else
    colorscheme delek
endif

" Plugin specific setup""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" FZF
set rtp+=~/.fzf
nnoremap <C-p> :FZF! <CR>

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

"" Powerline fonts and enablers
" Airline ------------------------------
"
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

" Neomake ------------------------------
" " Run linter on write
autocmd! BufWritePost * Neomake
" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'

" Jedi-vim ------------------------------
" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0
" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'

" Deoplete -----------------------------
"
" " Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" NerdTree
" Open up NerdTree with Ctrl + N
map <C-n> :NERDTreeToggle<CR>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
