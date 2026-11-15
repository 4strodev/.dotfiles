return (function()
    vim.g.mapleader = " "

    --disable arrow keys
    vim.keymap.set("n", "<up>", "nop", { noremap = true, silent = true })
    vim.keymap.set("n", "<down>", "nop", { noremap = true, silent = true })
    vim.keymap.set("n", "<left>", "nop", { noremap = true, silent = true })
    vim.keymap.set("n", "<right>", "nop", { noremap = true, silent = true })

    -- resize splits with arrow keys
    vim.keymap.set("n", "<up>", "<cmd>resize +5<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<down>", "<cmd>resize -5<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<left>", "<cmd>vertical resize -5<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<right>", "<cmd>vertical resize +5<cr>", { noremap = true, silent = true })

    -- save and close file
    vim.keymap.set("n", "<leader>wf", "<cmd>w<cr>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>qf", "<cmd>bd!<cr>", { noremap = true, silent = false })

    -- open terminal
    vim.keymap.set("v", "<leader>j", "<cmd>TermToggle<cr>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>j", "<cmd>TermToggle<cr>", { noremap = true, silent = false })

    -- move between buffers
    vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { noremap = true, silent = true })
    vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { noremap = true, silent = true })

    -- horizontal scroll
    vim.keymap.set("n", "<M-ScrollWheelUp>", "3zl", { noremap = true, silent = true })
    vim.keymap.set("v", "<M-ScrollWheelUp>", "3zl", { noremap = true, silent = true })
    vim.keymap.set("n", "<M-ScrollWheelDown>", "3zh", { noremap = true, silent = true })
    vim.keymap.set("v", "<M-ScrollWheelDown>", "3zh", { noremap = true, silent = true })

    vim.keymap.set("v", "<M-h>", "3zh", { noremap = true, silent = true })
    vim.keymap.set("v", "<M-l>", "3zl", { noremap = true, silent = true })
    vim.keymap.set("n", "<M-h>", "3zh", { noremap = true, silent = true })
    vim.keymap.set("n", "<M-l>", "3zl", { noremap = true, silent = true })

    vim.keymap.set({ "n", "i" }, "]$", "/\\$<CR>",
        { noremap = true, silent = true, desc = "Jump to next $ symbol" })
    vim.keymap.set({ "n", "i" }, "[$", "?\\$<CR>", {
        noremap = true,
        silent = true,
        desc = "Jump to previous $ symbol"
    })
end)()
