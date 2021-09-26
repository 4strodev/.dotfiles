JSON = {}

local open = io.open

local function readFile(path)
    local file = open(path, "rb")
    if not file then
        return nil
    end
    local content = file:read("*a")
    file:close()
    return content
end

-- Read json file to get the editor theme
JSON.loadTheme = function()
    local fileContent = readFile("/home/astro/.themes.json")
    local themeSettings = vim.fn.json_decode(fileContent)

    local theme = string.format("themes.%s", themeSettings.editor)
    return theme
end

return JSON
