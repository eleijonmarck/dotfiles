" most of the structure is taken from https://github.com/fisadev/fisa-nvim-config
" thank you https://www.youtube.com/watch?v=vlb3qUiS2ZY
" Vim-plug initalization
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" " Kill bad habits
" noremap h <NOP>
" noremap j <NOP>
" noremap k <NOP>
" noremap l <NOP>

" Active plugins
" You can disable or add new ones here:
call plug#begin('~/vim/plugged')

Plug 'scrooloose/nerdtree'
" plugin for awesome color
Plug 'haishanh/night-owl.vim'
" sane editor config
Plug 'editorconfig/editorconfig-vim'


" Plugin tpope, making my life easier
Plug 'tpope/vim-commentary' " comments with <gcc> , or <V-gc> for visual mode
Plug 'tpope/vim-repeat' " makes the . command repearable
Plug 'tpope/vim-fugitive' " git on steriods inside vim
Plug 'tpope/vim-rhubarb' " makes so that git can be opened using GBrowse

" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"""""""""""""""""""""""""""""""""

" Language Plugs and helpers

" Paint css colors with the real color
Plug 'lilydjwg/colorizer'

" Golang
Plug 'fatih/vim-go', {'for': 'go'}

" typescript, javascript, graphql
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax

" html
Plug 'mattn/emmet-vim'

" language server - https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ============================================================================
" Needs to be in beginning to be useful
let mapleader = ','

" Use markdown syntax for .md
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" GENERAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on

syntax on
set nocompatible              " required (not compatible with old vi)

set encoding=utf-8 termencoding=utf-8

" Configure backspace so it acts as it should act
" set backspace=indent,eol,start

" set numbers
set number
" set relative number beside the numbers
set relativenumber

" setting clipboard to unnamed makes vim extemely slow
" set clipboard=unnamed
set clipboard=unnamedplus

" no backupfiles
set nowritebackup noswapfile nobackup

" case sensitivity
" When searching try to be smart about cases
set ignorecase smartcase

set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'

set smarttab      " insert tabs on the start of a line according to
"                   "    shiftwidth, not tabstop
" Normal action
set expandtab
set shiftwidth=2
set softtabstop=2
filetype plugin indent on

if has("autocmd")
    " If the filetype is Makefile then we need to use tabs
    " So do not expand tabs into space.
    autocmd FileType make set noexpandtab
endif

" always show the status line
set laststatus=2

" Height of the command bar
set cmdheight=2

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.swp,*.bak,*.pyc,*.class
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

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

" when scrolling, keep cursor x lines away from screen border
set scrolloff=7

" " remove trailing whitespace
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

" skeleton templates
if has("autocmd")
  augroup templates
    autocmd BufNewFile Makefile 0r ~/.vim/templates/Makefile
    autocmd BufNewFile docker-compose.yml 0r ~/.vim/templates/docker-compose.yml
  augroup END
endif
" Plugin specific setup""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" disable vim-go gd in favor of coc
let g:go_def_mapping_enabled = 0


"""""""""""""
" COC settings - language server
" if hidden is not set, textedit might fail
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation in preview window for hover
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" coc-extensions: https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
let g:coc_global_extensions = ['coc-eslint', 'coc-prettier', 'coc-tsserver', 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml', 'coc-stylelint', 'coc-sh']
"""""""""
" FZF
set rtp+=~/.fzf
"
" search files
nnoremap <silent> <C-f> :Files<CR>
" search inside files
nnoremap <silent> <Leader>f :Rg<CR>
" search open buffers
nnoremap <silent> <Leader>b :Buffers<CR>

let g:python_version = matchstr(system("python --version | cut -f2 -d' '"), '^[0-9]')
if g:python_version =~ 3
    let g:python2_host_prog = "/bin/python"
else
    let g:python3_host_prog = "/bin/python3"
endif

" NERDTREEEE!!!!!!!!!!!!!!!"
" Ctrl b to toggle Nerdtree
nnoremap <C-b> :NERDTreeToggle<CR>
"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', '\.git']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
let g:NERDTreeShowHidden=1 " hidden files by default
let g:nerdtree_tabs_focus_on_files=1
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" jump between jumps
" same as in visual studio code
nnoremap <C-t> <C-o>


" to make me forget about esc or easier esc
imap jk <Esc>
imap kj <Esc>
imap jj <Esc>

" open vimrc
nmap <leader>, :e ~/.vimrc<CR>

" neoterminal use esc to exit inster
:tnoremap <Esc> <C-\><C-n>
