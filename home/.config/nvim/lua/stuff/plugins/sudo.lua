return {
  {
    "lambdalisue/suda.vim",
    ft = { "conf", "etc", "passwd", "shadow", "group" }, -- Only load for system files
    cmd = { "SudaRead", "SudaWrite" },
  },
}
