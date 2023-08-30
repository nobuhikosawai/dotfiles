return {
  { 'wakatime/vim-wakatime', event = "VeryLazy" },
  {
     "m4xshen/hardtime.nvim",
     event="VeryLazy",
     dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
     opts = {
      disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason" , "neo-tree"},
     },
     enabled = false,
  },
}
