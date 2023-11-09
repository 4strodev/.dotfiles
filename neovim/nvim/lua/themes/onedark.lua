local onedark = {}

onedark.SetUp = function(variant)
    if variant == "" or vairant == vim.NIL then
        vim.g["onedark_style"] = "cool"
    else
        vim.g["onedark_style"] = variant
    end
    vim.cmd("colorscheme onedark")
end
return onedark
