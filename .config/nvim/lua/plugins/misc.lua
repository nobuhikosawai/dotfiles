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
        -- enabled = false,
        animate = {
          enabled = false,
        },
        filter = function(buf)
          -- return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
          return vim.bo[buf].buftype ~= "tex" or vim.bo[buf].filetype == ""
        end,
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

  -- Typing
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
}
