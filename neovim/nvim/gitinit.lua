local editor = require("editor")

local function main()
    editor:common_configs()
    require("plugins.install")
    require("plugins.settings.luasnip")
end

main()
