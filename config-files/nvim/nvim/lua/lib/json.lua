-- creating a table that stores these functions
JSON = {}

local open = io.open

-- Convert file content to a string
local function readFile(path)
    local file = open(path, "rb")
    if not file then
        return nil
    end
    local content = file:read("*a")
    file:close()
    return content
end

-- Read json string and parse to an object
JSON.Parser = function(filePath)
    local fileContent = readFile(filePath) -- File content in a string value
    local contentParsed = vim.fn.json_decode(fileContent)

    return contentParsed
end

return JSON
