local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local function set_keymap(...)
    vim.api.nvim_set_keymap(...)
end
local function set_option(...)
    vim.api.nvim_set_option(...)
end

M.setup = function()
    --[[local nvim_lsp = ]] require("lspconfig")

    --Enable completion triggered by <c-x><c-o>
    set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    set_keymap("n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    set_keymap("n", "<leader>ee", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    set_keymap("n", "<leader>qq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    set_keymap("n", "<leader>fd", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    -- emmet
    vim.g["user_emmet_leader_key"] = "<C-Z>"
end

return M
