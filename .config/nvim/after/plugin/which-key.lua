if (not pcall(require, 'which-key')) then
  return
end

vim.o.timeout = true
vim.o.timeoutlen = 300

local wk = require("which-key")

wk.setup {
  prefix="<leader>"
}

wk.register({
  f = {
    name = "Telescope", -- optional group name
  },
  x = {
    name = "Trouble"
  },
  a = {
    name = "Aerial"
  },
  t = {
    name = "Neotest"
  },
  h = {
    name = "Hop"
  },
  m = {
    name = "ToggleTerm"
  },
  l = {
    name = "lsp"
  }
}, { prefix = "<leader>" })
