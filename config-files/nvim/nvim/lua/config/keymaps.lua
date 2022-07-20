local ConfigPath = vim.fn.stdpath("config")
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
    keymap("n", "<up>", "<cmd>resize +5<cr>", nores)
    keymap("n", "<down>", "<cmd>resize -5<cr>", nores)
    keymap("n", "<left>", "<cmd>vertical resize -5<cr>", nores)
    keymap("n", "<right>", "<cmd>vertical resize +5<cr>", nores)

    -- save and close file
    keymap("n", "<leader>wf", "<cmd>w<cr>", nore)
    keymap("n", "<leader>qf", "<cmd>bd!<cr>", nore)

    -- open terminal
    keymap("v", "<leader>t", "<cmd>split<CR><cmd>ter<CR><cmd>resize 15<CR>", nore)
    keymap("n", "<leader>t", "<cmd>split<CR><cmd>ter<CR><cmd>resize 15<CR>", nore)

    -- move between buffers
    keymap("n", "<Tab>", "<cmd>bnext<cr>", nores)
    keymap("n", "<S-Tab>", "<cmd>bprevious<cr>", nores)

    -- splits
    keymap("n", "<leader>vs", "<cmd>vsplit<cr>", nores)
    keymap("n", "<leader>sp", "<cmd>split<cr>", nores)

    -- open explorer
    keymap("n", "<leader>ef", "<cmd>NvimTreeToggle<cr><cmd>NvimTreeResize 50<cr>", nores)

    -- restart neovim
    keymap("n", "<F5>", "<cmd>luafile " .. ConfigPath .. "/init.lua<cr>", nores)
end)()
