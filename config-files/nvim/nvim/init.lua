-- Setting editor colorscheme
vim.cmd("colorscheme " .. (os.getenv("EDITOR_THEME") or "default"))
vim.api.nvim_create_user_command("RestartNeovim", function()
   vim.cmd("luafile ~/.config/nvim/init.lua")
end, {})

-- Python provider
vim.g["python3_host_prog"] = '/home/astro/.neovim_venv/bin/python'

-- Setting colors
vim.o.termguicolors = true
vim.o.background = "dark"

-- executing other configuration files
require("config.settings")
require("config.keymaps")
require("plugins.plugins-install")
require("plugins.plugins-config")

