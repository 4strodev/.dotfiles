local tabSizer = {}

local nvim_exec = vim.api.nvim_exec

local language = {
    extensions,
    tabSize,
    tabChar
}

tabSizer.setTabs = function (languages)
end

-- fuck
function setTabForExtension(extension, tabSize, tabChar)
    command = [[autocmd if condition then
        -- body
    end]]
    nvim_exec(command)
end
