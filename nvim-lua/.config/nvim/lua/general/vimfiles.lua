local exec = vim.api.nvim_command

return (function ()
    exec(string.format("source %s/lua/plug-settings/vim/airline.vim", ConfigPath))
end)()
