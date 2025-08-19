
-- Start jdtls for Gradle-backed Java projects (Spring Boot ready)

local ok, jdtls = pcall(require, "jdtls")
if not ok then
  vim.notify("nvim-jdtls not installed", vim.log.levels.ERROR)
  return
end

-- Prefer the module root (your app/ folder) so Gradle classpath is correct
local root_markers = { "gradlew", "build.gradle", "settings.gradle", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- If you often open from the repo root, force-resolve to app/ when needed
if root_dir and root_dir:match("/LedgerLite$") then
  local app_dir = root_dir .. "/app"
  if vim.fn.isdirectory(app_dir) == 1 then
    root_dir = app_dir
  end
end

if not root_dir or root_dir == "" then
  vim.notify("Java root not found. Open nvim in ~/dev/LedgerLite/app", vim.log.levels.WARN)
  return
end

-- Mason-installed jdtls shim
local jdtls_bin = vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls")

-- Unique workspace per project
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" ..
                      vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {
  cmd = { jdtls_bin, "-data", workspace_dir },
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        runtimes = {
          { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk" },
          { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" },
        },
      },
      import = { gradle = { enabled = true } }, -- pull Gradle deps (Spring)
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
    },
  },
  init_options = { bundles = {} },
}

jdtls.start_or_attach(config)
