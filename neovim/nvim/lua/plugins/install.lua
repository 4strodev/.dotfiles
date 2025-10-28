-- Checking if lazyvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    spec = {
        -- lualine and bufferline
        { "hoob3rt/lualine.nvim" },
        { "akinsho/nvim-bufferline.lua" },

        -- autopairs
        { "windwp/nvim-autopairs" },

        -- commenter
        { "preservim/nerdcommenter" },

        -- hex colorizer
        { "norcalli/nvim-colorizer.lua" },

        -- telescope 🔭
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-telescope/telescope-fzy-native.nvim",
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim"
            }
        },

        -- file icons
        { 'kyazdani42/nvim-web-devicons' },

        -- file explorer
        {
            'kyazdani42/nvim-tree.lua',
        },

        -- indent line
        { "lukas-reineke/indent-blankline.nvim" },

        -- language snippets
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
        },
        { "rafamadriz/friendly-snippets" },
        { 'saadparwaiz1/cmp_luasnip' },

        -- treesiter
        { "nvim-treesitter/nvim-treesitter" },

        -- lsp and completion
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/nvim-cmp' },
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "ray-x/lsp_signature.nvim" },
        {
            "aznhe21/actions-preview.nvim",
        },

        -- themes
        { "glepnir/zephyr-nvim" },
        { 'Mofiqul/vscode.nvim' },

        -- git
        {
            "lewis6991/gitsigns.nvim",
            dependencies = { "nvim-lua/plenary.nvim" }
        },

        -- debugging
        { 'mfussenegger/nvim-dap' },
        { "rcarriga/nvim-dap-ui",           dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
        { 'theHamsta/nvim-dap-virtual-text' },
        { 'leoluz/nvim-dap-go' },


        -- marks
        { "chentoast/marks.nvim" },

        --terminal
        { "4strodev/termtracker.nvim" },
    },
    defaults = {
        lazy = false,
        version = false,
    },
    checker = {
        enabled = true,
        notify = false,
    },
})
