local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone http://github.com/wbthomason/packer.nvim ' .. install_path)
	execute 'packadd packer.nvim'
end

require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'

	use 'norcalli/nvim-colorizer.lua'
	use 'sheerun/vim-polyglot'
	use 'LunarWatcher/auto-pairs'
	use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
	use {'preservim/nerdcommenter'}
	use 'Shatur/neovim-ayu'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'kabouzeid/nvim-lspinstall'
	use {'crispgm/nvim-go', requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'}}
end)
