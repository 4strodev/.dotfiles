local editor = require("editor")

local function main()
	editor:common_configs()
	require("plugins.install")

	editor:set_colorscheme(os.getenv("EDITOR_THEME"))
	require("plugins.config")
end

main()
