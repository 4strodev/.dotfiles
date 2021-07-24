ConfigPath = vim.fn.stdpath('config')

require('general.settings')
require('general.keymaps')
require('plugins.plugins-install')
require('plugins.plugins-config')
require('themes.ayu')

vim.o.background = "dark"
vim.o.termguicolors = true
