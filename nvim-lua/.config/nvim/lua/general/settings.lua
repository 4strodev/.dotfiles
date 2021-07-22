-- Setting up the general settings
return (function()
    vim.o.encoding = 'utf8'
    vim.o.mouse = 'a'
    vim.o.clipboard = "unnamedplus"

    vim.o.ts = 4
    vim.o.expandtab = true
    vim.o.smartindent = true

    vim.o.rnu = true
    vim.o.nuw = 1

    vim.o.wrap = false

    vim.o.swapfile = false
    vim.o.backup = false
    vim.o.undodir = ConfigPath .. '/.undodir'
    vim.o.undofile = true

    vim.o.ignorecase = true
    vim.o.incsearch = true

    vim.o.cursorline = true
    vim.o.colorcolumn = '120'
    vim.cmd('highlight ColoColumn ctermbg=0 guibg=lightgrey')

    vim.o.splitbelow = true
    vim.o.splitright = true
end)()
