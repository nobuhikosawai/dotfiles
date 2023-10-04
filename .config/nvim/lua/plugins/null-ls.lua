-- tmp stting after null-ls
return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost", "BufWinEnter" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "mhartington/formatter.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local defaults = require("formatter.defaults")
      local filetypes = require("formatter.filetypes")
      require("formatter").setup({
        filetype = {
          javascript = {
            defaults.prettierd,
          },
          javascriptreact = {
            defaults.prettierd,
          },
          typescript = {
            defaults.prettierd,
          },
          typescriptreact = {
            defaults.prettierd,
          },
          lua = {
            filetypes.lua.stylua,
          },
          python = {
            filetypes.python.black,
          },
        },
      })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        command = "FormatWrite",
      })
    end,
  },
}
