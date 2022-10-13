--local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    --execute("!git clone http://github.com/wbthomason/packer.nvim " .. install_path)
    --execute "packadd packer.nvim"
end

require("packer").startup(
    function(use)
        -- Packer plugin manager
        use "wbthomason/packer.nvim"

        -- eidtorconfig support
        use { 'gpanders/editorconfig.nvim' }

        -- lualine and bufferline
        use {
            "hoob3rt/lualine.nvim",
        }
        use { "akinsho/nvim-bufferline.lua", requires = "kyazdani42/nvim-web-devicons" }

        -- autopairs
        use "LunarWatcher/auto-pairs"
        -- commenter
        use { "preservim/nerdcommenter" }
        use { "ziontee113/color-picker.nvim" }
        use "norcalli/nvim-colorizer.lua"
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-telescope/telescope-fzy-native.nvim",
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim"
            }
        }
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {
                'kyazdani42/nvim-web-devicons', -- optional, for file icon
            },
        }

        use "mattn/emmet-vim"
        use "lukas-reineke/indent-blankline.nvim"
        -- language support
        use { "L3MON4D3/LuaSnip" }
        use { "rafamadriz/friendly-snippets" }
        use { 'saadparwaiz1/cmp_luasnip' }
        use {
            "ray-x/lsp_signature.nvim"
        }
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        }

        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/nvim-cmp"

        use {
            "neovim/nvim-lspconfig",
            --config = function()
            --require("nvim-lsp-installer").setup {}
            --local lspconfig = require("lspconfig")
            --end
        }
        use 'williamboman/nvim-lsp-installer'

        -- themes
        use { "npxbr/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }
        use "Shatur/neovim-ayu"
        use "navarasu/onedark.nvim"
        use "shaunsingh/nord.nvim"
        use "glepnir/zephyr-nvim"
        use "EdenEast/nightfox.nvim"

        -- git
        use {
            "lewis6991/gitsigns.nvim",
            requires = {
                "nvim-lua/plenary.nvim"
            }
        }

        -- debugging
        use 'mfussenegger/nvim-dap'
        use { 'leoluz/nvim-dap-go' }
        use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
        use 'theHamsta/nvim-dap-virtual-text'

        if packer_bootstrap then
            require('packer').sync()
        end
    end)
