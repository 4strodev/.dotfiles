local gruvbox = {}

gruvbox.SetUp = function(_)
    vim.g["gruvbox_contrast_dark"] = "hard"
    return vim.cmd("colorscheme gruvbox")
end

return gruvbox
