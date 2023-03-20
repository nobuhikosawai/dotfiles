return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "p00f/nvim-ts-rainbow",
      "windwp/nvim-ts-autotag",
      "andymass/vim-matchup",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      local ts = require("nvim-treesitter.configs")

      ts.setup({
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
          disable = { "lua" },
        },
        autotag = {
          enable = true,
        },
        matchup = {
          enable = true,
        },
        rainbow = {
          enable = true,
          disable = { "vim" },
          extended_mode = true,
          max_file_lines = nil,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ak"] = "@class.outer",
              ["ik"] = "@class.inner",
              -- ["ip"] = "@parameter.inner",
              -- ["ap"] = "@parameter.outer",
              ["as"] = "@statement.outer",
              ["il"] = "@loop.inner",
              ["al"] = "@loop.outer",
              ["ic"] = "@conditional.inner",
              ["ac"] = "@conditional.outer",
              ["ab"] = "@block.outer",

              -- custom capture
              ["ad"] = "@declaration.outer",
              ["id"] = "@declaration.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
        ensure_installed = {
          "lua",
          "rust",
          "typescript",
          "tsx",
          "javascript",
          "hcl",
          "terraform",
          "graphql",
          "astro",
          "markdown",
          "markdown_inline",
          "yaml",
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
        context_commentstring = {
          enable = true,
        },
      })

      -- https://github.com/andymass/vim-matchup#features
      -- disable highlight all matches
      vim.g.matchup_matchparen_enabled = 0

      -- Use treesitter to fold
      -- Disabling this now in favor of `nvim-ufo`. See `lua/plugins/lsp.lua`.
      -- vim.opt.foldmethod = "expr"
      -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      -- vim.opt.foldlevel = 99

      -- mdx
      -- https://phelipetls.github.io/posts/mdx-syntax-highlight-treesitter-nvim/
      local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
      ft_to_parser.mdx = "markdown"
    end,
  },

  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
}
