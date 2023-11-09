local keymap = vim.api.nvim_set_keymap
local nores = { noremap = true, silent = true }

local nvimtree_module = {}

nvimtree_module.setup = function()

    -- open explorer
    keymap("n", "<leader>ef", "<cmd>NvimTreeToggle<cr><cmd>NvimTreeResize 50<cr>", nores)

    require("nvim-tree").setup()
end

return nvimtree_module
