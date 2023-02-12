return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Telescope live_grep",
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Telescope find_files",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Telescope find_buffers",
      },
      -- Telescope plugin commands
      -- File browser

      {
        "<leader>fe",
        function()
          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          require("telescope").extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            initial_mode = "normal",
          })
        end,
        desc = "Telescope file_browser",
      },

      {
        "<leader>fy",
        "<cmd>Telescope neoclip<cr>",
        silent = true,
        noremap = true,
        desc = "Telescope neoclip",
      },
    },
    config = function()
      local builtin = require("telescope.builtin")
      local fb_actions = require("telescope").extensions.file_browser.actions

      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("neoclip")

      local telescopeConfig = require("telescope.config")
      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      require("telescope").setup({
        defaults = {
          -- `hidden = true` is not supported in text grep commands.
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            sorting_strategy = "ascending",
            scroll_strategy = "cycle",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              -- your custom insert mode mappings
              ["n"] = {
                -- your custom normal mode mappings
                ["h"] = fb_actions.goto_parent_dir,
              },
            },
          },
        },
      })
    end,
  },

  -- Filer
  "nvim-telescope/telescope-file-browser.nvim",
}
