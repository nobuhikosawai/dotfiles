if (not pcall(require, 'aerial')) then
  return
end

require('aerial').setup({
  on_attach = function(bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>aa', '<cmd>AerialToggle!<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrev<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNext<CR>', {})
  end
})
