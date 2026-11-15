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
            event = "VeryLazy",
            config = function()
                require('plugins.settings.lualine')
            end,
        },
        {
            "akinsho/nvim-bufferline.lua",
            event = "VeryLazy",
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
        { "preservim/nerdcommenter", event = "VeryLazy" },

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
            cmd = "Telescope",
            keys = {
                "<leader>tt", "<leader>tp", "<leader>tr", "<leader>tR",
                "<leader>tf", "<leader>tq", "<leader>ed",
            },
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
            lazy = false,
            config = function()
                require('plugins.settings.nvim-web-devicons')
            end,
        },

        -- file explorer
        {
            'kyazdani42/nvim-tree.lua',
            cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeFindFileToggle" },
            keys = { "<leader>ef" },
            init = function()
                -- `nvim <dir>`: load the tree so it can take over the directory buffer
                if vim.fn.argc(-1) == 1 then
                    local stat = vim.uv.fs_stat(vim.fn.argv(0))
                    if stat and stat.type == "directory" then
                        require("nvim-tree")
                    end
                end
            end,
            config = function()
                require('plugins.settings.nvimtree')
            end,
        },
        -- outline structure
        {
            "hedyhli/outline.nvim",
            cmd = { "Outline", "OutlineOpen" },
        },

        -- indent line
        { "lukas-reineke/indent-blankline.nvim", event = { "BufReadPost", "BufNewFile" } },

        -- language snippets
        {
            "L3MON4D3/LuaSnip",
            event = "InsertEnter",
            version = "v2.*",
            dependencies = {
                { "rafamadriz/friendly-snippets", dir = "/home/astro/Dev/friendly-snippets" },
            },
            build = "make install_jsregexp",
            config = function()
                require('plugins.settings.luasnip')
            end,
        },

        -- treesiter
        {
            "romus204/tree-sitter-manager.nvim",
            lazy = false,
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
        {
            'hrsh7th/nvim-cmp',
            event = { "InsertEnter", "CmdlineEnter" },
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
            event = { "BufReadPre", "BufNewFile" },
            cmd = {
                "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog",
                "LspInfo", "LspLog", "LspRestart", "LspStart", "LspStop",
            },
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
        {
            'nvimdev/lspsaga.nvim',
            event = "LspAttach",
            cmd = "Lspsaga",
            config = function()
                require('plugins.settings.lspsaga')
            end,
            dependencies = {
                'nvim-tree/nvim-web-devicons', -- optional
            }
        },
        {
            "allaman/emoji.nvim",
            event = "InsertEnter",
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
        { "f-person/auto-dark-mode.nvim", lazy = false, opts = {} },

        -- git
        {
            "lewis6991/gitsigns.nvim",
            event = { "BufReadPre", "BufNewFile" },
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                require('plugins.settings.gitsigns')
            end,
        },

        -- debugging
        {
            'mfussenegger/nvim-dap',
            keys = {
                "<F5>", "<F3>", "<F2>", "<F12>",
                "<leader>b", "<leader>B", "<leader>lp", "<leader>dr", "<leader>du",
            },
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
            event = { "BufReadPost", "BufNewFile" },
            config = function()
                require('plugins.settings.marks')
            end,
        },

        --terminal
        {
            "4strodev/termtracker.nvim",
            -- tracks terminals through the TermOpen autocmd, so load on that event
            event = "TermOpen",
            cmd = { "TermList", "TermOpen", "TermToggle" },
            config = function()
                require('plugins.settings.termtracker')
            end,
        },
        {
            'MeanderingProgrammer/render-markdown.nvim',
            ft = "markdown",
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
        lazy = true,
        version = false,
    },
    checker = {
        enabled = true,
        notify = false,
    },
})
