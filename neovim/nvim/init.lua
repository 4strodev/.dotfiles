local editor = require("editor")

local function main()
    editor:commonConfigs()

    require("plugins.plugins-install")
    require("plugins.plugins-config")
end

main()
