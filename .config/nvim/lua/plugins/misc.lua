local leet_arg = "leetcode.nvim"

return {
  { "wakatime/vim-wakatime", event = "VeryLazy" },
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "neo-tree" },
    },
    enabled = false,
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    cmd = "Leet",
    lazy = leet_arg ~= vim.fn.argv()[1],
    opts = { arg = leet_arg, lang = "typescript" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      -- "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      -- "nvim-tree/nvim-web-devicons",
    },
  },
}
