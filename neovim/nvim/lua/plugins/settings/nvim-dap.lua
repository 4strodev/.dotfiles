local nvim_dap_module = {}

local dap, dapui, dap_virtual_text = require("dap"), require("dapui"), require('nvim-dap-virtual-text')

local function setup_adapters()
    require('dap-go').setup()
end

nvim_dap_module.setup = function()
    vim.keymap.set("n", "<F5>", ":lua require 'dap'.continue()<CR>")
    vim.keymap.set("n", "<F3>", ":lua require 'dap'.step_over()<CR>")
    vim.keymap.set("n", "<F2>", ":lua require 'dap'.step_into()<CR>")
    vim.keymap.set("n", "<F12>", ":lua require 'dap'.step_out()<CR>")
    vim.keymap.set("n", "<leader>b", ":lua require 'dap'.toggle_breakpoint()<CR>")
    vim.keymap.set("n", "<leader>B", ":lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
    vim.keymap.set("n", "<leader>lp",
        ":lua require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))()<CR>")
    vim.keymap.set("n", "<leader>dr", ":lua require 'dap'.repl.open()<CR>")
    vim.keymap.set("n", "<leader>du", ":lua require 'dapui'.toggle()<CR>")

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


nvim_dap_module.setup()
