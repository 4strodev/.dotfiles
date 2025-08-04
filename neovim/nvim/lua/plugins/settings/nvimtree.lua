local keymap = vim.api.nvim_set_keymap
local nores = { noremap = true, silent = true }

-- open explorer
keymap("n", "<leader>ef", "<cmd>NvimTreeToggle<cr><cmd>NvimTreeResize 50<cr>", nores)

require("nvim-tree").setup({
    view = {
        width = 30,
        side = "right"
    },
    renderer = {
        group_empty = true,
    }
})
