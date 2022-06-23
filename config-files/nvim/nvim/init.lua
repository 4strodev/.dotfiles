ConfigPath = vim.fn.stdpath("config")

-- Python provider
vim.g["python3_host_prog"] = '/home/astro/.neovim_venv/bin/python'

-- Setting colors
vim.o.termguicolors = true
vim.o.background = "dark"

require("config.settings")
require("config.keymaps")
require("plugins.plugins-install")
require("plugins.plugins-config")

vim.cmd("colorscheme " .. (os.getenv("EDITOR_THEME") or "zephyr"))
