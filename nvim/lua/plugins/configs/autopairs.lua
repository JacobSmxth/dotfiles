-- lua/plugins/configs/autopairs.lua
require('nvim-autopairs').setup{
  disable_filetype = { "TelescopePrompt", "vim" },
  check_ts         = true,    -- treesitter integration
}

