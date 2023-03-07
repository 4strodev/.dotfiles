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
    "plug-settings.nvim-dap",
    "plug-settings.treesitter",
    "plug-settings.cmp",
}

for _, plugin in pairs(plugin_list) do
    require(plugin).setup()
end
