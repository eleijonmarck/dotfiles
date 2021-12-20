-- Install packer
-- modelled after nvim-lua
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
--
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local use = require("packer").use
require("packer").startup(function()
	use("wbthomason/packer.nvim") -- Package manager
	use("tpope/vim-fugitive") -- Git commands in nvim
	use("tpope/vim-rhubarb") -- Fugitive-companion to interact with github
	use("tpope/vim-commentary") -- "gc" to comment visual regions/lines

	use("itchyny/lightline.vim") -- Fancier statusline
	use("joshdick/onedark.vim") -- Theme inspired by Atom
	-- Add indentation guides even on blank lines
	use("lukas-reineke/indent-blankline.nvim")
	-- Add git related info in the signs columns and popups
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

	-- UI to select things (files, grep results, open buffers...)
	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })

	-- NEEDS TESTING/EXPERIMENTAL
	use("ludovicchabant/vim-gutentags") -- Automatic tags management

	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use("nvim-treesitter/nvim-treesitter")
	-- Additional textobjects for treesitter
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip") -- Snippets plugin
	--" file explorer "
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	})

	-- Plugins can have post-install/update hooks
	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install", cmd = "MarkdownPreview" })

	use({
		"folke/which-key.nvim",
	})
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-------------------- GENERAL -----------------
--Set highlight on search
vim.o.hlsearch = false
--Make line numbers default
vim.wo.number = true
--Enable mouse mode
vim.o.mouse = "a"
--Enable break indent
vim.o.breakindent = true
--Save undo history
vim.opt.undofile = true
--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"
--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd([[colorscheme onedark]])
--Set statusbar
vim.g.lightline = {
	colorscheme = "onedark",
	active = { left = { { "mode", "paste" }, { "gitbranch", "readonly", "filename", "modified" } } },
	component_function = { gitbranch = "fugitive#head" },
}
--Remap space as leader key
-- vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])
-- add skeletons
vim.cmd([[
" skeleton templates
if has("autocmd")
  augroup templates
  autocmd BufNewFile Makefile 0r ~/.vim/templatkes/Makefile
  autocmd BufNewFile docker-compose.yml 0r ~/.vim/templates/docker-compose.yml
  augroup END
endif
]])
------------------------------------------------------------------------------------

--- Plugins
--
--blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require("gitsigns").setup({
	signs = {
		add = { hl = "GitGutterAdd", text = "+" },
		change = { hl = "GitGutterChange", text = "~" },
		delete = { hl = "GitGutterDelete", text = "_" },
		topdelete = { hl = "GitGutterDelete", text = "‾" },
		changedelete = { hl = "GitGutterChange", text = "~" },
	},
})

