return {
  "kylechui/nvim-surround",
  version = "*", -- This keeps you on the stable v4 branch
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- You can leave this empty!
      -- All the keymaps you had before (ys, ds, cs, etc.) are now active by default.
    })
  end,
}
