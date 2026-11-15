local nvim_dap_module = {}

local ctx = require('config.keymaps').new()
nvim_dap_module.keymaps = ctx

local function setup_adapters()
    require('dap-go').setup()
end

ctx:map("n", "<F5>", ":lua require 'dap'.continue()<CR>")
ctx:map("n", "<F3>", ":lua require 'dap'.step_over()<CR>")
ctx:map("n", "<F2>", ":lua require 'dap'.step_into()<CR>")
ctx:map("n", "<F12>", ":lua require 'dap'.step_out()<CR>")
ctx:map("n", "<leader>b", ":lua require 'dap'.toggle_breakpoint()<CR>")
ctx:map("n", "<leader>B", ":lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
ctx:map("n", "<leader>lp",
    ":lua require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))()<CR>")
ctx:map("n", "<leader>dr", ":lua require 'dap'.repl.open()<CR>")
ctx:map("n", "<leader>du", ":lua require 'dapui'.toggle()<CR>")

nvim_dap_module.setup = function()
    local dap, dapui, dap_virtual_text = require("dap"), require("dapui"), require('nvim-dap-virtual-text')

    ctx:apply()

    dapui.setup()
    dap_virtual_text.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    setup_adapters()
end

return nvim_dap_module
