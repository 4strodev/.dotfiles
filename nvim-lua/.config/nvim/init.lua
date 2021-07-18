vim.o.relativenumber = true
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.sw = 2

vim.g.mapleader = ' '
vim.g.colorscheme = 'desert'

local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>qq', ':bdelete<CR>', opts)
