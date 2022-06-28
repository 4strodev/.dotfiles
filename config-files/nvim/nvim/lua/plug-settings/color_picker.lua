local module = {}

module.setup = function()
    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<C-c>", "<cmd>PickColor<cr>", opts)
    vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

    -- only need setup() if you want to change progress bar icons
    require("color-picker").setup({
        -- ["icons"] = { "ﱢ", "" },
        -- ["icons"] = { "ﮊ", "" },
        -- ["icons"] = { "", "ﰕ" },
        ["icons"] = { "ﱢ", "" },
        -- ["icons"] = { "", "" },
        -- ["icons"] = { "", "" },
    })

    vim.cmd([[hi FloatBorder guibg=NONE]])
end

return module
