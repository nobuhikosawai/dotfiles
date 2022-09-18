if (not pcall(require, "bufferline")) then
  return
end

require("bufferline").setup{}

-- vim.keymap.set("n", "[b", "<Cmd>BufferLineCycleNext<CR>", {})
-- vim.keymap.set("n", "b]", "<Cmd>BufferLineCyclePrev<CR>", {})
vim.keymap.set("n", "[b", ":bprevious<CR>", {})
vim.keymap.set("n", "]b", ":bnext<CR>", {})
