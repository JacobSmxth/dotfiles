-- lua/plugins/configs/lualine.lua
local c = require('themes.voided').palette
require('lualine').setup{
  options = {
    theme = {
      normal = { a = { fg = c.bg, bg = c.accent, gui = 'bold' } },
      insert = { a = { fg = c.bg, bg = c.highlight } },
      visual = { a = { fg = c.bg, bg = c.accent } },
      replace= { a = { fg = c.bg, bg = c.accent } },
      command= { a = { fg = c.bg, bg = c.accent } },
    },
  }
}

