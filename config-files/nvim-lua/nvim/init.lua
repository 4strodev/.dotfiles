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

-- load theme from json file
local defaultTheme = "zephyr" -- this theme will be loaded in case that user don't specify anyone
local defaultThemeVariant = "" -- This variant will be loaded with defaultTheme
local themes = json.Parser("/home/astro/.themes.json") -- TODO save this data into a variable or config file

-- custom functions
local function loadDefaultTheme()
    print("No themes file founded")
    print("Loading default theme")
    vim.cmd("colorscheme " .. defaultTheme)
end

local function loadTheme(theme, variant)
    return require("themes." .. theme).SetUp(variant)
end

-- TODO: finish this shit <31-10-21, astro>

if themes == vim.NIL then
    loadDefaultTheme()
elseif not pcall(loadTheme, themes.editor, themes.variant) then
    if not pcall(vim.cmd, "colorscheme " .. themes.editor) then
        loadDefaultTheme()
    end
end
