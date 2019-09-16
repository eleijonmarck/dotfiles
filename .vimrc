" NEOVIM configuration
" most of the structure is taken from https://github.com/fisadev/fisa-nvim-config
" thank you https://www.youtube.com/watch?v=vlb3qUiS2ZY
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

"" tried plugins
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
" youcompleteme
""
" Active plugins
" You can disable or add new ones here:
call plug#begin('~/vim/plugged')

" plugin for awesome color
Plug 'haishanh/night-owl.vim'

" Plugin tpope, making my life easier
Plug 'tpope/vim-markdown' " markdown
Plug 'tpope/vim-surround' " surronds the ',\" and {. :help surround
Plug 'tpope/vim-commentary' " comments with <gcc> , or <V-gc> for visual mode
Plug 'tpope/vim-repeat' " makes the . command repearable

" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"""""""""""""""""""""""""""""""""

" Language Plugs and helpers
"" linting
Plug 'w0rp/ale'
""""""""""""""""""
" Python
" Automatically sort python imports
Plug 'fisadev/vim-isort'
" Autoformating for python https://github.com/ambv/black
Plug 'ambv/black', {'for': 'python'} "

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

" Completion Engine
Plug 'prabirshrestha/async.vim' " requirement langaure server provider
Plug 'prabirshrestha/vim-lsp'   " vim lsp
Plug 'roxma/nvim-yarp'          " ncm reuiqred
Plug 'ncm2/ncm2-vim-lsp'        " integrate vim-lsp with ncm
Plug 'ncm2/ncm2'                " framework for autcomple
Plug 'ncm2/ncm2-bufword'        " buffer keyword completion
Plug 'ncm2/ncm2-path'           " filepath completion
"Plug 'davidhalter/jedi-vim'   " jedi for python

call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" Needs to be in beginning to be useful
let mapleader = ','

" python specific
let python_highlight_all=1
" python PEP8 standard
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=200 expandtab autoindent fileformat=unix

" Set tab width etc
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" GENERAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

syntax on
set encoding=utf-8 termencoding=utf-8

" Configure backspace so it acts as it should act
set backspace=indent,eol,start

set relativenumber number

" Use spaces instead of tabs
set expandtab
set clipboard=unnamedplus

" Copy pasting from/into vim
vnoremap <C-c> "+y
vnoremap <C-v> "+P

" no backupfiles
set nowritebackup noswapfile nobackup

" case sensitivity
" When searching try to be smart about cases
set ignorecase smartcase

" always show the status line
set laststatus=2

" indents
set autoindent
set wrap "wrap lines

" Height of the command bar
set cmdheight=2

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.swp,*.bak,*.pyc,*.class
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" wildmode for autocompletion madness
set wildmode=longest,list,full

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set title
set visualbell noerrorbells

" Search
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

" Hide the mouse pointer while typing
set mouse=a

" Don't redraw while executing macros (good performance config)
set lazyredraw

set ttyfast           " enabled by default anyway should make scrolling faster

" splits
set splitbelow splitright    " spawn vertical splits to the right instead of left"

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=7

" remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

"" Use different colorschemes dependant on filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" good colorschemes

" use 256 colors when possible
" " If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme night-owl

" Plugin specific setup""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Language Server plugins
" NOTE: this is built upon the open source protocols provided by Microsoft
" anyother impelentetaion is hjust an abstraction of actually installing a
" language server and pointing to that language server

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
" make it FAST
if executable('pyls')
  " pip install python-language-server
  au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('docker-langserver')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'docker-langserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
        \ 'whitelist': ['dockerfile'],
        \ })
endif

if executable('go-langserver')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
        \ 'whitelist': ['go'],
        \ })
endif

" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" set completion heihg to 5
set pumheight=5
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1,1]]
let g:ncm2#matcher = 'substrfuzzy'

" Below goto defiintions with the respective LSP
nnoremap K :LspHover<CR>
nnoremap <leader>d :LspDefinition<CR>

" FZF
set rtp+=~/.fzf
nnoremap <C-p> :FZF! <CR>

" Toggle ale linter
map <leader>e :ALEToggle <CR>
map <leader>f :ALEFix <CR>

" Go to next error/warning
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" nmap <leader>g <Plug>(ale_go_to_definition) " Not working

let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 0
let g:ale_maximum_file_size = 500000                " Don't lint large files (> 500KB), it can slow things down
let g:ale_linters = {}
let g:ale_linters.python = ['pylint', 'flake8']
let g:ale_linters.go = ['go', 'golint', 'errcheck']
let g:ale_linters.javascript = ['eslint', 'xo']
let g:ale_linters.html = []
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['prettier']
let g:ale_fixers.python = ['yapf', 'trim_whitespace']

let g:ale_python_flake8_options = "max-line-length = 120"
let g:ale_python_pylint_options = "max-line-length = 120"

let g:ale_sign_error = '💣'
let g:ale_sign_warning = '⚠'

highlight clear ALEErrorSign
highlight clear ALEWarningSign

" Black formatting for python
" To run Black on save, add the following line to .vimrc or init.vim:
autocmd BufWritePre *.py execute ':Black'

" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch tabs
nnoremap <C-h> :tabp <CR>
nnoremap <C-l> :tabn <CR>

" open vimrc
nmap <leader>, :e ~/.vimrc<CR>

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" enter closes up" enter closes popup if nothing selected
inoremap <silent> <expr> <CR> (pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : "\<CR>"

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" neoterminal
:tnoremap <Esc> <C-\><C-n>
