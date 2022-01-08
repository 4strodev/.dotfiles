local cmp_module = {}

cmp_module.setup = function()
    local cmp = require "cmp"

    cmp.setup(
        {
            snippet = {
                expand = function(args)
                    -- For `vsnip` user.
                    --vim.fn["vsnip#anonymous"](args.body)

                    -- For `luasnip` user.
                    require("luasnip").lsp_expand(args.body)

                    -- For `ultisnips` user.
                    vim.fn["UltiSnips#Anon"](args.body)
                end
            },
            mapping = {
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({select = true})
            },
            sources = {
                {name = "ultisnips"},
                {name = "nvim_lsp"},
                -- For vsnip user.
                --{ name = 'vsnip' },

                -- For luasnip user.
                --{name = "luasnip"},
                -- For ultisnips user.
                {name = "buffer"}
            }
        }
    )

    --Setup lspconfig.
    --require('lspconfig')[[[]]].setup {
    --capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    --}
end

return cmp_module
