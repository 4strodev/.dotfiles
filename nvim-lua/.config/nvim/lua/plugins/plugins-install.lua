local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone http://github.com/wbthomason/packer.nvim ' .. install_path)
	execute 'packadd packer.nvim'
end

require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use {
	  'hoob3rt/lualine.nvim',
	  requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

	use 'norcalli/nvim-colorizer.lua'
	use 'sheerun/vim-polyglot'
	use 'LunarWatcher/auto-pairs'
	use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
	use {'preservim/nerdcommenter'}
	use 'Shatur/neovim-ayu'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'kabouzeid/nvim-lspinstall'

	use {
		'nvim-telescope/telescope.nvim', requires = {
			'nvim-telescope/telescope-fzy-native.nvim',
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim'
		}
	}

	use {'SirVer/ultisnips', requires = {'honza/vim-snippets'}}
	use {
		"ray-x/lsp_signature.nvim",
	}
	use {'L3MON4D3/LuaSnip'}

	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		}
	}
end)
