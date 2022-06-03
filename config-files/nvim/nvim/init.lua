local themeLoader = require("lib.themeLoader"):new()
ConfigPath = vim.fn.stdpath("config")

-- Setting colors
vim.o.termguicolors = true
vim.o.background = "dark"

require("config.settings")
require("config.keymaps")
require("plugins.plugins-install")
require("plugins.plugins-config")

themeLoader.filePath = os.getenv("HOME") .. "/.themes.json"

themeLoader:loadFile()

themeLoader:secureSetFileThemes()
