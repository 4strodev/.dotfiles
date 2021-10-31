local onedark = {}

onedark.SetUp = function(variant)
    vim.g["onedark_style"] = variant or "cool"
    vim.cmd("colorscheme onedark")
end
return onedark
