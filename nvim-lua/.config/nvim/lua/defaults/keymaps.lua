local keymap = vim.api.nvim_set_keymap
local nores = {noremap = true, silent = true}
local nore = {noremap = true, silent = false}

return (function()
    vim.g.mapleader = " "

    --disable arrow keys
    keymap("n", "<up>", "nop", nores)
    keymap("n", "<down>", "nop", nores)
    keymap("n", "<left>", "nop", nores)
    keymap("n", "<right>", "nop", nores)

    -- resize splits with arrow keys
    keymap("n", "<up>", "resize +5<cr>", nores)
    keymap("n", "<down>", "resize -5<cr>", nores)
    keymap("n", "<left>", ":vertical resize -5<cr>", nores)
    keymap("n", "<right>", ":vertical resize +5<cr>", nores)

    -- save and close file
    keymap("n", "<leader>wf", ":w<cr>", nore)
    keymap("n", "<leader>qf", ":bd<cr>", nore)

    -- open terminal
    keymap("v", "<leader>t", ":split<CR>:ter<CR>:resize 15<CR>", nore)
    keymap("n", "<leader>t", ":split<CR>:ter<CR>:resize 15<CR>", nore)

    -- move between buffers
    keymap("n", "<Tab>", ":bnext<cr>", nores)
    keymap("n", "<M-Tab>", ":bprevious<cr>", nores)

    -- splits
    keymap("n", "<leader>vs", ":vscp<cr>", nores)
    keymap("n", "<leader>sp", ":vscp<cr>", nores)

    -- open explorer
    keymap("n", "<leader>ef", ":Lexplore<cr>", nores)

    -- no highlight matched patterns
    keymap("n", "//", ":noh<cr>", nores)
end)()
