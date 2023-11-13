local lspconfig_module = {}
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_dap = require('mason-nvim-dap')
local mason_lspconfig = require('mason-lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ac', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>fd', function() vim.lsp.buf.format { async = true } end, bufopts)
end

function lspconfig_module.setup()
    mason.setup()
    mason_dap.setup()
    mason_lspconfig.setup()

    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>ee', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>qq', vim.diagnostic.setloclist, opts)


    mason_lspconfig.setup_handlers {
        function(server_name)
            if server_name == 'lua_ls' then
                lspconfig[server_name].setup {
                    on_attach = on_attach,
                    settings = {
                        Lua = {
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = { 'vim' },
                            },
                        },
                    }
                }
            else
                lspconfig[server_name].setup {
                    on_attach = on_attach,
                }
            end
        end,
    }
end

return lspconfig_module
--local default_lsp_config = {
--on_attach = on_attach,
--flags = {
---- This will be the default in neovim 0.7+
--debounce_text_changes = 150,
--},
--}
