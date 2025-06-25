-- lua/core/mappings.lua
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Telescope
map('n', '<C-p>', ':Telescope find_files<CR>', opts)
map('n', '<C-g>', ':Telescope live_grep<CR>', opts)

-- Buffers
map('n', '<S-l>', ':bnext<CR>', opts)
map('n', '<S-h>', ':bprevious<CR>', opts)

-- Nvim-Tree
map('n', '<Leader>e', ':NvimTreeToggle<CR>', opts)

