if (not pcall(require, 'neotest')) then
  return
end

require("neotest").setup({
  output_panel = {
    enabled = true
  },
  adapters = {
    require('neotest-jest')({
      jestCommand = "npm test --",
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  },
})

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua  require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = "Neotest run current file" })
vim.api.nvim_set_keymap("n", "<leader>to", "<cmd>lua  require('neotest').output_panel.toggle()<cr>", { desc = "Neotest output_panel toggle" })
