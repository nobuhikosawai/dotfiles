local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then return end

require('nvim-autopairs').setup({
  check_ts = true,
})
