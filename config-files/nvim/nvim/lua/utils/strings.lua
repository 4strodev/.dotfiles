local string_utils = {}

string_utils.split = function(text, separator)
    local result = {}

    for word in string.gmatch(text, '([^' .. separator .. ']+)') do
        table.insert(result, word)
    end

    return result
end

return string_utils
