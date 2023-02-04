if (not pcall(require, "telescope")) then
  return
end

local builtin = require("telescope.builtin")
local fb_actions = require "telescope".extensions.file_browser.actions

require("telescope").load_extension "file_browser"

local telescopeConfig = require("telescope.config")
-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

require("telescope").setup {
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

