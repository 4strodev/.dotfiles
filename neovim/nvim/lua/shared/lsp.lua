local shared_lsp = {}

--- Override with a patch the default configuration of an LSP server
--- @param server string the server that you want to override
--- @param config table the config you want to patch
function shared_lsp.override(server, config)
    local lspconfig = require('lspconfig')

    local default_config = lspconfig[server].document_config.default_config

    lspconfig[server].setup(vim.tbl_deep_extend("force", default_config, config))
end

return shared_lsp
