ConfigPath = vim.fn.stdpath("config")

vim.o.background = "dark"
vim.o.termguicolors = true

require("defaults.settings")
require("defaults.keymaps")
require("plugins.plugins-install")
require("plugins.plugins-config")
require("themes.gruvbox")
