local editor_module = {}

-- Sets colorscheme. If colorscheme is not found then
-- is fallback to the default one
function editor_module:set_colorscheme(colorscheme)
    -- get available colorschemes
    local colorschemes = vim.fn.getcompletion("", "color")
    local exists = false
    local defaultColorscheme = "retrobox"

    -- checking if the provided colorscheme exists
    for _, value in ipairs(colorschemes) do
        if value == colorscheme then
            exists = true
            break
        end
    end

    -- set fallback color to prevent errors
    if not exists then
        vim.notify("Colorscheme set to default colorscheme: " .. defaultColorscheme, vim.log.levels.WARN)
        colorscheme = defaultColorscheme
    end

    -- if colorscheme has a dedicated module use it
    local ok, module = pcall(require, "colorscheme." .. colorscheme)
    if ok then
        module.setup()
    else
        -- if not just load the colorscheme
        vim.cmd("colorscheme " .. colorscheme)
    end
end

function editor_module:common_configs()
    -- Python provider
    local homeDir = os.getenv("HOME")
    vim.g["python3_host_prog"] = homeDir .. '/.neovim_venv/bin/python'

    vim.api.nvim_create_user_command("RestartNeovim", function()
        vim.cmd("luafile ~/.config/nvim/init.lua")
    end, {})

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Setting colors
    vim.opt.termguicolors = true

    -- executing other configuration files
    require("config.settings")
    require("config.keymaps")
    require("config.macros")
end

function editor_module:reload_colorscheme()
end

return editor_module
