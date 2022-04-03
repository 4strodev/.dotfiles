local telescope_module = {}
local keymap = vim.api.nvim_set_keymap
local nores = {noremap = true, silent = true}
--local nore = {noremap = true, silent = false}

local actions = require("telescope.actions")

telescope_module.setup = function()
    require("telescope").setup {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case"
            },
            prompt_prefix = " ~ ",
            selection_caret = " ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    mirror = false
                },
                vertical = {
                    mirror = false
                }
            },
            file_sorter = require "telescope.sorters".get_fuzzy_file,
            file_ignore_patterns = {},
            generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
            winblend = 0,
            border = {},
            borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
            color_devicons = true,
            use_less = true,
            path_display = {},
            set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
            file_previewer = require "telescope.previewers".vim_buffer_cat.new,
            grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
            qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker,
            mappings = {
                i = {
                    ["<C-q>"] = actions.send_to_qflist
                }
            }
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true
            }
        }
    }

    telescope_module.load_extensions()
    telescope_module.load_keymaps()
end

-- search neovim dotfiles
telescope_module.search_dotfiles = function()
    require("telescope.builtin").find_files(
        {
            prompt_title = "<neovim dotfiles>",
            cwd = "~/.config/nvim"
        }
    )
end

telescope_module.load_extensions = function()
    -- seting up telescope extensions
    require("telescope").load_extension("fzy_native")
end

telescope_module.load_keymaps = function()
    -- basic keymaps
    keymap("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>', nores)
    keymap("n", "<leader>fl", '<cmd>lua require("telescope.builtin").live_grep()<cr>', nores)
    keymap("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<cr>', nores)
    keymap("n", "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<cr>', nores)

    -- git
    keymap("n", "<leader>fgf", '<cmd>lua require("telescope.builtin").git_files()<cr>', nores)
    keymap("n", "<leader>fgb", '<cmd>lua require("telescope.builtin").git_branches()<cr>', nores)

    -- cutsom functions
    keymap("n", "<leader>ed", '<cmd>lua require("plug-settings.telescope").search_dotfiles()<cr>', nores)
end

return telescope_module
