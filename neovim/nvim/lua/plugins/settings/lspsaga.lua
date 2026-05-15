require('lspsaga').setup({
    lightbulb = {
        sign = false
    }
})

vim.keymap.set('n', '<leader>ac', '<cmd>Lspsaga code_action<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>K', '<cmd>Lspsaga hover_doc<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>et', '<cmd>Lspsaga outline<CR>', { noremap = true, silent = true })
