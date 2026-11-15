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
        {
            "hoob3rt/lualine.nvim",
            config = function()
                require('plugins.settings.lualine')
            end,
        },
        {
            "akinsho/nvim-bufferline.lua",
            config = function()
                require('plugins.settings.bufferline')
            end,
        },

        -- autopairs
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function()
                require('plugins.settings.autopairs')
            end,
        },

        -- commenter
        { "preservim/nerdcommenter" },

        -- hex colorizer
        {
            "catgoose/nvim-colorizer.lua",
            event = "BufReadPre",
            config = function()
                require('plugins.settings.colorizer')
            end,
        },

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
            },
            config = function()
                require('plugins.settings.telescope')
            end,
        },

        -- file icons
        {
            'nvim-tree/nvim-web-devicons',
            config = function()
                require('plugins.settings.nvim-web-devicons')
            end,
        },

        -- file explorer
        {
            'kyazdani42/nvim-tree.lua',
            config = function()
                require('plugins.settings.nvimtree')
            end,
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
            config = function()
                require('plugins.settings.luasnip')
            end,
        },
        { "rafamadriz/friendly-snippets", dir = "/home/astro/Dev/friendly-snippets" },
        { 'saadparwaiz1/cmp_luasnip' },

        -- treesiter
        {
            "romus204/tree-sitter-manager.nvim",
            dependencies = {}, -- tree-sitter CLI must be installed system-wide
            config = function()
                require("tree-sitter-manager").setup({
                    -- Default Options
                    -- ensure_installed = {}, -- list of parsers to install at the start of a neovim session. If set to "all", install all parsers.
                    -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
                    -- auto_install = false, -- if enabled, install missing parsers when editing a new file
                    -- highlight = true, -- treesitter highlighting is enabled by default
                    -- languages = {}, -- override or add new parser sources
                })
                require('plugins.settings.treesitter')
            end
        },

        -- lsp and completion
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'max397574/cmp-greek' },
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'max397574/cmp-greek',
                'saadparwaiz1/cmp_luasnip',
                'L3MON4D3/LuaSnip',
            },
            config = function()
                require('plugins.settings.cmp')
            end,
        },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "ray-x/lsp_signature.nvim",
                "iamkarasik/sonarqube.nvim",
            },
            config = function()
                require('plugins.settings.lspconfig')
            end,
        },
        { "ray-x/lsp_signature.nvim",         event = "InsertEnter" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        {
            'nvimdev/lspsaga.nvim',
            config = function()
                require('plugins.settings.lspsaga')
            end,
            dependencies = {
                'nvim-tree/nvim-web-devicons', -- optional
            }
        },
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
            config = function()
                require('plugins.settings.emoji')
            end,
        },

        -- themes
        { "Mofiqul/vscode.nvim" },
        { "miikanissi/modus-themes.nvim", priority = 1000, lazy = false },
        { "f-person/auto-dark-mode.nvim", opts = {} },

        -- git
        {
            "lewis6991/gitsigns.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                require('plugins.settings.gitsigns')
            end,
        },

        -- debugging
        {
            'mfussenegger/nvim-dap',
            dependencies = {
                'theHamsta/nvim-dap-virtual-text',
                "rcarriga/nvim-dap-ui",
                "nvim-neotest/nvim-nio",
                'leoluz/nvim-dap-go',
            },
            config = function()
                require('plugins.settings.nvim-dap')
            end,
        },


        -- marks
        {
            "chentoast/marks.nvim",
            config = function()
                require('plugins.settings.marks')
            end,
        },

        --terminal
        {
            "4strodev/termtracker.nvim",
            config = function()
                require('plugins.settings.termtracker')
            end,
        },
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
