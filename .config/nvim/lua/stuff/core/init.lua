require("stuff.core.options")
require("stuff.core.keymaps")

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("TS_add_missing_imports", { clear = true }),
  desc = "TS_add_missing_imports",
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    vim.cmd("TSToolsAddMissingImports")
    vim.cmd("TSToolsRemoveUnusedImports")
    vim.cmd("write")
  end,
})
