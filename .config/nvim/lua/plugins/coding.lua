return {
  -- comment
  -- { "numToStr/Comment.nvim", config = true, event = { "BufReadPost", "BufNewFile" } },

  -- parentheses
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      check_ts = true,
    },
  },
  { "kylechui/nvim-surround", version = "*", config = true, event = { "BufReadPre", "BufNewFile" } },

  -- refactor
  {
    "ThePrimeagen/refactoring.nvim",
    enabled = false,
    event = "VeryLazy",
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
      },
    },
    opts = {},
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sR",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = {
      -- sign only
      highlight = {
        before = "",
        keyword = "",
        after = "",
      },
    },
  },

  {
    "chentoast/marks.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = false,
          auto_trigger = true,
        },
        panel = {
          enabled = false,
        },
      })
    end,
  },

  --yank
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
