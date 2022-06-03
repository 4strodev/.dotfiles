local nord = {}

local variantLoaders = {
    [""] = "colorscheme nord"
}

nord.SetUp = function(_)
    vim.cmd(variantLoaders[""])
end

return nord
