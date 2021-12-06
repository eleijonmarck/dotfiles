-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

 -- show buffer/lsp 
  use('onsails/lspkind-nvim')

  -- colorscheme
  use('bluz71/vim-nightfly-guicolors')

	use("editorconfig/editorconfig-vim") -- sane editor config
	-- tpope i love you
	use("tpope/vim-fugitive") -- git
	use("tpope/vim-commentary") -- comments with <gcc> , or <V-gc> for visual mode
	use("tpope/vim-rhubarb") -- makes so that git can be opened using GBrowse

  -- null-ls
  use('jose-elias-alvarez/null-ls.nvim')

  -- lspconfig
  use({
    'neovim/nvim-lspconfig'
  })

    -- Plugins can have dependencies on other plugins
  use {
    'haorenW1025/completion-nvim',
    opt = true,
    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  }


  -- fuzzyfinder
  use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- toggleterminal
  use("akinsho/toggleterm.nvim")

  -- statusline
	use({
		"hoob3rt/lualine.nvim",
		opt = true,
		requires = {
			{ "ryanoasis/vim-devicons" },
			{ "Mofiqul/vscode.nvim" },
		},
	})

  --" file explorer "
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
}

	use({
		"nvim-telescope/telescope.nvim",
		opt = true,
		requires = { { "nvim-lua/plenary.nvim", opt = true } },
	})

	-- Plugins can have post-install/update hooks
	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install", cmd = "MarkdownPreview" })

	-- Post-install/update hook with neovim command
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  use({
    'folke/which-key.nvim'
  })

end)
