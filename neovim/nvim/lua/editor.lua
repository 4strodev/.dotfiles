local editor_module = {}

-- Sets colorscheme. If colorscheme is not found then
-- is fallback to the default one
function editor_module:setColorscheme(colorscheme)
    -- get available colorschemes
    local colorschemes = vim.fn.getcompletion("", "color")
    local exists = false
    local defaultColorscheme = "desert"

    -- checking if the provided colorscheme exists
    for _, value in ipairs(colorschemes) do
        if value == colorscheme then
            exists = true
            break
        end
    end

    -- set fallback color to prvent errors
    if not exists then
        print("Colorscheme set to default colorscheme: " .. defaultColorscheme)
        colorscheme = defaultColorscheme
    end

    vim.cmd("colorscheme " .. colorscheme)
end

function editor_module:commonConfigs()
    -- Python provider
    vim.g["python3_host_prog"] = '/home/astro/.neovim_venv/bin/python'

    -- Setting editor colorscheme this is based on an environment vairable
    -- or by a default one
    self:setColorscheme(os.getenv("EDITOR_THEME"))
    vim.api.nvim_create_user_command("RestartNeovim", function()
        vim.cmd("luafile ~/.config/nvim/init.lua")
    end, {})

    -- Setting colors
    vim.o.termguicolors = true
    vim.o.background = "dark"

    -- executing other configuration files
    require("config.settings")
    require("config.keymaps")
end

return editor_module
