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

-- Builds the lazy.nvim fields (`config`, optionally `keys`) of a plugin from its
-- settings module. Key stubs are derived from the module's recorded keymaps, so
-- the module must not load the plugin until `setup` runs.
local function settings(name, with_keys)
    local spec = { config = function() require('plugins.settings.' .. name).setup() end }
    if with_keys then
        spec.keys = require('plugins.settings.' .. name).keymaps:triggers()
    end
    return spec
end

require("lazy").setup({
    spec = {
        -- lualine and bufferline
        vim.tbl_extend("force", {
            "hoob3rt/lualine.nvim",
            event = "VeryLazy",
        }, settings("lualine")),
        vim.tbl_extend("force", {
            "akinsho/nvim-bufferline.lua",
            event = "VeryLazy",
        }, settings("bufferline")),

        -- autopairs
        vim.tbl_extend("force", {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
        }, settings("autopairs")),

        -- commenter
        { "preservim/nerdcommenter", event = "VeryLazy" },

        -- hex colorizer
        vim.tbl_extend("force", {
            "catgoose/nvim-colorizer.lua",
            event = "BufReadPre",
        }, settings("colorizer")),

        -- telescope 🔭
        vim.tbl_extend("force", {
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
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
        }, settings("telescope", true)),

        -- file icons
        vim.tbl_extend("force", {
            'nvim-tree/nvim-web-devicons',
            lazy = false,
        }, settings("nvim-web-devicons")),

        -- file explorer
        vim.tbl_extend("force", {
            'kyazdani42/nvim-tree.lua',
            cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeFindFileToggle" },
            init = function()
                -- `nvim <dir>`: load the tree so it can take over the directory buffer
                if vim.fn.argc(-1) == 1 then
                    local stat = vim.uv.fs_stat(vim.fn.argv(0))
                    if stat and stat.type == "directory" then
                        require("nvim-tree")
                    end
                end
            end,
        }, settings("nvimtree", true)),
        -- outline structure
        {
            "hedyhli/outline.nvim",
            cmd = { "Outline", "OutlineOpen" },
        },

        -- indent line
        { "lukas-reineke/indent-blankline.nvim", event = { "BufReadPost", "BufNewFile" } },

        -- language snippets
        vim.tbl_extend("force", {
            "L3MON4D3/LuaSnip",
            event = "InsertEnter",
            version = "v2.*",
            dependencies = {
                { "rafamadriz/friendly-snippets", dir = "/home/astro/Dev/friendly-snippets" },
            },
            build = "make install_jsregexp",
        }, settings("luasnip")),

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
                require('plugins.settings.treesitter').setup()
            end
        },

        -- lsp and completion
        vim.tbl_extend("force", {
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
        }, settings("cmp")),
        vim.tbl_extend("force", {
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
        }, settings("lspconfig")),
        vim.tbl_extend("force", {
            'nvimdev/lspsaga.nvim',
            event = "LspAttach",
            cmd = "Lspsaga",
            dependencies = {
                'nvim-tree/nvim-web-devicons', -- optional
            }
        }, settings("lspsaga")),
        vim.tbl_extend("force", {
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
        }, settings("emoji")),

        -- themes
        { "f-person/auto-dark-mode.nvim", lazy = false, opts = {} },

        -- git
        vim.tbl_extend("force", {
            "lewis6991/gitsigns.nvim",
            event = { "BufReadPre", "BufNewFile" },
            dependencies = { "nvim-lua/plenary.nvim" },
        }, settings("gitsigns")),

        -- debugging
        vim.tbl_extend("force", {
            'mfussenegger/nvim-dap',
            dependencies = {
                'theHamsta/nvim-dap-virtual-text',
                "rcarriga/nvim-dap-ui",
                "nvim-neotest/nvim-nio",
                'leoluz/nvim-dap-go',
            },
        }, settings("nvim-dap", true)),


        -- marks
        vim.tbl_extend("force", {
            "chentoast/marks.nvim",
            event = { "BufReadPost", "BufNewFile" },
        }, settings("marks")),

        --terminal
        vim.tbl_extend("force", {
            "4strodev/termtracker.nvim",
            -- tracks terminals through the TermOpen autocmd, so load on that event
            event = "TermOpen",
            cmd = { "TermList", "TermOpen", "TermToggle" },
        }, settings("termtracker")),
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
