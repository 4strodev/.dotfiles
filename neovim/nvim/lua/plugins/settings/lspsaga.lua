-- Close every saga floating window with <Esc>, keeping the plugin defaults as
-- alternatives. Each `quit` entry is a list so both keys stay usable.
-- Open or jump to an entry with <CR> instead of the default 'o'.
require('lspsaga').setup({
    lightbulb = {
        sign = false
    },
    diagnostic = {
        keys = {
            quit = { 'q', '<Esc>' },
            quit_in_show = { 'q', '<Esc>' },
        }
    },
    code_action = {
        keys = {
            quit = { 'q', '<Esc>' },
        }
    },
    finder = {
        keys = {
            toggle_or_open = '<CR>',
            quit = { 'q', '<Esc>' },
        }
    },
    definition = {
        keys = {
            -- `close` already shuts every peek window down
            close = '<Esc>',
        }
    },
    rename = {
        -- NOTE: this also applies in insert mode, so <Esc> closes the rename
        -- box instead of going back to normal mode. Drop '<Esc>' here if you
        -- prefer editing the new name with normal mode motions.
        keys = {
            quit = { '<C-k>', '<Esc>' },
        }
    },
    outline = {
        keys = {
            toggle_or_jump = '<CR>',
            quit = { 'q', '<Esc>' },
        }
    },
    callhierarchy = {
        keys = {
            quit = { 'q', '<Esc>' },
        }
    },
    typehierarchy = {
        keys = {
            quit = { 'q', '<Esc>' },
        }
    },
})

-- The hover window hardcodes 'q' as its close key, so it cannot be configured
-- through setup(). Detect the hover buffer once it is displayed and add <Esc>.
local hover_group = vim.api.nvim_create_augroup('LspsagaHoverEscape', { clear = true })

vim.api.nvim_create_autocmd('BufWinEnter', {
    group = hover_group,
    callback = function(args)
        -- winhl is only applied after the window is created, so defer the check
        vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(args.buf) then
                return
            end

            for _, winid in ipairs(vim.fn.win_findbuf(args.buf)) do
                local is_float = vim.api.nvim_win_get_config(winid).relative ~= ''
                local winhl = vim.wo[winid].winhighlight

                if is_float and winhl:find('HoverNormal') then
                    vim.keymap.set('n', '<Esc>', function()
                        if vim.api.nvim_win_is_valid(winid) then
                            vim.api.nvim_win_close(winid, true)
                        end
                    end, { buffer = args.buf, nowait = true, silent = true })
                    return
                end
            end
        end)
    end,
})

vim.keymap.set('n', '<leader>ac', '<cmd>Lspsaga code_action<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>K', '<cmd>Lspsaga hover_doc<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>et', '<cmd>Lspsaga outline<CR>', { noremap = true, silent = true })
