local M = {}

local STEP_FORWARD = 1
local STEP_BACKWARD = 1

function M.setup()
    local ls = require 'luasnip'
    local ctx = require('config.keymaps').new()
    M.keymaps = ctx

    require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "gitcommit" } })
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

    ctx:map({ "i", "s" }, "<c-l>", function()
        if ls.expandable() then
            ls.expand()
        elseif ls.jumpable(STEP_FORWARD) then
            ls.jump(STEP_FORWARD)
        end
    end, { silent = true })

    ctx:map({ "i", "s" }, "<c-k>", function()
        if ls.jumpable(STEP_BACKWARD) then
            ls.jump(STEP_BACKWARD)
        end
    end, { silent = true })

    ctx:apply()
end

return M
