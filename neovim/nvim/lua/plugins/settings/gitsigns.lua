local M = {}

function M.setup()
    local gitsigns = require("gitsigns")
    local ctx = require('config.keymaps').new()
    M.keymaps = ctx

    -- Navigation
    ctx:buffer_map('n', ']c', function()
        if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
        else
            gitsigns.nav_hunk('next')
        end
    end)

    ctx:buffer_map('n', '[c', function()
        if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
        else
            gitsigns.nav_hunk('prev')
        end
    end)

    -- Actions
    ctx:buffer_map('n', '<leader>hs', gitsigns.stage_hunk)
    ctx:buffer_map('n', '<leader>hr', gitsigns.reset_hunk)

    ctx:buffer_map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    ctx:buffer_map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    ctx:buffer_map('n', '<leader>hS', gitsigns.stage_buffer)
    ctx:buffer_map('n', '<leader>hR', gitsigns.reset_buffer)
    ctx:buffer_map('n', '<leader>hp', gitsigns.preview_hunk)
    ctx:buffer_map('n', '<leader>hi', gitsigns.preview_hunk_inline)

    ctx:buffer_map('n', '<leader>hb', function()
        gitsigns.blame_line({ full = true })
    end)

    ctx:buffer_map('n', '<leader>hd', gitsigns.diffthis)

    ctx:buffer_map('n', '<leader>hD', function()
        gitsigns.diffthis('~')
    end)

    ctx:buffer_map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    ctx:buffer_map('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    ctx:buffer_map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    ctx:buffer_map('n', '<leader>tw', gitsigns.toggle_word_diff)

    -- Text object
    ctx:buffer_map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)

    gitsigns.setup {
        signs                        = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged                 = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged_enable          = true,
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
            follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        on_attach                    = function(bufnr)
            ctx:apply_buffer(bufnr)
        end
    }
end

return M
