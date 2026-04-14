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
                "nvim-lua/plenary.nvim",
                {
                    "nvim-telescope/telescope-live-grep-args.nvim",
                    -- This will not install any breaking changes.
                    -- For major updates, this must be adjusted manually.
                    version = "^1.0.0",
                },
            }
        },

        -- file icons
        { 'kyazdani42/nvim-web-devicons' },

        -- file explorer
        {
            'kyazdani42/nvim-tree.lua',
        },
        -- outline structure
        {
            "hedyhli/outline.nvim",
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
        { "nvim-treesitter/nvim-treesitter",  branch = "main", lazy = false, build = ":TSUpdate" },

        -- lsp and completion
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'max397574/cmp-greek' },
        { 'hrsh7th/nvim-cmp' },
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "ray-x/lsp_signature.nvim" },
        { "aznhe21/actions-preview.nvim" },
        { "iamkarasik/sonarqube.nvim" },
        {
            "allaman/emoji.nvim",
            version = "1.0.0", -- optionally pin to a tag
            dependencies = {
                -- util for handling paths
                "nvim-lua/plenary.nvim",
                -- optional for nvim-cmp integration
                "hrsh7th/nvim-cmp",
                -- optional for telescope integration
                "nvim-telescope/telescope.nvim",
                -- optional for fzf-lua integration via vim.ui.select
                "ibhagwan/fzf-lua",
            },
        },

        -- themes
        { "Mofiqul/vscode.nvim" },
        { "miikanissi/modus-themes.nvim", priority = 1000, lazy = false },
        { "f-person/auto-dark-mode.nvim", opts = {} },

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
        {
            'MeanderingProgrammer/render-markdown.nvim',
            after = { 'nvim-treesitter' },
            requires = { 'nvim-mini/mini.nvim', opt = true }, -- if you use the mini.nvim suite
            -- requires = { 'nvim-mini/mini.icons', opt = true },        -- if you use standalone mini plugins
            -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
            config = function()
                require('render-markdown').setup({})
            end,
        }
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
