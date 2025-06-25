-- lua/themes/webdev.lua
local M = {}
M.palette = {
  bg        = "#080713",
  fg        = "#e4b9d4",
  accent    = "#B1368D",
  highlight = "#e4b9d4",
}
function M.apply()
  vim.opt.termguicolors = true
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
  vim.g.colors_name = "webdev"
  local c = M.palette
  -- Core UI
  vim.api.nvim_set_hl(0, "Normal",       { bg = c.bg, fg = c.fg })
  vim.api.nvim_set_hl(0, "NormalNC",     { bg = c.bg, fg = c.fg })
  vim.api.nvim_set_hl(0, "Visual",       { bg = c.accent })
  vim.api.nvim_set_hl(0, "Search",       { bg = c.highlight, fg = c.bg })
  vim.api.nvim_set_hl(0, "CursorLine",   { bg = c.accent })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.highlight, bg = c.bg })
  -- Syntax
  vim.api.nvim_set_hl(0, "@function",    { fg = c.accent, bold = true })
  vim.api.nvim_set_hl(0, "@keyword",     { fg = c.highlight, italic = true })
  vim.api.nvim_set_hl(0, "@string",      { fg = c.accent })
  vim.api.nvim_set_hl(0, "@constant",    { fg = c.highlight })
  vim.api.nvim_set_hl(0, "@comment",     { fg = c.highlight, italic = true })
  -- Diagnostics
  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = c.accent })
  vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = c.highlight })
  vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = c.fg })
  vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = c.fg })
end
return M

