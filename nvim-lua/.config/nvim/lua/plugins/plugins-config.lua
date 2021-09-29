-- require('plug-settings.lua.lsp.init')
require("plug-settings.compe").setup()
require("plug-settings.lspinstall").setup()
require("plug-settings.lspconfig").setup()
require("plug-settings.gitsigns")
require("plug-settings.ultisnips")
require("plug-settings.telescope")
require("plug-settings.colorizer")
require("plug-settings.lspsignature")

-- statusline and buffers
require("plug-settings.lualine")
require("plug-settings.bufferline").setup()

require("plug-settings.formatter")
require("plug-settings.treesitter")
