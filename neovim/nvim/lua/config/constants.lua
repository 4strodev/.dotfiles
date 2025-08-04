---@class ConfigVariables
---@field CONFIG_PATH string config file directory

---@type ConfigVariables
local contants_module = {
    CONFIG_PATH = vim.fn.stdpath('config')
}

return contants_module
