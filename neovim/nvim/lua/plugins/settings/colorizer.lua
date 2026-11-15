local M = {}

function M.setup()
    require "colorizer".setup {
        'css',
        html = {
            mode = 'foreground'
        }
    }
end

return M
