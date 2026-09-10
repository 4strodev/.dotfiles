local ls = require 'luasnip'

local STEP_FORWARD = 1
local STEP_BACKWARD = 1

require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "gitcommit" } })

vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if ls.expandable() then
        ls.expand()
    elseif ls.jumpable(STEP_FORWARD) then
        ls.jump(STEP_FORWARD)
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.jumpable(STEP_BACKWARD) then
        ls.jump(STEP_BACKWARD)
    end
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
