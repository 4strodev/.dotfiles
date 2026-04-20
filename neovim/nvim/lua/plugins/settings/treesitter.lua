require('nvim-treesitter').setup {
    install_dir = vim.fn.stdpath('data') .. '/site'
}

local function start_ts_if_available(bufnr)
    local fileType = vim.bo[bufnr].filetype
    local language = vim.treesitter.language.get_lang(fileType)

    if language and vim.treesitter.language.add(language) then
        vim.treesitter.start(bufnr, language)
    end
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        start_ts_if_available(ev.buf)
    end,
})
