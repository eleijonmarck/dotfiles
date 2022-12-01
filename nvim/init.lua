-- Install packer
-- modelled after nvim-lua
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
--
--
-- ================================================================== --
-- ===                      EDITOR SETTINGS                       === --
-- ================================================================== --

-- set clipboard to system
vim.o.clipboard = "unnamed"
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
vim.o.termguicolors = true


--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
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
--
--blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false


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
	"<leader>sg",
	[[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>?",
	[[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader><,>",
	[[<cmd>e ~/.vimrc<CR>]],
	{ noremap = true, silent = true }
)

-- ================================================================== --
-- ===                          PLUGINS                           === --
-- ================================================================== --


local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	print('Installing packer...')
	local packer_url = 'https://github.com/wbthomason/packer.nvim'
	vim.fn.system({ 'git', 'clone', packer_url, install_path })
	print('Done.')

	vim.cmd('packadd packer.nvim')
	install_plugins = true
end

require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- Package manager
	use("tpope/vim-fugitive") -- Git commands in nvim
	use("tpope/vim-rhubarb") -- Fugitive-companion to interact with github
	use("tpope/vim-commentary") -- "gc" to comment visual regions/lines
	---
	use("itchyny/lightline.vim") -- Fancier statusline

	-- colorschemes
	use("EdenEast/nightfox.nvim") -- Packer


	-- Add indentation guides even on blank lines
	use("lukas-reineke/indent-blankline.nvim")
	-- Add git related info in the signs columns and popups
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
	-- UI to select things (files, grep results, open buffers...)
	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
	---
	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use("nvim-treesitter/nvim-treesitter")
	-- Additional textobjects for treesitter
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("neovim/nvim-lspconfig") -- Collection of configurations for built-in LSP client
	---
	--Autocomplete
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
		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	})
	-- Plugins can have post-install/update hooks
	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install", cmd = "MarkdownPreview" })

	-- issues and PR from inside neovim
	use({
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require "octo".setup()
		end
	})

	-- copilot
	use({
		"github/copilot.vim",
	})

	-- which key to show how many
	use({
		"folke/which-key.nvim",
	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if install_plugins then
		require('packer').sync()
	end
end)

if install_plugins then
	return
end

--Set colorscheme (order is important here)
require('nightfox').setup({
	options = {
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic,bold",
		}
	}
})
vim.cmd("colorscheme nightfox")

--Set statusbar
vim.g.lightline = {
	colorscheme = "nightfox",
	active = { left = { { "mode", "paste" }, { "gitbranch", "readonly", "relativepath", "modified" } } },
	component_function = { gitbranch = "fugitive#head" },
}


-- ================================================================== --
-- ===                    PLUGIN CONFIGURATION                    === --
-- ================================================================== --
--
-- copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.g.copilot_filetypes = {
	["*"] = false,
	["javascript"] = true,
	["typescript"] = true,
	["lua"] = false,
	["rust"] = true,
	["c"] = true,
	["c#"] = true,
	["c++"] = true,
	["go"] = true,
	["python"] = true,
}

-- Gitsigns
--
require('gitsigns').setup()


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

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>e", [[<cmd>:NvimTreeFindFileToggle<CR>]], opts)
vim.keymap.set('n', 'D', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts, { async = true })
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

------------------------ LANGUAGE SERVERS ---------------

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require('lspconfig')['pyright'].setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}
require('lspconfig')['tsserver'].setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}
require('lspconfig')['rust_analyzer'].setup {
	on_attach = on_attach,
	flags = lsp_flags,
	-- Server-specific settings...
	settings = {
		["rust-analyzer"] = {}
	},
	capabilities = capabilities,
}
require('lspconfig')['gopls'].setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}
require('lspconfig')['terraformls'].setup {}
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.tf", "*.tfvars" },
	callback = vim.lsp.buf.formatting_sync,
})

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
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete({
			reason = cmp.ContextReason.Auto,
		}), { "i", "c" }),
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
--

-- init.lua - nvim tree
-- setup with all defaults
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
-- setup with some options
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		preserve_window_proportions = false,
	},
	actions = {
		open_file = {
			resize_window = true,
		}
	},
	filters = {
		dotfiles = true,
	},
	git = {
		ignore = false,
	},
})

-- Plug 'folke/which-key.nvim'
require("which-key").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
})
