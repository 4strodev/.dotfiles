-- require('plug-settings.lua.lsp.init')
require("plug-settings.compe").setup()
require("plug-settings.lspinstall").setup()
require("plug-settings.lspconfig").setup()
require("plug-settings.gitsigns").setup()
require("plug-settings.ultisnips").setup()
require("plug-settings.telescope").setup()
require("plug-settings.colorizer")
require("plug-settings.lspsignature")

-- statusline and buffers
require("plug-settings.lualine")
require("plug-settings.bufferline").setup()

require("plug-settings.formatter")
require("plug-settings.treesitter")
