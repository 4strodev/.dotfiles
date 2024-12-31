local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false

-- Installing packer if it is not installed
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

require("packer").startup(
    function(use)
        -- Packer plugin manager
        use "wbthomason/packer.nvim"

        -- lualine and bufferline
        use { "hoob3rt/lualine.nvim" }
        use { "akinsho/nvim-bufferline.lua" }

        -- autopairs
        use { "windwp/nvim-autopairs" }

        -- commenter
        use { "preservim/nerdcommenter" }

        -- hex colorizer
        use "norcalli/nvim-colorizer.lua"

        -- telescope 🔭
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-telescope/telescope-fzy-native.nvim",
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim"
            }
        }

        -- file icons
        use { 'kyazdani42/nvim-web-devicons' }

        -- file explorer
        use {
            'kyazdani42/nvim-tree.lua',
        }

        -- indent line
        use "lukas-reineke/indent-blankline.nvim"

        -- language snippets
        use { "L3MON4D3/LuaSnip" }
        use { "rafamadriz/friendly-snippets" }
        use { 'saadparwaiz1/cmp_luasnip' }

        -- treesiter
        use { "nvim-treesitter/nvim-treesitter" }

        -- lsp and completion
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/nvim-cmp"
        use { "neovim/nvim-lspconfig" }
        use { "williamboman/mason.nvim" }
        use "williamboman/mason-lspconfig.nvim"
        use { "ray-x/lsp_signature.nvim" }

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
            requires = { "nvim-lua/plenary.nvim" }
        }

        -- debugging
        use 'mfussenegger/nvim-dap'
        use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
        use 'theHamsta/nvim-dap-virtual-text'

        if packer_bootstrap then
            require('packer').sync()
        end
    end)
