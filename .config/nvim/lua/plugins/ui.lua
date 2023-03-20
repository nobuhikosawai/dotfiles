return {
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          globalstatus = true,
        },
      })
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    keys = {
      { "<leader>bb", "<cmd>BufferLinePick<cr>", desc = "BufferLinePick" },
    },
    init = function()
      vim.keymap.set("n", "[b", ":bprevious<CR>", {})
      vim.keymap.set("n", "]b", ":bnext<CR>", {})
      vim.keymap.set("n", "¬", ":bnext<CR>", {}) -- This is for alacritty. fix proper keymap
      vim.keymap.set("n", "˙", ":bprev<CR>", {}) -- This is for alacritty. fix proper keymap
      vim.keymap.set("n", "<A-l>", ":bnext<CR>", {}) -- This is for alacritty. fix proper keymap
      vim.keymap.set("n", "<A-h>", ":bprev<CR>", {}) -- This is for alacritty. fix proper keymap
    end,
    config = true,
  },

  -- window transparent
  {
    "xiyaowong/nvim-transparent",
    cmd = {
      "TransparentEnable",
      "TransparentDisable",
      "TransparentToggle",
    },
    config = function()
      require("transparent").setup({
        enable = false,
        extra_groups = {
          -- In particular, when you set it to 'all', that means all available groups
          -- example of akinsho/nvim-bufferline.lua
          "BufferLineTabClose",
          "BufferlineBufferSelected",
          "BufferLineFill",
          "BufferLineBackground",
          "BufferLineSeparator",
          "BufferLineIndicatorSelected",
        },
        exclude = {}, -- table: groups you don't want to clear
      })
    end,
  },

  -- icons
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      strict = true,
      override_by_extension = {
        ["stories.tsx"] = {
          icon = "",
          color = "#ff4785",
          cterm_color = "65",
          name = "StorybookTsx",
        },
      },
    },
  },

  -- scrollbar
  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "catppuccin/nvim",
      "lewis6991/gitsigns.nvim",
      {
        "kevinhwang91/nvim-hlslens",
        config = function()
          -- require('hlslens').setup() is not required
          require("scrollbar.handlers.search").setup({
            -- hlslens config overrides
            override_lens = function() end,
          })
        end,
      },
    },
    event = "BufReadPost",
    config = function()
      local colors = require("catppuccin.palettes").get_palette()
      require("scrollbar").setup({
        handle = { color = colors.crust },
        marks = {
          Cursor = { color = colors.lavender },
          Search = { color = colors.blue },
          Error = { color = colors.maroon },
          Warn = { color = colors.peach },
          Info = { color = colors.green },
          Hint = { color = colors.rosewater },
          Misc = { color = colors.sapphire },
        },
        handlers = {
          gitsigns = true, -- Requires gitsigns
        },
      })
    end,
  },

  -- noice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup({
        -- add any options here
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    enabled = false,
  },
}
