require("bootstrap")
require("plugins")

vim.cmd([[
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
colorscheme nightfly
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
nnoremap <leader>st :Telescope live_grep<CR>
nnoremap <leader>b :Telescope buffers<CR>

" nvim-tree
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
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
]])

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append("c")
-- creates great texts with where they are coming from
local lspkind = require("lspkind")
lspkind.init()

local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.gopls.setup{
	cmd = {'gopls'},
-- for postfix snippets and analyzers
	capabilities = capabilities,
	    settings = {
	      gopls = {
		      experimentalPostfixCompletions = true,
		      analyses = {
		        unusedparams = true,
		        shadow = true,
		     },
		     staticcheck = true,
		    },
	    },
}
-- local cmp = require("cmp")
-- cmp.setup({
-- 	snippet = {
-- 		expand = function(args)
-- 			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
-- 			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
-- 			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
-- 			-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
-- 		end,
-- 	},
-- 	mapping = {
-- 		["<C-d>"] = cmp.mapping.scroll_docs(-4),
-- 		["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 		["<C-Space>"] = cmp.mapping.complete(),
-- 		["<C-e>"] = cmp.mapping.close(),
-- 		["<CR>"] = cmp.mapping.confirm({ select = true }),
-- 	},
-- 	formatting = {
-- 		-- Youtube: How to set up nice formatting for your sources.
-- 		format = lspkind.cmp_format({
-- 			with_text = true,
-- 			menu = {
-- 				buffer = "[buf]",
-- 				nvim_lsp = "[LSP]",
-- 				nvim_lua = "[api]",
-- 				path = "[path]",
-- 				luasnip = "[snip]",
-- 			},
-- 		}),
-- 	},
-- 	experimental = {
-- 		-- I like the new menu better! Nice work hrsh7th
-- 		native_menu = false,

-- 		-- Let's play with this for a day or two
-- 		ghost_text = true,
-- 	},
-- 	--    the order of your sources matter (by default). That gives them priority
-- 	--    you can configure:
-- 	--        keyword_length
-- 	--        priority
-- 	--        max_item_count
-- 	--        (more?)
-- 	sources = cmp.config.sources({
-- 		{ name = "nvim_lsp" },
-- 		{ name = "vsnip" }, -- For vsnip users.
-- 		-- { name = 'luasnip' }, -- For luasnip users.
-- 		-- { name = 'ultisnips' }, -- For ultisnips users.
-- 		-- { name = 'snippy' }, -- For snippy users.
-- 	}, {
-- 		{ name = "path" },
-- 		{ name = "git" },
-- 		{ name = "buffer", keyword_length = 5 }, -- only do it for 5 chars
-- 	}),
-- })

-- Setup lspconfig.
-- configuring a new language
-- install the lsp globally

local lspconfig = require("lspconfig")

-- local settings = {}
-- local gosettings = {
-- 	gopls = {
-- 		analyses = {
-- 			unusedparams = true,
-- 		},
-- 		staticcheck = true,
-- 	},
-- }
-- require'cmp'.setup {
--   sources = {
--     { name = 'nvim_lsp' }
--   }
-- }
-- -- Use a loop to conveniently call 'setup' on multiple servers and
-- -- map buffer local keybindings when the language server attaches
-- local servers = { "gopls", "rust_analyzer" }
-- for _, lsp in ipairs(servers) do
-- 	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- 	if lsp == "gopls" then
-- 		settings = gosettings
-- 	end
-- 	require("lspconfig")[lsp].setup({
-- 		capabilities = capabilities,
-- 		settings = settings,
-- 		flags = {
-- 			debounce_text_changes = 150,
-- 		},
-- 	})
-- end
require("nvim-tree").setup({ options = {} })

local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end
local on_attach = function(client, bufnr)
	vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
	vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
	vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
	vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
	vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
	vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
	vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
	vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
	vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
	vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
	vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
	vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
	buf_map(bufnr, "n", "gd", ":LspDef<CR>")
	buf_map(bufnr, "n", "gr", ":LspRename<CR>")
	buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
	buf_map(bufnr, "n", "K", ":LspHover<CR>")
	buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
	buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
	buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
	buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
	buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
	if client.resolved_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
end
lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({
			eslint_bin = "eslint_d",
			eslint_enable_diagnostics = true,
			eslint_enable_code_actions = true,
			enable_formatting = true,
			formatter = "prettier",
		})
		ts_utils.setup_client(client)
		buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
		buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
		buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
		on_attach(client, bufnr)
	end,
})

-- example configuration! (see CONFIG above to make your own)
require("null-ls").config({
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.completion.spell,
    },
})

-- Plug 'folke/which-key.nvim'
require("which-key").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
})

require("toggleterm").setup({
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
})
