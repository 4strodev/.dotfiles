local module = {}

module.setup = function()
    require("nvim-autopairs").setup {
        check_ts = true,
        ts_config = {
            lua = { "string", "soruce" },
            javascript = { "string", "template_string" },
            java = false,
        },
        disable_filetype = {"TelescopePromp", "spectre_panel"},
        fast_wrap = {
            map = '<M-e>',
            chars = { '{', '[', '(', '"', "'" },
            pattern = [=[[%'%"%>%]%)%}%,]]=],
            end_key = '$',
            keys = 'qwertyuiopzxcvbnmasdfghjkl',
            check_comma = true,
            highlight = 'Search',
            highlight_grey='Comment'
        }
    }
end

return module
