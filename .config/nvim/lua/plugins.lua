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
  local colorscheme = 'nightfox.nvim'
  use 'EdenEast/nightfox.nvim'

  -- Statusline
  use { 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons' }
  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { 'nvim-lua/plenary.nvim' } } 

  -- Filer
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
    'nvim-neo-tree/neo-tree.nvim',
      branch = 'v2.x',
      requires = { 
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
      }
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use { 'hrsh7th/nvim-cmp', requires = { 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' } }
  use 'onsails/lspkind-nvim'

  -- Additional LSP related plugins
  use { "glepnir/lspsaga.nvim", branch = "main" }
  use { 'folke/trouble.nvim', requires =  { 'kyazdani42/nvim-web-devicons' } }
  use 'stevearc/aerial.nvim'
  use "RRethy/vim-illuminate"

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
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
      'kyazdani42/nvim-web-devicons',
    },
  }

  -- Indent line
  use 'lukas-reineke/indent-blankline.nvim'

  -- Motion
  use 'ggandor/leap.nvim'
  use { 'phaazon/hop.nvim', branch = 'v2' }

  -- tmux
  use 'alexghergh/nvim-tmux-navigation'

  -- terminal
  use {"akinsho/toggleterm.nvim", tag = '*' }

  -- Markdown
  use { 'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install']() end }

end)
