
-- ~/.config/nvim/lua/plugins/lazy_setup.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("dashboard").setup({
        theme = "doom",
        config = {
          header = {
            "",
            "",
            "   ▄████▄   ▒█████   ▓█████▄  ██▓ ███▄    █   ▄████",
            "  ▒██▀ ▀█  ▒██▒  ██▒ ▒██▀ ██▌▓██▒ ██ ▀█   █  ██▒ ▀█▒",
            "  ▒▓█    ▄ ▒██░  ██▒ ░██   █▌▒██▒▓██  ▀█ ██▒▒██░▄▄▄░",
            "  ▒▓▓▄ ▄██▒▒██   ██░ ░▓█▄   ▌░██░▓██▒  ▐▌██▒░▓█  ██▓",
            "  ▒ ▓███▀ ░░ ████▓▒░ ░▒████▓ ░██░▒██░   ▓██░░▒▓███▀▒",
            "  ░ ░▒ ▒  ░░ ▒░▒░▒░  ▒▒▓  ▒ ░▓  ░ ▒░   ▒ ▒   ░▒   ▒ ",
            "    ░  ▒     ░ ▒ ▒░  ░ ▒  ▒  ▒ ░░ ░░   ░ ▒░   ░   ░ ",
            "  ░        ░ ░ ░ ▒   ░ ░  ░  ▒ ░   ░   ░ ░  ░ ░   ░ ",
            "  ░ ░          ░ ░   ░  ░   ░     ░           ░   ",
            "   ░                        ░                      ",
            "              -- Coding for Christ --             ",
            "",
            "",
            "",
          },
          center = {
            { icon = " ", desc = "New File",      key = "n", action = "ene | startinsert" },
            { icon = " ", desc = "Recent Files",  key = "r", action = "Telescope oldfiles" },
            { icon = " ", desc = "Find File",     key = "f", action = "Telescope find_files" },
            { icon = "󰍉 ", desc = "Grep Text",     key = "g", action = "Telescope live_grep" },
            { icon = " ", desc = "Settings",      key = "s", action = "edit $MYVIMRC" },
            { icon = " ", desc = "Quit Neovim",   key = "q", action = "qa" },
          },
          footer = { "God is good. All the time." },
        }
      })
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          treesitter = true,
          mason = true,
          which_key = true,
          telescope = true,
          nvimtree = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Mason core
  { "williamboman/mason.nvim", config = function() require("mason").setup() end },

  -- Bridge Mason <-> lspconfig
  { "williamboman/mason-lspconfig.nvim", config = function()
      require("mason-lspconfig").setup({})
    end
  },

  -- Ensure tools are present (auto on start)
  { "WhoIsSethDaniel/mason-tool-installer.nvim", config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "jdtls",                -- Java LSP
          "google-java-format",   -- Java formatter
        },
        auto_update = false,
        run_on_start = true,
      })
    end
  },

  -- Baseline LSPs (non-Java)
  { "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lspconfig = require("lspconfig")
      local caps = require("cmp_nvim_lsp").default_capabilities()

      -- keep Java out; handled by nvim-jdtls
      local servers = { "clangd", "gopls", "pyright", "ts_ls" }
      for _, server in ipairs(servers) do
        lspconfig[server].setup { capabilities = caps }
      end
    end,
  },

  -- Java LSP (handled separately via ftplugin/java.lua)
  { "mfussenegger/nvim-jdtls" },

  -- Formatter runner
  {
    "stevearc/conform.nvim",
    config = function()
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
      require("conform").setup({
        formatters_by_ft = { java = { "google-java-format" } },
        formatters = {
          ["google-java-format"] = {
            command = mason_bin .. "/google-java-format",
          },
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>f",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        { desc = "Format buffer" })
    end,
  },

  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function() require("plugins.configs.cmp") end,
  },

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function() require("plugins.configs.treesitter") end
  },

  { "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function() require("plugins.configs.telescope") end
  },

  { "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function() require("plugins.configs.nvimtree") end
  },

  { "lewis6991/gitsigns.nvim",
    config = function() require("plugins.configs.gitsigns") end
  },

  { "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function() require("plugins.configs.lualine") end
  },

  { "windwp/nvim-autopairs",
    config = function() require("plugins.configs.autopairs") end
  },

  { "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        mappings = { basic = false, extra = false, extended = false },
      }
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map("n", "gcc", '<cmd>lua require("Comment.api").toggle.linewise()<CR>', opts)
      map("n", "gbc", '<cmd>lua require("Comment.api").toggle.blockwise()<CR>', opts)
      map("x", "gc", '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', opts)
    end
  },

  { "folke/which-key.nvim", config = function() require("which-key").setup {} end },
})
