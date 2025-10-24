local mason = require('mason')
--local mason_dap = require('mason-nvim-dap')
local mason_lspconfig = require('mason-lspconfig')
local util = require("lspconfig.util");

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
    --vim.keymap.set('n', '<space>ac', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>fd', function() vim.lsp.buf.format { async = true } end, bufopts)
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
    callback = function(event)
        on_attach(nil, event.buf)
    end
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>ee', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>qq', vim.diagnostic.setloclist, opts)

vim.lsp.config('ts_ls', {
    on_attach = function(client, bufnr)
        local root_dir = client.config.root_dir

        -- helper: check if a file exists
        local function exists(path)
            return util.path.exists(util.path.join(root_dir, path))
        end

        -- disable ts_ls formatting if Prettier is present
        if exists("node_modules/.bin/prettier")
            or exists("prettier.config.js")
            or exists(".prettierrc")
            or exists(".prettierrc.js")
            or exists(".prettierrc.json")
            or exists(".prettierrc.yaml")
            or exists(".prettierrc.yml") then
            client.server_capabilities.documentFormattingProvider = false
        end
        on_attach(client, bufnr)
    end,
})

vim.lsp.config('lua_ls', {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which Lua version you're using
                version = 'LuaJIT',
                -- Setup your runtime path so lua_ls knows where to find lua files
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of runtime files and your config
                library = {
                    -- This adds neovim runtime files to the workspace library
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    -- Also add your config lua files
                    [vim.fn.stdpath('config') .. '/lua'] = true,
                },
                checkThirdParty = false, -- optional: disables third-party checks popup
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

mason.setup()
mason_lspconfig.setup({
    ensure_installed = { "lua_ls", "ts_ls" },
})
