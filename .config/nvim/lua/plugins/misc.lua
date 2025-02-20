local leet_arg = "leetcode.nvim"

return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    cmd = "Leet",
    lazy = leet_arg ~= vim.fn.argv()[1],
    opts = { arg = leet_arg, lang = "cpp" },
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
  -- QoL
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      lazygit = {},
      image = {},
      scratch = {},
      indent = {
        animate = {
          enabled = false,
        },
      },
    },
    keys = {
      {
        "<leader>lz",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
    },
  },
  -- Cheat sheet
  {
    "folke/which-key.nvim",
    keys = { "<leader>" },
    opt = {
      delay = 300,
    },
  },
}
