local M = {}

function M.setup()
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            require("nvim-web-devicons").refresh()
        end,
    })
end

return M
