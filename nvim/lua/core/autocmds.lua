-- lua/core/autocmds.lua
local aug = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_autocmd

aug('TrimWhitespace', {})
cmd('BufWritePre', {
  group   = 'TrimWhitespace',
  pattern = '*',
  command = '%s/\\s\\+$//e',
})

