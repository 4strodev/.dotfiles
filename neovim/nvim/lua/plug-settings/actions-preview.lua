local module = {}

function module:setup()
    vim.keymap.set({ "v", "n" }, "<leader>ac", require("actions-preview").code_actions)
end

return module
