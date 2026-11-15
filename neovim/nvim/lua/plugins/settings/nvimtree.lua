local M = {}

local ctx = require('config.keymaps').new()
M.keymaps = ctx

local nores = { noremap = true, silent = true }

-- open explorer
ctx:map("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<cr>", nores)

function M.setup()
    require("nvim-tree").setup({
        view = {
            width = 50,
            side = "right"
        },
        renderer = {
            group_empty = false,
        }
    })

    ctx:apply()
end

return M
