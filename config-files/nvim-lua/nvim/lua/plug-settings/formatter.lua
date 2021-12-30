local M = {}
M.setup = function()
    require("formatter").setup(
        {
            logging = false,
            filetype = {
                javascript = {
                    -- prettier
                    function()
                        return {
                            exe = "prettier",
                            args = {
                                "--stdin-filepath",
                                vim.api.nvim_buf_get_name(0),
                                "--single-quote",
                                "--tab-width",
                                4
                            },
                            stdin = true
                        }
                    end
                },
                typescript = {
                    -- prettier
                    function()
                        return {
                            exe = "prettier",
                            args = {
                                "--stdin-filepath",
                                vim.api.nvim_buf_get_name(0),
                                "--single-quote",
                                "--tab-width",
                                4
                            },
                            stdin = true
                        }
                    end
                },
                html = {
                    -- prettier
                    function()
                        return {
                            exe = "prettier",
                            args = {
                                "--stdin-filepath",
                                vim.api.nvim_buf_get_name(0),
                                "--single-quote",
                                "--tab-width",
                                4
                            },
                            stdin = true
                        }
                    end
                },
                vue = {
                    -- prettier
                    function()
                        return {
                            exe = "prettier",
                            args = {
                                "--stdin-filepath",
                                vim.api.nvim_buf_get_name(0),
                                "--single-quote",
                                "--tab-width",
                                4
                            },
                            stdin = true
                        }
                    end
                },
                json = {
                    -- prettier
                    function()
                        return {
                            exe = "prettier",
                            args = {
                                "--stdin-filepath",
                                vim.api.nvim_buf_get_name(0),
                                "--single-quote",
                                "--tab-width",
                                4
                            },
                            stdin = true
                        }
                    end
                },
                rust = {
                    -- Rustfmt
                    function()
                        return {
                            exe = "rustfmt",
                            args = {"--emit=stdout"},
                            stdin = true
                        }
                    end
                },
                lua = {
                    -- luafmt
                    function()
                        return {
                            exe = "luafmt",
                            args = {"--indent-count", 4, "--stdin"},
                            stdin = true
                        }
                    end
                },
                go = {
                    function()
                        return {
                            exe = "gofmt",
                            stdin = true
                        }
                    end
                }
            }
        }
    )

    --format on save
    --[[    vim.api.nvim_exec(
        [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.json,*.lua,*.go,*.html,*.rs FormatWrite
augroup END
,
        true
    )]]
end

return M
