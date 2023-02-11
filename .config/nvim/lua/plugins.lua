local status, packer = pcall(require, 'packer')
if (not status) then
  print('Packer is not installed')
  return
end

vim.cmd [[packadd packer.nvim]]

return packer.startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use 'EdenEast/nightfox.nvim'
  use 'https://gitlab.com/__tpb/monokai-pro.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'folke/tokyonight.nvim'
  use 'cocopon/iceberg.vim'

  -- Background
  use 'xiyaowong/nvim-transparent'

  -- Statusline
  use { 'nvim-lualine/lualine.nvim', requires = {'nobuhikosawai/nvim-web-devicons', branch='support-ext-convention'} }
  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = {'nobuhikosawai/nvim-web-devicons', branch='support-ext-convention'} }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { 'nvim-lua/plenary.nvim' } } 

  -- Filer
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
    'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      requires = { 
        'nvim-lua/plenary.nvim',
        {'nobuhikosawai/nvim-web-devicons', branch='support-ext-convention'},
        'MunifTanjim/nui.nvim',
      }
  }

  -- LSP
  use { 'neovim/nvim-lspconfig', requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim'
  }}
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use { 'hrsh7th/nvim-cmp', requires = { 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' } }
  use 'onsails/lspkind-nvim'
  ----  Language specific plugins
  use 'jose-elias-alvarez/typescript.nvim'

  -- Additional LSP related plugins
  use { "glepnir/lspsaga.nvim", branch = "main" }
  use { 'folke/trouble.nvim', requires =  { {'nobuhikosawai/nvim-web-devicons', branch='support-ext-convention'} } }
  use 'stevearc/aerial.nvim'
  use "RRethy/vim-illuminate"

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'
  use 'p00f/nvim-ts-rainbow'
  use 'windwp/nvim-ts-autotag'
  use 'andymass/vim-matchup'

  -- Parenthesis
  use "windwp/nvim-autopairs"
  use({ 'kylechui/nvim-surround', tag = "*" })

  -- Formatter
  use { "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } }

  -- Comment
  use 'numToStr/Comment.nvim'

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'dinhhuy258/git.nvim'

  -- Github
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      {'nobuhikosawai/nvim-web-devicons', branch='support-ext-convention'},
    },
  }

  -- Indent line
  use 'lukas-reineke/indent-blankline.nvim'

  -- Motion
  use 'ggandor/leap.nvim'
  use { 'phaazon/hop.nvim', branch = 'v2' }

  -- Tmux
  use 'alexghergh/nvim-tmux-navigation'

  -- Terminal
  use {"akinsho/toggleterm.nvim", tag = '*' }

  -- Markdown
  use { 'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install']() end }

  -- Frontend
  use "norcalli/nvim-colorizer.lua"

  -- Test
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest"
    }
  }

  -- Cheat sheet
  use { "folke/which-key.nvim" }

  -- Session
  use { 'rmagatti/auto-session' }

  -- Yank
  use { "AckslD/nvim-neoclip.lua",
    requires = {
      {'nvim-telescope/telescope.nvim'},
    },
  }
end)
