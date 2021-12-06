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

  " fuzzy finder
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
  "
  "  integrated terminal
  Plug 'akinsho/toggleterm.nvim'
  "
  "
  """"""""""""""""""""""""""""""""
  " Language Plugs and helpers
  " Paint css colors with the real color
  Plug 'lilydjwg/colorizer'

  Plug 'neovim/nvim-lspconfig' " Lsp
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'hrsh7th/nvim-cmp' " Autocompletetion
  " dep
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  " For vsnip users.
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  Plug 'onsails/lspkind-nvim' " show buffer/lsp

  Plug 'folke/which-key.nvim'
call plug#end()

" ============================================================================

" GENERAL - default
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" default options
set clipboard+=unnamedplus " might come with performance issues
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

" jump between jumps
" same as in visual studio code
nnoremap <C-t> <C-o>

" to make me forget about esc or easier esc
imap jk <Esc>
imap kj <Esc>
imap jj <Esc>

" make yank behave like it should
" primegen
" https://www.youtube.com/watch?v=hSHATqh8svM
nnoremap Y yg$ 
" keep things centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" open vimrc
nmap <leader><leader> :e ~/.vimrc<CR>

" neoterminal use esc to exit inster
:tnoremap <Esc> <C-\><C-n>

" Plugin specific setup""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gH    <cmd>:Telescope lsp_code_actions<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
"""""""""
" nvim-telescope/telescope.nvim
nnoremap <leader>f :Telescope find_files<CR>

" nvim-tree
nnoremap <leader>e :NvimTreeToggle<CR>

" neoformat for javascript
" autocmd FileType javascript setlocal formatprg=prettier\ --parser\ typescript
" autocmd FileType javascript.jsx setlocal formatprg=prettier\ --parser\ typescript
" autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript

" quickfix listings
" globallist
nnoremap <C-q> :call ToggleQFList(1)<CR>
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
" locallist
nnoremap <leader>q :call ToggleQFList(0)<CR>
nnoremap <leader>j :lnext<CR>zz
nnoremap <leader>k :lprev<CR>zz

let g:the_primeagen_qf_l = 0
let g:the_primeagen_qf_g = 0

fun! ToggleQFList(global)
    if a:global
        if g:the_primeagen_qf_g == 1
            let g:the_primeagen_qf_g = 0
            cclose
        else
            let g:the_primeagen_qf_g = 1
            copen
        end
    else
        if g:the_primeagen_qf_l == 1
            let g:the_primeagen_qf_l = 0
            lclose
        else
            let g:the_primeagen_qf_l = 1
            lopen
        end
    endif
endfun
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" nvim-cmp
set pumheight=10 " only 10 items max for
lua <<EOF
  -- Don't show the dumb matching stuff.
  vim.opt.shortmess:append "c"
  -- creates great texts with where they are coming from
  local lspkind = require "lspkind"
  lspkind.init()
  
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
      },
    },
  },
  experimental = {
    -- I like the new menu better! Nice work hrsh7th
    native_menu = false,

    -- Let's play with this for a day or two
    ghost_text = true,
  },
  --    the order of your sources matter (by default). That gives them priority
  --    you can configure:
  --        keyword_length
  --        priority
  --        max_item_count
  --        (more?)
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'path' },
      { name = 'git' },
      { name = 'buffer', keyword_length = 5 }, -- only do it for 5 chars
    })
  })

  -- Setup lspconfig.
  -- configuring a new language
  -- install the lsp globally

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'rust_analyzer', 'tsserver', 'gopls' }
  for _, lsp in ipairs(servers) do
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    require('lspconfig')[lsp].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end
EOF

" Vim Script
" Plug 'folke/which-key.nvim'
lua <<EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

lua <<EOF
require("toggleterm").setup{
    on_config_done = nil,
    -- size can be a number or function which is passed the current terminal
    size = 20,
    -- open_mapping = [[<c-\>]],
    open_mapping = [[<c-t>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_win_open'
      -- see :h nvim_win_open for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      border = "curved",
      -- width = <value>,
      -- height = <value>,
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    -- Add executables on the config.lua
    -- { exec, keymap, name}
    -- lvim.builtin.terminal.execs = {{}} to overwrite
    -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
    execs = {
      { "lazygit", "gg", "LazyGit" },
    },
  }
EOF
