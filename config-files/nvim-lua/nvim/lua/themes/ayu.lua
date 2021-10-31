local ayu = {}
local variantLoaders = {
    ["light"] = "colorscheme ayu-light",
    ["mirage"] = "colorscheme ayu-mirage",
    ["dark"] = "colorscheme ayu-dark",
    [""] = "colorscheme ayu-dark"
}

ayu.SetUp = function(variant)
    vim.g.ayu_mirage = true
    vim.cmd(variantLoaders[variant])
end

return ayu
