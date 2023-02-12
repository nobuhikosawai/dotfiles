return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
    },
    keys = {
      {
        "<leader>tt",
        "<cmd>require('neotest').run.run(vim.fn.expand('%'))<cr>",
        desc = "Neotest run current file",
      },
      {
        "<leader>to",
        "<cmd>require('neotest').output_panel.toggle()<cr>",
        desc = "Neotest output_panel toggle",
      },
    },
    config = function()
      require("neotest").setup({
        output_panel = {
          enabled = true,
        },
        adapters = {
          require("neotest-jest")({
            jestCommand = "npm test --",
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        },
      })
    end,
  },
}
