return {
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
      {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
          require("rainbow-delimiters.setup").setup({})
        end,
      },
    },
    main = "ibl",
    opts = {
      indent = { char = "▏" },
    },
    event = { "BufReadPost", "BufNewFile" },
  },
}
