local telescope_module = {}
local nores = { noremap = true, silent = true }
--local nore = {noremap = true, silent = false}

local ctx = require('config.keymaps').new()
telescope_module.keymaps = ctx

-- basic keymaps
ctx:map("n", "<leader>tt", '<cmd>Telescope<cr>', nores)
ctx:map("n", "<leader>tp", '<cmd>Telescope find_files<cr>', nores)
ctx:map("n", "<leader>tr", '<cmd>Telescope lsp_references<cr>', nores)
ctx:map("n", "<leader>tR", '<cmd>Telescope resume<cr>', nores)
ctx:map("n", "<leader>tf", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", nores)
ctx:map("n", "<leader>tq", "<cmd>Telescope quickfix<cr>", nores)

-- cutsom functions
ctx:map("n", "<leader>ed", '<cmd>lua require("plugins.settings.telescope").search_dotfiles()<cr>', nores)

local select_one_or_multi = function(prompt_bufnr)
    local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()
    if not vim.tbl_isempty(multi) then
        require('telescope.actions').close(prompt_bufnr)
        for _, j in pairs(multi) do
            if j.path ~= nil then
                vim.cmd(string.format('%s %s', 'edit', j.path))
            end
        end
    else
        require('telescope.actions').select_default(prompt_bufnr)
    end
end

telescope_module.setup = function()
    local actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")

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
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            use_less = true,
            path_display = {},
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = require "telescope.previewers".vim_buffer_cat.new,
            grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
            qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker,
            mappings = {
                i = {
                    ["<C-q>"] = actions.send_to_qflist,
                    ["<C-h>"] = "which_key",
                    ["<CR>"] = select_one_or_multi
                },
                n = {
                    ["<CR>"] = select_one_or_multi
                }
            }
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true
            },
            live_grep_args = {
                auto_quoting = true, -- enable/disable auto-quoting
                -- define mappings, e.g.
                mappings = {         -- extend mappings
                    i = {
                        ["<C-k>"] = lga_actions.quote_prompt(),
                        ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                        -- freeze the current list and start a fuzzy search in the frozen list
                        ["<C-space>"] = lga_actions.to_fuzzy_refine,
                    },
                },
                -- ... also accepts theme settings, for example:
                -- theme = "dropdown", -- use dropdown theme
                -- theme = { }, -- use own theme spec
                -- layout_config = { mirror=true }, -- mirror preview pane
            }
        },
        pickers = {
            colorscheme = {
                enable_preview = true
            }
        }
    }

    telescope_module.load_extensions()
    ctx:apply()
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
    require("telescope").load_extension("live_grep_args")
end

return telescope_module
