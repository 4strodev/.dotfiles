local json = require("lib.json")
ConfigPath = vim.fn.stdpath("config")

-- Setting colors
vim.o.background = "dark"
vim.o.termguicolors = true

-- load theme from json file
local theme = json.loadTheme()

require("defaults.settings")
require("defaults.keymaps")
require("plugins.plugins-install")
require("plugins.plugins-config")
require(theme or "zephyr")
