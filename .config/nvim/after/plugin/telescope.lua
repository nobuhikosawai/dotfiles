if (not pcall(require, "telescope")) then
  return
end

local builtin = require("telescope.builtin")
local fb_actions = require "telescope".extensions.file_browser.actions

require("telescope").load_extension "file_browser"

require("telescope").setup {
  defaults = {
    layout_config = { height = 40 }
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
}

-- Files
vim.keymap.set('n', '<leader>fg', function()
  builtin.live_grep()
end)
vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files()
end)

-- Nvim
vim.keymap.set('n', '<leader>fb', function()
  builtin.buffers()
end)
vim.keymap.set('n', '<leader>fh', function()
  builtin.help_tags()
end)

-- File browser
local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end
 
vim.keymap.set("n", "<leader>fe", function()
  require('telescope').extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    initial_mode = "normal",
  })
end)

