local ls = require 'luasnip'

require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "gitcommit" } })

vim.keymap.set({ "i", "s" }, "<c-l>", function()
    if ls.jumpable(1) then
        ls.jump(1)
    elseif ls.expandable() then
        ls.expand()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
