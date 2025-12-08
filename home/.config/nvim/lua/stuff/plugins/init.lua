return {
  {
    "stevearc/dressing.nvim", -- boxes for renames etc looking nice
    event = "VeryLazy",
  },
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
  {
    "brenoprata10/nvim-highlight-colors", -- preview colors
    config = function()
      vim.opt.termguicolors = true
      require("nvim-highlight-colors").setup({})
    end,
  },
}
