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
    end,
    enabled=false,
  },
  {
    'altermo/ultimate-autopair.nvim',
    event={'InsertEnter','CmdlineEnter'},
    branch='v0.6',
    opts={
        --Config goes here
    },
  }
}
