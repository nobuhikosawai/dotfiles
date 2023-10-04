return {
  { "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      integrations = {
        aerial = true,
        fidget = true,
        harpoon = true,
        lsp_trouble = true,
        neotest = true,
        neotree = true,
        treesitter_context = true,
        which_key = true,
      }
    }
  },
  { "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
  "cocopon/iceberg.vim",
  { "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup()
    end
  },
  { 'rose-pine/neovim', name = 'rose-pine', lazy = false, priority = 1000 },
}
