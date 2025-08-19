-- lua/core/options.lua

local undodir = vim.fn.stdpath('cache') .. '/undo'
vim.fn.mkdir(undodir, 'p')
vim.opt.undodir    = undodir
vim.opt.undofile   = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000



local o = vim.opt
o.number          = true            -- absolute line numbers
o.relativenumber  = true            -- relative line numbers
o.termguicolors   = true            -- true-color support
o.clipboard       = 'unnamedplus'   -- system clipboard
o.expandtab       = true            -- spaces instead of tabs
o.shiftwidth      = 2               -- indent size
o.tabstop         = 2               -- tab width
o.wrap            = false           -- no line wrap

