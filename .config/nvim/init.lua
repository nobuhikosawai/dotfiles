vim.g.mapleader = " " -- call this before setting up lazy.nvim

require("config.lazy")

-- Settings
vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.ruler = true
vim.wo.listchars = "tab:>.,trail:_" --https://maku77.github.io/vim/settings/show-space.html
vim.opt.list = true
vim.opt.iskeyword:append("-")
vim.opt.swapfile = false
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
vim.opt.clipboard:append({ "unnamedplus" })
vim.opt.autoread = true
vim.opt.cursorline = true

-- highlight yank
vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "highlight_yank",
	pattern = "*",
	callback = function()
		require("vim.highlight").on_yank()
	end,
})

vim.opt.termguicolors = true
vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("rose-pine")

vim.filetype.add({
	extension = {
		mdx = 'mdx'
	}
})

-- switch window
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w><C-j>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w><C-k>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w><C-l>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w><C-h>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>bd", ":bp|bd #<CR>", { noremap = true })
