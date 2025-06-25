-- ~/.config/nvim/lua/plugins/init.lua

-- Bootstrap packer.nvim if missing
local fn = vim.fn
local install_path = fn.stdpath('data')
  .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  vim.cmd 'packadd packer.nvim'
end

return require('packer').startup(function(use)
  -- Packer manages itself
  use 'wbthomason/packer.nvim'

  -- Mason & LSPconfig (with ts_ls instead of tsserver)
  use {
    'williamboman/mason.nvim',
    config = function() require('mason').setup() end,
  }
  use {
    'neovim/nvim-lspconfig',
    after = 'mason.nvim',
    config = function()
      local lspconfig = require('lspconfig')
      for _, server in ipairs({ 'clangd', 'gopls', 'pyright', 'ts_ls' }) do
        lspconfig[server].setup{}
      end
    end,
  }

  -- Autocomplete & snippets
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function() require('plugins.configs.cmp') end,
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run    = ':TSUpdate',
    config = function() require('plugins.configs.treesitter') end,
  }

  -- Telescope + native FZF
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    run    = 'make',
    config = function() require('plugins.configs.telescope') end,
  }

  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.configs.nvimtree') end,
  }

  -- Git signs
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.configs.gitsigns') end,
  }

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.configs.lualine') end,
  }

  -- Autopairs
  use {
    'windwp/nvim-autopairs',
    config = function() require('plugins.configs.autopairs') end,
  }

  -- Comment.nvim (built-in mappings disabled, explicit keymaps)
  use {
    'numToStr/Comment.nvim',
    config = function()
      -- Disable plugin’s default mappings
      require('Comment').setup {
        mappings = {
          basic    = false,
          extra    = false,
          extended = false,
        },
      }
      -- Explicit keymaps via nvim_set_keymap
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map('n', 'gcc',
        '<cmd>lua require("Comment.api").toggle.linewise()<CR>',
        opts
      )
      map('n', 'gbc',
        '<cmd>lua require("Comment.api").toggle.blockwise()<CR>',
        opts
      )
      map('x', 'gc',
        '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
        opts
      )
    end,
  }

  -- Which-Key
  use {
    'folke/which-key.nvim',
    config = function() require('which-key').setup{} end,
  }
end)

