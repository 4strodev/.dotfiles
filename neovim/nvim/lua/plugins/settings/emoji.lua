local M = {}

function M.setup()
    require("emoji").setup({
        enable_cmp_integration = true,
    })
end

return M
