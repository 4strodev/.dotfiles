local editor = require("editor")

local function main()
	editor:commonConfigs()
	require("plugins.install")

	editor:setColorscheme(os.getenv("EDITOR_THEME"))
	require("plugins.config")
end

main()
