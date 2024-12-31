local editor = require("editor")

local function main()
    editor:commonConfigs()

    require("plugins.install")
    require("plugins.config")
end

main()
