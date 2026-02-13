require("stuff.core")
require("stuff.lazy")
require("stuff.lsp")
-- 1. Helper function to find the local virtual environment
local function get_python_path()
  local venv_path = vim.fn.getcwd() .. "/.venv/bin/python"
  if vim.fn.executable(venv_path) == 1 then
    return venv_path
  end
  return "python3" -- Fallback to system python
end

-- 2. Configure and Enable Pyright natively (Neovim 0.11+)
-- This replaces the deprecated require('lspconfig') call
vim.lsp.enable("pyright", {
  settings = {
    python = {
      pythonPath = get_python_path(),
      analysis = {
        -- Ensures Pyright looks inside your .venv for libraries like httpx
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
})
