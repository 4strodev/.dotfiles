local constants = require "config.constants"

vim.uv.fs_scandir(constants.CONFIG_PATH, function(err, entries)
    if err ~= nil then
        print(err)
        return
    end

    while true do
        local name, type = vim.uv.fs_scandir_next(entries)
        if not name then break end
        print(name, type)
    end
end)

local plugin_list = {
    "plug-settings.lualine",
    "plug-settings.bufferline",
    "plug-settings.lspconfig",
    "plug-settings.gitsigns",
    "plug-settings.luasnip",
    "plug-settings.telescope",
    "plug-settings.colorizer",
    "plug-settings.lspsignature",
    "plug-settings.nvimtree",
    "plug-settings.autopairs",
    --"lua.plug-settings.nvim-dap",
    "plug-settings.actions-preview",
    "plug-settings.treesitter",
    "plug-settings.cmp",
    "plug-settings.marks",
}

for _, plugin in pairs(plugin_list) do
    require(plugin).setup()
end
