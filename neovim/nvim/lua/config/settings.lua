local configPath = vim.fn.stdpath("config")

-- Setting up the general settings
vim.o.encoding = "utf8"
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"

-- Tab settings
vim.o.sw = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Line numbers
vim.o.number = true
vim.o.rnu = true
vim.o.nuw = 1

-- No wrap text
vim.o.wrap = false

-- No swap file
vim.o.swapfile = false
vim.o.backup = false

-- Persistent undo
vim.o.undodir = configPath .. "/.undodir"
vim.o.undofile = true


vim.o.ignorecase = true
vim.o.incsearch = true

vim.o.cursorline = true
vim.o.colorcolumn = "120"
vim.cmd("highlight ColoColumn ctermbg=0 guibg=lightgrey")

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.foldcolumn = '1'
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.foldnestmax = 4
vim.o.foldtext = ''
