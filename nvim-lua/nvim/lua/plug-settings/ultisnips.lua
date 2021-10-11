local m = {}

m.setup = function()
    vim.g["UltiSnipsExpandTrigger"] = "<tab>"
    vim.g["UltiSnipsJumpForwardTrigger"] = "<c-j>"
    vim.g["UltiSnipsJumpBackwardTrigger"] = "<c-k>"
    vim.g["UltiSnipsEditSplit"] = "vertical"
end

return m
