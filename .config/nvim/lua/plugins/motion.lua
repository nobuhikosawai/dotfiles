return {
  { "ggandor/leap.nvim", enabled = false },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    enabled = false,
    init = function()
      vim.api.nvim_set_keymap(
        "",
        "f",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "",
        "F",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "",
        "t",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "",
        "T",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>",
        {}
      )

      vim.keymap.set("n", "<leader>hp", "<cmd>HopPattern<cr>", { desc = "HopPattern" })
      -- vim.keymap.set('n', '<leader>hc',  '<cmd>HopChar2<cr>', { desc = "HopChar2" })
      vim.keymap.set("n", "s", "<cmd>HopChar2<cr>", { desc = "HopChar2" }) -- like leap use `s` here
      vim.keymap.set("n", "<leader>hw", "<cmd>HopWord<cr>", { desc = "HopWord" })
      vim.keymap.set("n", "<leader>hv", "<cmd>HopLineStart<cr>", { desc = "HopLineStart" })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {
      jump = {
        autojump = true,
      },
      -- modes = {
      --   char = {
      --     multi_line = false
      --   }
      -- }
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "ss",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  }
}
