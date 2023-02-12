local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup {
  -- colorscheme
  'EdenEast/nightfox.nvim',
  'https://gitlab.com/__tpb/monokai-pro.nvim',
  { "catppuccin/nvim", name = "catppuccin" },
  'folke/tokyonight.nvim',
  'cocopon/iceberg.vim',

  -- Background
  'xiyaowong/nvim-transparent',

  -- Statusline
  { 'nvim-lualine/lualine.nvim', dependencies = {'nobuhikosawai/nvim-web-devicons', branch='support-ext-convention'} },
  { 'akinsho/bufferline.nvim', version = "v3.*", dependencies = {'nobuhikosawai/nvim-web-devicons', branch='support-ext-convention'} },

  -- Telescope
  { 'nvim-telescope/telescope.nvim', version = '0.1.0', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Filer
  'nvim-telescope/telescope-file-browser.nvim',
  {
    'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        {'nobuhikosawai/nvim-web-devicons', branch='support-ext-convention'},
        'MunifTanjim/nui.nvim',
      }
  },

  -- LSP
  { 'neovim/nvim-lspconfig', dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim'
  }},
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  { 'hrsh7th/nvim-cmp', dependencies = { 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' } },
  'onsails/lspkind-nvim',
  ----  Language specific plugins
  'jose-elias-alvarez/typescript.nvim',

  -- Additional LSP related plugins
  { "glepnir/lspsaga.nvim", branch = "main" },
  { 'folke/trouble.nvim', dependencies =  { {'nobuhikosawai/nvim-web-devicons', branch='support-ext-convention'} } },
  'stevearc/aerial.nvim',
  "RRethy/vim-illuminate",

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/playground',
  'p00f/nvim-ts-rainbow',
  'windwp/nvim-ts-autotag',
  'andymass/vim-matchup',

  -- Parenthesis
  "windwp/nvim-autopairs",
  { 'kylechui/nvim-surround', version = "*" },

  -- Formatter
  { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Comment
  'numToStr/Comment.nvim',

  -- Git
  'lewis6991/gitsigns.nvim',
  { 'TimUntersberger/neogit', dependencies = 'nvim-lua/plenary.nvim' },
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  'dinhhuy258/git.nvim',

  -- Github
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      {'nobuhikosawai/nvim-web-devicons', branch='support-ext-convention'},
    },
  },

  -- Indent line
  'lukas-reineke/indent-blankline.nvim',

  -- Motion
  'ggandor/leap.nvim',
  { 'phaazon/hop.nvim', branch = 'v2' },

  -- Tmux
  'alexghergh/nvim-tmux-navigation',

  -- Terminal
  {"akinsho/toggleterm.nvim", version = '*' },

  -- Markdown
  { 'iamcco/markdown-preview.nvim', build = function() vim.fn['mkdp#util#install']() end },

  -- Frontend
  "norcalli/nvim-colorizer.lua",

  -- Test
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest"
    }
  },

  -- Cheat sheet
  { "folke/which-key.nvim" },

  -- Session
  { 'rmagatti/auto-session' },

  -- Yank
  { "AckslD/nvim-neoclip.lua",
    dependencies = {
      {'nvim-telescope/telescope.nvim'},
    },
  },
}
