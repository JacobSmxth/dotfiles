
-- ~/.config/nvim/lua/plugins/configs/lsp.lua
-- Baseline: Mason + LSP + cmp capabilities
require("mason").setup()

local lspconfig = require("lspconfig")
local caps_ok, cmp_caps = pcall(require, "cmp_nvim_lsp")
local caps = caps_ok and cmp_caps.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

-- Resolve TS server name across versions (tsserver -> ts_ls)
local ts_server_name = lspconfig.ts_ls and "ts_ls" or "tsserver"

-- Non-Java servers (Java is handled via nvim-jdtls below)
for _, server in ipairs({ "clangd", "gopls", "pyright", ts_server_name }) do
  lspconfig[server].setup({ capabilities = caps })
end

-- Rust remains explicit (with room for RA settings)
lspconfig.rust_analyzer.setup({
  capabilities = caps,
  settings = {
    ["rust-analyzer"] = {
      -- cargo = { allFeatures = true },
      -- checkOnSave = { command = "clippy" },
    },
  },
})

----------------------------------------------------------------------
-- Java via nvim-jdtls (scoped to Java buffers; no ftplugin/ needed)
----------------------------------------------------------------------
local function setup_java()
  local ok, jdtls = pcall(require, "jdtls")
  if not ok then
    vim.notify("nvim-jdtls not found (install via Mason)", vim.log.levels.ERROR)
    return
  end

  -- Determine project root; open Neovim at repo root for best results
  local root_dir = require("jdtls.setup").find_root({
    "gradlew", "mvnw", "pom.xml", "build.gradle", ".git",
  })
  if not root_dir then
    vim.notify("jdtls: no project root found", vim.log.levels.WARN)
    return
  end

  -- Mason-managed binaries
  local mason = vim.fn.stdpath("data") .. "/mason"
  local jdtls_bin = mason .. "/bin/jdtls"

  -- One workspace per project (required by jdtls)
  local workspace_dir = vim.fn.expand("~/.local/share/eclipse-workspaces/")
    .. vim.fn.fnamemodify(root_dir, ":p:h:t")

  local on_attach = function(_, bufnr)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end
    map("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")
    map("n", "gr", vim.lsp.buf.references, "LSP: References")
    map("n", "K",  vim.lsp.buf.hover, "LSP: Hover")
    map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
    map("n", "<leader>oi", function() jdtls.organize_imports() end, "Java: Organize Imports")
  end

  local config = {
    cmd = { jdtls_bin, "--jvm-arg=-Xms1g" },
    root_dir = root_dir,
    capabilities = caps,
    on_attach = on_attach,
    settings = {
      java = {
        configuration = { updateBuildConfiguration = "interactive" },
        format = { enabled = false }, -- delegate to conform.nvim
        signatureHelp = { enabled = true },
        contentProvider = { preferred = "fernflower" },
      },
    },
    init_options = { bundles = {} }, -- add DAP/test bundles later if needed
  }

  jdtls.start_or_attach(config)
end

-- Autostart jdtls only for Java buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = setup_java,
})

