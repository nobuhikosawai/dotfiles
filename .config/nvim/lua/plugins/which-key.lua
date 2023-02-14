return {
  -- Cheat sheet
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    -- event = "VeryLazy",
    keys = { "<leader>" },
    config = function()
      local wk = require("which-key")

      wk.setup({
        prefix = "<leader>",
      })

      wk.register({
        f = {
          name = "Telescope", -- optional group name
        },
        x = {
          name = "Trouble",
        },
        a = {
          name = "Aerial",
        },
        t = {
          name = "Neotest",
        },
        h = {
          name = "Hop",
        },
        m = {
          name = "ToggleTerm",
        },
        l = {
          name = "lsp",
        },
        b = {
          name = "Bufferline",
        },
        n = {
          name = "Neotree",
        },
        r = {
          name = "refactoring"
        },
        s = {
          name = "search/replace"
        }
      }, { prefix = "<leader>" })
    end,
  },
}
