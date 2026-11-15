local M = {}

function M.setup()
    local termtracker = require('termtracker')
    termtracker.setup({size = '25'})
end

return M
