-- lua/plugins/configs/lsp.lua
require('mason').setup()
local lspconfig = require('lspconfig')
-- Enable servers for C, Go, Python, JS/TS
for _, server in ipairs({ 'clangd', 'gopls', 'pyright', 'tsserver' }) do
  lspconfig[server].setup {}
end

