-- escape file
vim.fn.setreg("e",
    ":enew\npggdd:silent! %s/\\\\/\\\\\\\\/g\n:silent! %s/\\\"/\\\\\"/g\n:silent! %s/\\n/\\\\n/g\n:silent! %s/\\t/\\\\t/g\ngg0y$:bdel! | bp\n:noh\n")

-- copy cursor location
-- Global command example
vim.api.nvim_create_user_command("CpLctn", function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local path = vim.fn.expand("%")
    local pointer = string.format("%s:%d:%d", path, line, col)
    vim.fn.setreg("+", pointer)
end, {
    desc = "Copy cursor location (filepath:line:column)"
})
