local zephyr = {}

local variantLoaders = {
    [""] = "colorscheme zephyr"
}

zephyr.SetUp = function(variant)
    vim.cmd(variantLoaders[variant])
end

return zephyr
