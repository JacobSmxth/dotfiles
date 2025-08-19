-- lua/plugins/configs/treesitter.lua
require('nvim-treesitter.configs').setup{
  ensure_installed = { 'c', 'go', 'python', 'javascript', 'typescript' },
  highlight = { enable = true },
}