-- Telescope
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})
--Add leader shortcuts
vim.api.nvim_set_keymap(
	"n",
	"<leader><space>",
	[[<cmd>lua require('telescope.builtin').buffers()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sf",
	[[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sb",
	[[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sh",
	[[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>st",
	[[<cmd>lua require('telescope.builtin').tags()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sd",
	[[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>sp",
	[[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>so",
	[[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>?",
	[[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
	{ noremap = true, silent = true }
)
-- nnoremap <leader>e :NvimTreeToggle<CR>

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
})

-- LSP settings
local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>so",
		[[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", [[<cmd>:NvimTreeToggle<CR>]], opts)
	-- trigger autoformatting if it available
	if client.resolved_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
end
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
-- Enable the following language servers
local servers = { "rust_analyzer", "tsserver", "gopls", "pyright" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require("lspconfig").sumneko_lua.setup({
	-- brew install lua-language-server
	cmd = { "/opt/homebrew/bin/lua-language-server" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
-- luasnip setup
local luasnip = require("luasnip")
-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})


-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}
-- vim.cmd([[
-- " ============================================================================
-- " GENERAL - default
-- """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- " default options
-- set clipboard+=unnamedplus " might come with performance issues
-- set completeopt=menu,menuone,noselect " better autocomplete options
-- set mouse=a " if I accidentally use the mouse
-- set splitright " splits to the right
-- set splitbelow " splits below
-- set expandtab " space characters instead of tab
-- set tabstop=2 " tab equals 2 spaces
-- set shiftwidth=2 " indentation
-- set diffopt+=vertical " starts diff mode in vertical split
-- set hidden " allow hidden buffers
-- set nobackup " don't create backup files
-- set nowritebackup " don't create backup files
-- set cmdheight=1 " only one line for commands
-- set shortmess+=c " don't need to press enter so often
-- set signcolumn=yes " add a column for sings (e.g. LSP, ...)
-- set lazyredraw " Don't redraw while executing macros (good performance config)
-- set scrolloff=7 " when scrolling, keep cursor x lines away from screen border
-- filetype plugin indent on " enable detection, plugins and indents
-- let mapleader = " " " space as leader key
-- if (has("termguicolors"))
--   set termguicolors " better colors, but makes it sery slow!
-- endif
-- colorscheme nightfly
-- let g:netrw_banner=0 " disable banner in netrw
-- let g:netrw_liststyle=3 " tree view in netrw
-- " to make me forget about esc or easier esc
-- imap jk <Esc>
-- imap kj <Esc>
-- imap jj <Esc>
--
-- " open vimrc
-- nmap <leader><leader> :e ~/.vimrc<CR>
-- " neoterminal use esc to exit inster
-- :tnoremap <Esc> <C-\><C-n>
--
-- " Plugin specific setup""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
-- nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
-- nnoremap <silent> gH    <cmd>:Telescope lsp_code_actions<CR>
-- nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
-- nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
-- nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
-- nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
-- """""""""
-- " nvim-telescope/telescope.nvim
-- nnoremap <leader>f :Telescope find_files<CR>
-- nnoremap <leader>st :Telescope live_grep<CR>
-- nnoremap <leader>b :Telescope buffers<CR>
-- """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- ]])
--
-- -- Don't show the dumb matching stuff.
-- vim.opt.shortmess:append("c")
-- -- creates great texts with where they are coming from
-- local lspkind = require("lspkind")
-- lspkind.init()
--
--
-- -- Add additional capabilities supported by nvim-cmp
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
--
-- -- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'
--
-- -- luasnip setup
-- local luasnip = require 'luasnip'
--
-- -- nvim-cmp setup
-- local cmp = require 'cmp'
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       require('luasnip').lsp_expand(args.body)
--     end,
--   },
--   mapping = {
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ['<Tab>'] = function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end,
--     ['<S-Tab>'] = function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end,
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--   },
-- }
--
--
-- local buf_map = function(bufnr, mode, lhs, rhs, opts)
-- 	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
-- 		silent = true,
-- 	})
-- end
-- local on_attach = function(client, bufnr)
-- 	vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
-- 	vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
-- 	vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
-- 	vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
-- 	vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
-- 	vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
-- 	vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
-- 	vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
-- 	vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
-- 	vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
-- 	vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
-- 	vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
-- 	buf_map(bufnr, "n", "gd", ":LspDef<CR>")
-- 	buf_map(bufnr, "n", "gr", ":LspRename<CR>")
-- 	buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
-- 	buf_map(bufnr, "n", "K", ":LspHover<CR>")
-- 	buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
-- 	buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
-- 	buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
-- 	buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
-- 	buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
-- 	if client.resolved_capabilities.document_formatting then
-- 		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
-- 	end
-- end
-- lspconfig.tsserver.setup({
-- 	on_attach = function(client, bufnr)
-- 		client.resolved_capabilities.document_formatting = false
-- 		client.resolved_capabilities.document_range_formatting = false
-- 		local ts_utils = require("nvim-lsp-ts-utils")
-- 		ts_utils.setup({
-- 			eslint_bin = "eslint_d",
-- 			eslint_enable_diagnostics = true,
-- 			eslint_enable_code_actions = true,
-- 			enable_formatting = true,
-- 			formatter = "prettier",
-- 		})
-- 		ts_utils.setup_client(client)
-- 		buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
-- 		buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
-- 		buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
-- 		on_attach(client, bufnr)
-- 	end,
-- })
--
-- -- example configuration! (see CONFIG above to make your own)
-- require("null-ls").config({
--     sources = {
--         require("null-ls").builtins.formatting.stylua,
--         require("null-ls").builtins.completion.spell,
--     },
-- })
--
-- -- Plug 'folke/which-key.nvim'
-- require("which-key").setup({
-- 	-- your configuration comes here
-- 	-- or leave it empty to use the default settings
-- 	-- refer to the configuration section below
-- })
--
-- require("toggleterm").setup({
-- 	on_config_done = nil,
-- 	-- size can be a number or function which is passed the current terminal
-- 	size = 20,
-- 	-- open_mapping = [[<c-\>]],
-- 	open_mapping = [[<c-t>]],
-- 	hide_numbers = true, -- hide the number column in toggleterm buffers
-- 	shade_filetypes = {},
-- 	shade_terminals = true,
-- 	shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
-- 	start_in_insert = true,
-- 	insert_mappings = true, -- whether or not the open mapping applies in insert mode
-- 	persist_size = false,
-- 	-- direction = 'vertical' | 'horizontal' | 'window' | 'float',
-- 	direction = "float",
-- 	close_on_exit = true, -- close the terminal window when the process exits
-- 	shell = vim.o.shell, -- change the default shell
-- 	-- This field is only relevant if direction is set to 'float'
-- 	float_opts = {
-- 		-- The border key is *almost* the same as 'nvim_win_open'
-- 		-- see :h nvim_win_open for details on borders however
-- 		-- the 'curved' border is a custom border type
-- 		-- not natively supported but implemented in this plugin.
-- 		-- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
-- 		border = "curved",
-- 		-- width = <value>,
-- 		-- height = <value>,
-- 		winblend = 0,
-- 		highlights = {
-- 			border = "Normal",
-- 			background = "Normal",
-- 		},
-- 	},
-- 	-- Add executables on the config.lua
-- 	-- { exec, keymap, name}
-- 	-- lvim.builtin.terminal.execs = {{}} to overwrite
-- 	-- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
-- 	execs = {
-- 		{ "lazygit", "gg", "LazyGit" },
-- 	},
-- })
