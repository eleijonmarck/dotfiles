" NEOVIM configuration
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
Plug 'tpope/vim-surround' " surronds the ',\" and {. :help surround
Plug 'tpope/vim-commentary' " comments with <gcc> , or <V-gc> for visual mode
Plug 'tpope/vim-repeat' " makes the . command repearable

" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"""""""""""""""""""""""""""""""""

" Language Plugs and helpers

" Paint css colors with the real color
Plug 'lilydjwg/colorizer'

" Golang
Plug 'fatih/vim-go', {'for': 'go'}

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
" filetype off                  " required<Paste>

set encoding=utf-8 termencoding=utf-8

" Configure backspace so it acts as it should act
set backspace=indent,eol,start

" set numbers
set number
" set relative number beside the numbers
set relativenumber

" setting clipboard to unnamed makes vim extemely slow
" set clipboard=unnamed
" set clipboard+=unnamedplus

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
" autocmd BufWritePre * %s/\s\+$//e

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

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

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
nmap <leader>rn <Plug>(coc-rename)

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
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" coc-extensions: https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
let g:coc_global_extensions = ['coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-tsserver','coc-tslint', 'coc-tslint-plugin', 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml', 'coc-stylelint']
"""""""""

" FZF
set rtp+=~/.fzf
nnoremap <C-p> :FZF! <CR>

let g:python_version = matchstr(system("python --version | cut -f2 -d' '"), '^[0-9]')
if g:python_version =~ 3
    let g:python2_host_prog = "/bin/python"
else
    let g:python3_host_prog = "/bin/python3"
endif

" Ctrl b to toggle Nerdtree
nnoremap <C-b> :NERDTreeToggle<CR>

" vim-go not def mapping enable
let g:go_def_mapping_enabled = 0

" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open vimrc
nmap <leader>, :e ~/.vimrc<CR>


" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" neoterminal use esc to exit inster
:tnoremap <Esc> <C-\><C-n>
