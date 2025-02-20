return {
  {
    "alexghergh/nvim-tmux-navigation",
    enabled = true,
    lazy = false,
    opts = {
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
        left = "<C-w>h",
        down = "<C-w>j",
        up = "<C-w>k",
        right = "<C-w>l",
      },
    },
  },
}
