local json = require("lib.json")
ConfigPath = vim.fn.stdpath("config")

-- Setting colors
vim.o.termguicolors = true
vim.o.background = "dark"

-- refactor `defaults` folder to `config`
require("defaults.settings")
require("defaults.keymaps")
require("plugins.plugins-install")
require("plugins.plugins-config")

--load theme from json file
local defaultTheme = "zephyr" -- this theme will be loaded in case that user don't specify anyone
local defaultThemeVariant = "" -- This variant will be loaded with defaultTheme
local themes = json.Parser("/home/astro/.themes.json") -- TODO save this data into a variable or config file

if themes ~= vim.NIL then
    require("themes." .. (themes.editor or defaultTheme)).SetUp(themes.variant or defaultThemeVariant)
else
    print("No themes file founded")
    print("Loading default theme")
    require("themes." .. defaultTheme).SetUp(defaultThemeVariant)
end
