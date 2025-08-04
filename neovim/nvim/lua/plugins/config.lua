local constants = require "config.constants"

local settings_path = constants.CONFIG_PATH .. "/lua/plugins/settings"
local settings_files = vim.fn.globpath(settings_path, "*.lua", false, true)


for _, file in ipairs(settings_files) do
    local module_name = file:match(".*/(.*)%.lua$")
    if module_name and not module_name:match("^%.") then
        local ok, err = pcall(require, "plugins.settings." .. module_name)
        if not ok then
            vim.notify("Error loading plugin settings: " .. module_name .. "\n" .. err, vim.log.levels.ERROR)
        end
    end
end
