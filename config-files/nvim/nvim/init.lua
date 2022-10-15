local function setColorscheme(colorscheme)
    local colorschemes = vim.fn.getcompletion("", "color")
    local exists = false
    local defaultColorscheme = "desert"

    for _, value in ipairs(colorschemes) do
        if value == colorscheme then
            exists = true
            break
        end
    end

    if not exists then
        print("Colorscheme set to default colorscheme: " .. defaultColorscheme)
        colorscheme = defaultColorscheme
    end

    vim.cmd("colorscheme " .. colorscheme)
end

-- Setting editor colorscheme
setColorscheme(os.getenv("EDITOR_THEME"))
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

