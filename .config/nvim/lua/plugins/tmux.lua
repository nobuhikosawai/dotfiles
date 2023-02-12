return {
  {
    "alexghergh/nvim-tmux-navigation",
    lazy = false,
    -- config = function()
    --
    --       require'nvim-tmux-navigation'.setup {
    --         disable_when_zoomed = true, -- defaults to false
    --         keybindings = {
    --             left = "<C-h>",
    --             down = "<C-j>",
    --             up = "<C-k>",
    --             right = "<C-l>",
    --             last_active = "<C-\\>",
    --             next = "<C-Space>",
    --         }
    --     }
    -- end
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
