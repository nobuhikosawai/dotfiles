if (not pcall(require, 'lspsaga')) then
  return
end

local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.setup({
  symbol_in_winbar = {
    respect_root = true,
  },
})

keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true, desc = "code action" })
