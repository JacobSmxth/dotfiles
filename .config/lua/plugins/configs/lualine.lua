-- lua/plugins/configs/lualine.lua

local colors = require("catppuccin.palettes").get_palette("mocha")

require("lualine").setup({
  options = {
    theme = {
      normal = { a = { fg = colors.base, bg = colors.mauve, gui = "bold" } },
      insert = { a = { fg = colors.base, bg = colors.green } },
      visual = { a = { fg = colors.base, bg = colors.yellow } },
      replace = { a = { fg = colors.base, bg = colors.red } },
      command = { a = { fg = colors.base, bg = colors.blue } },
    },
  },
})

