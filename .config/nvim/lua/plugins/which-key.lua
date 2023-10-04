return {
  -- Cheat sheet
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
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
          name = "Typescript",
        },
        T = {
          name = "Neotest",
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
        r = {
          name = "refactoring",
        },
        s = {
          name = "Search/replace",
        },
        h = {
          name = "Harpoon",
        },
        o = {
          name = "Other",
        },
      }, { prefix = "<leader>" })
    end,
  },
}
