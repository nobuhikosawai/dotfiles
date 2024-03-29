return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "olimorris/neotest-rspec",
    },
    keys = {
      {
        "<leader>Tr",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Neotest run current file",
      },
      {
        "<leader>To",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Neotest output_panel toggle",
      },
      {
        "<leader>Ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Neotest summary toggle",
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
          require("neotest-rspec")({
            rspec_cmd = function()
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rspec",
              })
            end,
          }),
          require("neotest-vitest"),
        },
      })
    end,
  },
}
