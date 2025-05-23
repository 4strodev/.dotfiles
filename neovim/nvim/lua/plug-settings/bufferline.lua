local bufferline = {}

bufferline.setup = function()
    require('bufferline').setup {
        options = {
            mode = "buffers", -- set to "tabs" to only show tabpages instead
            numbers = "none",
            close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
            right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
            left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
            middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
            -- NOTE: this plugin is designed with this icon in mind,
            -- and so changing this is NOT recommended, this is intended
            -- as an escape hatch for people who cannot bear it for whatever reason
            indicator = {
                icon = '▎',
                style = 'icon'
            },
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            --- name_formatter can be used to change the buffer's label in the bufferline.
            --- Please note some names can/will break the
            --- bufferline so use this at your discretion knowing that it has
            --- some limitations that will *NOT* be fixed.
            max_name_length = 28,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            tab_size = 28,
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "(" .. count .. ")"
            end,
            -- NOTE: this will be called a lot so don't do any heavy processing here
            custom_filter = function(buf_number, buf_numbers)
                return true
            end,
            offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
            color_icons = false, -- whether or not to add the filetype icon highlights
            show_buffer_icons = true, -- disable filetype icons for buffers
            show_buffer_close_icons = true,
            -- show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
            get_element_icon = function(element)
              local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
              return icon, hl
            end,
            show_close_icon = true,
            show_tab_indicators = true,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            -- can also be a table containing 2 custom separators
            -- [focused and unfocused]. eg: { '|', '|' }
            separator_style = "thin",
            enforce_regular_tabs = true,
            always_show_bufferline = true,
            sort_by = 'id'
        }
    }
end

return bufferline
