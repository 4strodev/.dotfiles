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
vim.o.colorcolumn = "100"
vim.cmd("highlight ColoColumn ctermbg=0 guibg=lightgrey")

vim.o.splitbelow = true
vim.o.splitright = true

vim.opt.foldcolumn = '1'
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldtext = ''
vim.opt.foldenable = true

vim.o.spell = true
vim.o.spelllang = "en_us"
-- Create autocmd to disable spellcheck for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.opt_local.spell = false
    end,
})

-- Allow per local project config file
vim.o.exrc = true   -- Enable local config files
vim.o.secure = true -- Restrict what they can do (recommended)

vim.o.winborder = 'single'

vim.opt.list = true
vim.opt.listchars = {
  space = "·",
  trail = "·",
  nbsp = "·",
  tab = "→ ",
  extends = "⟩",
  precedes = "⟨"
}
