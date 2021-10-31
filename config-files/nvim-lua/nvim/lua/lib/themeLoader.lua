local json = require("lib.json")

local themeLoader = {
    filePath = nil,
    config = {}
}

-- load theme from json file
--local themes = json.Parser("/home/astro/.themes.json") -- TODO save this data into a variable or config file

function themeLoader:new()
    return setmetatable(themeLoader, {__index = self})
end

function themeLoader:loadFile()
    self.config = json.Parser(self.filePath)
end

-- custom functions
function themeLoader:setDefaultTheme(initialMessage)
    print(initialMessage)
    print("Setting default theme")
    vim.cmd("colorscheme default")
end

function themeLoader:setTheme(theme, variant)
    require("themes." .. theme).SetUp(variant)
end

function themeLoader:secureSetFileThemes()
    if self.config == vim.NIL then
        self:setDefaultTheme("No themes file found")
    elseif not pcall(self.setTheme, self, self.config.editor, self.config.variant) then
        if not pcall(vim.cmd, "colorscheme " .. self.config.editor) then
            self:setDefaultTheme("Error loading theme")
        end
    end
end

return themeLoader
