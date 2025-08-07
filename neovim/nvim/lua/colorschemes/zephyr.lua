local zephyr = {}

local variantLoaders = {
    [""] = "colorscheme zephyr"
}

zephyr.setup = function(variant)
    vim.cmd(variantLoaders[variant])
end

return zephyr
