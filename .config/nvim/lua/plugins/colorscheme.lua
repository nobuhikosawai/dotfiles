return {
  "EdenEast/nightfox.nvim",
  { "catppuccin/nvim", name = "catppuccin" },
  "folke/tokyonight.nvim",
  "cocopon/iceberg.vim",
  { "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup()
    end
  }
}
