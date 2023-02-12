return {
  { "ggandor/leap.nvim", enabled = false },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
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
}
