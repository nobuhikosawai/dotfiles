if (not pcall(require, 'lspsaga')) then
  return
end

local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.setup({})

keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
