return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    cmd = "ChatGPT",
    config = function()
      require("chatgpt").setup({
                keymaps = {
          submit = "<C-s>"
        }
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
