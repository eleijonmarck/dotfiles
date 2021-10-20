" most of the structure is taken from
"https://github.com/David-Kunz/vim/blob/master/_init.vim
" thank you
" https://www.youtube.com/watch?v=cQ-7ex7je88
" Vim-plug initalization
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Active plugins
" You can disable or add new ones here:
call plug#begin('~/vim/plugged')
  Plug 'haishanh/night-owl.vim' " plugin for awesome color
  Plug 'editorconfig/editorconfig-vim' " sane editor config
  " Plugin tpope, making my life easier
  Plug 'tpope/vim-fugitive' " git
  Plug 'tpope/vim-commentary' " comments with <gcc> , or <V-gc> for visual mode
  Plug 'tpope/vim-rhubarb' " makes so that git can be opened using GBrowse
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  " ---
  " file explorer "
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'
  " file explorer "
  " ---
  " statusline
  Plug 'ryanoasis/vim-devicons'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'Mofiqul/vscode.nvim'
  " statusline
  " ---
  """"""""""""""""""""""""""""""""
  " Language Plugs and helpers
  " Paint css colors with the real color
  Plug 'lilydjwg/colorizer'
  " Golang
  " Plug 'fatih/vim-go', {'for': 'go'}
  " typescript, javascript, graphql
  " Plug 'pangloss/vim-javascript'    " JavaScript support
  " Plug 'leafgarland/typescript-vim' " TypeScript syntax
  " Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
  " Plug 'jparise/vim-graphql'        " GraphQL syntax
  " Plug 'mattn/emmet-vim' " html
  Plug 'neovim/nvim-lspconfig'
call plug#end()

" ============================================================================

" GENERAL - default
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" default options
set completeopt=menu,menuone,noselect " better autocomplete options
set mouse=a " if I accidentally use the mouse
set splitright " splits to the right
set splitbelow " splits below
set expandtab " space characters instead of tab
set tabstop=2 " tab equals 2 spaces
set shiftwidth=2 " indentation
set number " show absolute line numbers
set ignorecase " search case insensitive
set smartcase " search via smartcase
set incsearch " search incremental
set diffopt+=vertical " starts diff mode in vertical split
set hidden " allow hidden buffers
set nobackup " don't create backup files
set nowritebackup " don't create backup files
set cmdheight=1 " only one line for commands
set shortmess+=c " don't need to press enter so often
set signcolumn=yes " add a column for sings (e.g. LSP, ...)
set updatetime=520 " time until update
set undofile " persists undo tree
set lazyredraw " Don't redraw while executing macros (good performance config)
set scrolloff=7 " when scrolling, keep cursor x lines away from screen border
filetype plugin indent on " enable detection, plugins and indents
let mapleader = " " " space as leader key
if (has("termguicolors"))
  set termguicolors " better colors, but makes it sery slow!
endif
colorscheme night-owl
let g:netrw_banner=0 " disable banner in netrw
let g:netrw_liststyle=3 " tree view in netrw
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript'] " syntax highlighting in markdown

" skeleton templates
if has("autocmd")
  augroup templates
    autocmd BufNewFile Makefile 0r ~/.vim/templates/Makefile
    autocmd BufNewFile docker-compose.yml 0r ~/.vim/templates/docker-compose.yml
  augroup END
endif

" Plugin specific setup""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gH    <cmd>:Telescope lsp_code_actions<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
"""""""""

"" FZF
"set rtp+=~/.fzf
"" search files
"nnoremap <silent> <C-f> :Files<CR>
"" search inside files
"nnoremap <silent> <Leader>f :Rg<CR>
"" search open buffers
"nnoremap <silent> <Leader>b :Buffers<CR>
""

" 'hoob3rt/lualine.nvim'
lua << EOF
  require('lualine').setup({
  options = {
    theme = "vscode"
   }
  })
EOF

lua << EOF
  require('nvim-tree').setup({options={}})
EOF

" neovim/nvim-lspconfig
lua << EOF
  local nvim_lsp = require('lspconfig')
  -- configuring a new language
  -- install the lsp globally

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'rust_analyzer', 'tsserver' }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end
EOF

" nvim-telescope/telescope.nvim
nnoremap <leader>f :Telescope find_files<CR>
" nvim-tree
nnoremap <leader>e :NvimTreeToggle<CR>

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
nmap <leader><leader> :e ~/.vimrc<CR>

" neoterminal use esc to exit inster
:tnoremap <Esc> <C-\><C-n>

