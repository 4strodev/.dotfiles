local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone http://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

require("packer").startup(
    function()
        use "wbthomason/packer.nvim"

        -- utilities
        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }
        use {
            "DougBeney/pickachu"
        }
        use {"akinsho/nvim-bufferline.lua", requires = "kyazdani42/nvim-web-devicons"}
        use "LunarWatcher/auto-pairs"
        use {"preservim/nerdcommenter"}
        use "norcalli/nvim-colorizer.lua"
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-telescope/telescope-fzy-native.nvim",
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim"
            }
        }
        use "mhartington/formatter.nvim"
        use "mattn/emmet-vim"
        use "lukas-reineke/indent-blankline.nvim"
        -- language support
        use {"L3MON4D3/LuaSnip"}
        use {
            "ray-x/lsp_signature.nvim"
        }
        use {"SirVer/ultisnips", requires = {"honza/vim-snippets"}}
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        }
        use "nvim-treesitter/playground"
        use "neovim/nvim-lspconfig"
        use "hrsh7th/nvim-compe"
        use "kabouzeid/nvim-lspinstall"
        --use "sheerun/vim-polyglot"

        -- themes
        use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
        use "Shatur/neovim-ayu"
        use "navarasu/onedark.nvim"
        use "shaunsingh/nord.nvim"
        use "glepnir/zephyr-nvim"

        -- git
        use {
            "lewis6991/gitsigns.nvim",
            requires = {
                "nvim-lua/plenary.nvim"
            }
        }
    end
)
