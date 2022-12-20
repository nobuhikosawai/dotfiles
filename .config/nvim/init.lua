require('plugins')

-- Settings
vim.opt.encoding = 'utf-8'
vim.opt.number = true
vim.opt.ruler = true
vim.wo.listchars = 'tab:>.,trail:_' --https://maku77.github.io/vim/settings/show-space.html
vim.opt.list = true
-- User backspace key to delete
vim.opt.backspace = "2"
-- Improve search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- display command
vim.opt.showcmd = true
-- indent
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- use mouse
vim.opt.mouse = "a"
-- clipboard
vim.opt.clipboard:append{'unnamedplus'}
vim.opt.autoread = true
vim.opt.cursorline = true

vim.g.mapleader = " "

vim.opt.termguicolors = true
vim.cmd("colorscheme monokaipro")
