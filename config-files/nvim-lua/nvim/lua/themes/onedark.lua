local onedark = {}

onedark.SetUp = function()
    vim.g["onedark_style"] = variant
    require("onedark").setup()
end
return onedark
