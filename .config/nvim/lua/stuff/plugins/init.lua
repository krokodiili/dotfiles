return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
  -- { "rose-pine/neovim", name = "rose-pine" },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      vim.opt.termguicolors = true
      require("nvim-highlight-colors").setup({})
    end,
  },
  { "tpope/vim-fugitive" },
  { "sudormrfbin/cheatsheet.nvim" },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
}
