require('test')

vim.cmd 'echo variable'

vim.o.relativenumber = true
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.sw = 4

vim.g.mapleader = ' '
vim.cmd 'colorscheme evening'

local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>qq', ':bdelete<CR>', opts)
vim.api.nvim_set_keymap('n','<leader>e',':e $MYVIMRC<CR>', opts)
