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
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Neotest run current file",
      },
      {
        "<leader>to",
        function() require('neotest').output_panel.toggle() end,
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
            jestCommand = "npm run test --",
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        },
      })
    end,
  },
}
