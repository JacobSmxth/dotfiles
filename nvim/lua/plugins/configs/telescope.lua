-- lua/plugins/configs/telescope.lua
local ok, telescope = pcall(require, 'telescope')
if not ok then return end

telescope.setup{}
-- safely load fzf extension only if it’s present
pcall(telescope.load_extension, 'fzf')

