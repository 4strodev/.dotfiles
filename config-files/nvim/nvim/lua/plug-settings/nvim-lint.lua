local nvim_lint_module = {}

nvim_lint_module.setup = function()
    -- Set linters
    require('lint').linters_by_ft = {
        typescript = {
            'eslint'
        },
    }

    -- Start linting
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
            require("lint").try_lint()
        end,
    })

    -- Set configuration for linters
end

return nvim_lint_module
