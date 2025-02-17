return {
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      check_ts = true,
    },
  },
  { "kylechui/nvim-surround", version = "*", config = true, event = { "BufReadPre", "BufNewFile" } },
}
