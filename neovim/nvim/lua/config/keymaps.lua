-- Keymap registry. Plugin settings record their mappings here and apply them
-- once the plugin is loaded, while `triggers()` derives lazy.nvim `keys` stubs
-- from the same list so both stay in sync. Recording is pure: `vim` is only
-- touched inside `apply` and `apply_buffer`.
local M = {}

local Ctx = {}
Ctx.__index = Ctx

function M.new()
    return setmetatable({ list = {}, buffer_list = {} }, Ctx)
end

-- Records a global mapping.
function Ctx:map(mode, lhs, rhs, opts)
    table.insert(self.list, { mode, lhs, rhs, opts or {} })
end

-- Records a buffer-local mapping, applied by `apply_buffer`.
function Ctx:buffer_map(mode, lhs, rhs, opts)
    table.insert(self.buffer_list, { mode, lhs, rhs, opts or {} })
end

function Ctx:apply()
    for _, m in ipairs(self.list) do
        vim.keymap.set(m[1], m[2], m[3], m[4])
    end
end

function Ctx:apply_buffer(bufnr)
    for _, m in ipairs(self.buffer_list) do
        vim.keymap.set(m[1], m[2], m[3], vim.tbl_extend("force", {}, m[4], { buffer = bufnr }))
    end
end

-- Returns lazy.nvim `keys` stubs (no rhs) for the global mappings.
function Ctx:triggers()
    local keys = {}
    for _, m in ipairs(self.list) do
        table.insert(keys, { m[2], mode = m[1], desc = m[4].desc })
    end
    return keys
end

return M
