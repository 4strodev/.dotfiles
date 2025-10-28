local editor = require("editor")


local function main()
    require("plugins.install")
    editor:commonConfigs()
    editor:setColorscheme(os.getenv("EDITOR_THEME"))

    require("plugins.config")
end

main()
