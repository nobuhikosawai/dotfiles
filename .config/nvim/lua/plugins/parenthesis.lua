return {
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      check_ts = true,
    },
    enabled = false,
  },
  { "kylechui/nvim-surround", version = "*", config = true, event = { "BufReadPre", "BufNewFile" } },
  {
    "hrsh7th/nvim-insx",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('insx.preset.standard').setup()
    end
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('rainbow-delimiters.setup')({})
    end
  }
}
