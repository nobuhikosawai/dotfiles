return {
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    event = "BufReadPost",
    config = true,
  },
}
