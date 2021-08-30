ConfigPath = vim.fn.stdpath("config")

require("defaults.settings")
require("defaults.keymaps")
require("plugins.plugins-install")
require("plugins.plugins-config")
require("themes.gruvbox")

vim.o.background = "dark"
vim.o.termguicolors = true
