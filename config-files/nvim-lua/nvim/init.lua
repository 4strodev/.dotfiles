local themeLoader = require("lib.themeLoader"):new()
ConfigPath = vim.fn.stdpath("config")

-- Setting colors
vim.o.termguicolors = true
vim.o.background = "dark"
-- refactor `defaults` folder to `config`
require("defaults.settings")
require("defaults.keymaps")
require("plugins.plugins-install")
require("plugins.plugins-config")

themeLoader.filePath = "/home/astro/.themes.json"

themeLoader:loadFile()

themeLoader:secureSetFileThemes()
