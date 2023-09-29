return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- stylua: ignore
    keys = {
      { "<space>fg", function() require("telescope.builtin").live_grep() end,  desc = "Telescope live_grep", },
      { "<space>ff", function() require("telescope.builtin").find_files() end, desc = "Telescope find_files", },
      { "<space>fb", function() require("telescope.builtin").buffers() end,    desc = "Telescope find_buffers", },
      { "<space>fs", function() require("telescope.builtin").git_status({initial_mode = 'normal'}) end,    desc = "Telescope git_status", },
      -- Telescope plugin commands
      -- File browser
      {
        "<space>fe",
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
      -- neoclip
      { "<space>fy", "<cmd>Telescope neoclip<cr>",                                       desc = "Telescope neoclip" },
      -- frecency
      { "<space>fR", "<cmd>Telescope frecency<cr>",                                      desc = "Telescope frecency" },
      -- recent_files
      { "<space>fr", "<cmd>lua require('telescope').extensions.recent_files.pick()<CR>", desc = "Telescope recent_files" },
      --harpoon
      { "<space>fh", "<cmd>Telescope harpoon marks<cr>",                                 desc = "Telescope harpoon marks" },
    },
    config = function()
      local fb_actions = require("telescope").extensions.file_browser.actions

      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("neoclip")
      require("telescope").load_extension("frecency")
      require("telescope").load_extension("recent_files")
      require("telescope").load_extension("harpoon")

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
          layout_config = {
            horizontal = {
              prompt_position = "top",
            },
          },
          sorting_strategy = "ascending",
          mappings = {
            n = {
              ["<C-d>"] = require("telescope.actions").delete_buffer,
            },
            i = {
              ["<C-w>"] = "which_key",
              ["<C-d>"] = require("telescope.actions").delete_buffer,
            },
          },
        },
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
          buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
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
          frecency = {
            show_unindexed = false,
            default_workspace = ":CWD:",
          },
          recent_files = {
            only_cwd = true,
          },
        },
      })
    end,
  },

  -- Filer
  "nvim-telescope/telescope-file-browser.nvim",

  -- Frequency
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = { "kkharji/sqlite.lua" },
  },

  { "smartpde/telescope-recent-files" },
}
