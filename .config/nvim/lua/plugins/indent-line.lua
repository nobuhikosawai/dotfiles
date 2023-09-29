return {
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
      {
        'HiPhish/rainbow-delimiters.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
          require('rainbow-delimiters.setup')({})
        end
      },
    },
    main = "ibl",
    config = function()
      local highlight = {
        -- "RainbowDelimiterRed",
        -- "RainbowDelimiterYellow",
        -- "RainbowDelimiterBlue",
        -- "RainbowDelimiterOrange",
        -- "RainbowDelimiterGreen",
        -- "RainbowDelimiterViolet",
        -- "RainbowDelimiterCyan",
        "White"
      }
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "White", { fg = "#939293" })
      end)
      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup {
        scope = { highlight = highlight },
        indent = { char = '▏' },
      }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
    event = { "BufReadPost", "BufNewFile" },
  },
}
