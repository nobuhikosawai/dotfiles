return {

  { "lewis6991/gitsigns.nvim", config = true,                          event = { "BufReadPre", "BufNewFile" } },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  },
  { "dinhhuy258/git.nvim",     config = true,                          event = { "BufReadPre", "BufNewFile" } },
  { 'TimUntersberger/neogit',  dependencies = 'nvim-lua/plenary.nvim', cmd = { "Neogit" },                    config = true },
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true,
    event = { "BufReadPre", "BufNewFile" }
  }
}
