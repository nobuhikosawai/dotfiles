" install vim-plug if not installed
" https://github.com/junegunn/vim-plug/issues/739#issuecomment-516953621
let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path .
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path

call plug#begin('~/.vim/plugged')
" rails
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-bundler'
Plug 'thoughtbot/vim-rspec'
" language service (lsp)
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
" Plug 'glepnir/lspsaga.nvim'
Plug 'tami5/lspsaga.nvim' " use fork for now
Plug 'folke/trouble.nvim'
" snippets (for cmp)
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
" formatter
Plug 'jose-elias-alvarez/null-ls.nvim'
" tmux
Plug 'christoomey/vim-tmux-navigator'
" statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'kdheepak/tabline.nvim'
" motion
Plug 'phaazon/hop.nvim'
" textobjects
Plug 'wellle/targets.vim'
" color schema
Plug 'Julpikar/night-owl.nvim'
Plug 'cocopon/iceberg.vim'
Plug 'tanvirtin/monokai.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'ishan9299/nvim-solarized-lua'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'marko-cerovac/material.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'NTBBloodbath/doom-one.nvim'
Plug 'EdenEast/nightfox.nvim', { 'tag': 'v1.0.0' }
" indent
Plug 'lukas-reineke/indent-blankline.nvim'
" parenthis
Plug 'tpope/vim-surround'
" fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" markdown
Plug 'joker1007/vim-markdown-quote-syntax'
Plug 'skanehira/preview-markdown.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'SidOfc/mkdx'
Plug 'jakewvincent/mkdnflow.nvim'
" writing
Plug 'junegunn/goyo.vim'
" note taking
Plug 'renerocksai/calendar-vim'
Plug 'renerocksai/telekasten.nvim'
" yaml
Plug 'pedrohdz/vim-yaml-folds'
" filer
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'yuki-yano/fern-preview.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'p00f/nvim-ts-rainbow'
Plug 'mfussenegger/nvim-ts-hint-textobject'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
" comment
Plug 'numToStr/Comment.nvim'
" git, github
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'rbgrouleff/bclose.vim'
Plug 'iberianpig/tig-explorer.vim'
Plug 'pwntester/octo.nvim'
" dispatch
Plug 'tpope/vim-dispatch'
" coplilot
" Plug 'github/copilot.vim'
" terminal
Plug 'akinsho/toggleterm.nvim'
call plug#end()

if plug_install
    PlugInstall --sync
endif
unlet plug_install

filetype plugin indent on
syntax enable

" enable 24bit true color
set termguicolors
" let g:gruvbox_material_palette = 'original'
" colorscheme monokai_pro
" let g:tokyonight_transparent = 'true'
" colorscheme tokyonight
" colorscheme nord
" colorscheme doom-one
" colorscheme nightfox

set encoding=utf-8

" display position
set number
set ruler

" display unseen chars
" https://maku77.github.io/vim/settings/show-space.html
set listchars=tab:>.,trail:_
set list

" User backspace key to delete
set backspace=2

" Improve search
set hlsearch
set ignorecase
set smartcase

" display command
set showcmd

" indent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
" use mouse
set mouse=a
" clipboard
set clipboard+=unnamed
set autoread
set cursorline

" leader
let g:mapleader = "\<Space>"

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" ruby
autocmd FileType ruby setl iskeyword+=?

" vim-yaml-folds
set foldlevelstart=20

" # Plugin settings
" ## vim-go
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0
let g:go_metalinter_autosave = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_doc_keywordprg_enabled = 0

" ## Fern
" ref: https://github.com/lambdalisue/dotfiles/blob/master/nvim/plugin.d/fern.vim
function! s:smart_path() abort
  if !empty(&buftype) || bufname('%') =~# '^[^:]\+://'
    return fnameescape(fnamemodify('.', ':p'))
  endif
  return fnameescape(fnamemodify(expand('%'), ':p:h'))
endfunction
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle<CR>
nnoremap <silent> <Leader>ee :<C-u>Fern <C-r>=<SID>smart_path()<CR> -reveal=%:p<CR>
nnoremap <silent> <Leader>EE :<C-u>Fern . -drawer -toggle -reveal=%<CR>
let g:fern#renderer = "nerdfont"
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
  nmap <silent> <buffer> <expr> <Plug>(fern-quit-or-close-preview) fern_preview#smart_preview("\<Plug>(fern-action-preview:close)", ":q\<CR>")
  nmap <silent> <buffer> q <Plug>(fern-quit-or-close-preview)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

nnoremap <silent> [b :bprev<CR>
nnoremap <silent> ]b :bnext<CR>

" ## Markdown Syntax
let g:markdown_quote_syntax_filetypes = {
      \ "typescript": {
      \   "start": "\\%(typescript\\|ts\\)",
      \   },
      \ }
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:preview_markdown_parser = 'glow'
augroup markdown
  autocmd Filetype markdown highlight markdownHeadingDelimiter ctermfg=203
  autocmd Filetype markdown highlight markdownCodeDelimiter ctermfg=none
  autocmd Filetype markdown highlight markdownCode ctermfg=208
augroup END

" # Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-w>h :TmuxNavigateLeft<CR>
nnoremap <silent> <C-w>j :TmuxNavigateDown<CR>
nnoremap <silent> <C-w>k :TmuxNavigateUp<CR>
nnoremap <silent> <C-w>l :TmuxNavigateRight<CR>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<CR>

" rspec
" RSpec.vim appings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>
" Use with dispatch
let g:rspec_command = "Dispatch DATABASE_PASSWORD='' DATABASE_URL=mysql2://root:@localhost bundle exec rspec {spec}"

" # Scripts
" ## SyntaxInfo
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

" ## auto-mkdir
augroup vimrc-auto-mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)  " {{{
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}

" ## auto pastemode
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

" ## treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
    disable = { "vim" },
    extended_mode = true,
    max_file_lines = nil,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ak"] = "@class.outer",
        ["ik"] = "@class.inner",
        ["ip"] = "@parameter.inner",
        ["as"] = "@statement.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ic"] = "@conditional.inner",
        ["ac"] = "@conditional.outer",
      },
    },
  },
  ensure_installed = { },
}
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
require('gitsigns').setup{}
require('Comment').setup{}
require('lualine').setup{
  options = {
    globalstatus = true,
  },
}
require("tabline").setup{}
require('hop').setup{}
require('nvim-autopairs').setup{}

-- # lsp
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)



  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup snippet
local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = prequire('luasnip')
local cmp = prequire("cmp")

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }
})

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_next_item()
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
        return t "<Tab>"
    else
        cmp.complete()
    end
    return ""
end
_G.s_tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        returnt "<S-Tab>"
    end
    return ""
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {}) 

-- Setup lspkind
local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  }
}

-- Setup null-ls
local async_formatting = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        { textDocument = { uri = vim.uri_from_bufnr(bufnr) } },
        function(err, res, ctx)
            if err then
                local err_msg = type(err) == "string" and err or err.message
                -- you can modify the log message / level (or ignore it completely)
                vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
                return
            end

            -- don't apply results if buffer is unloaded or has been modified
            if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
                return
            end

            if res then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd("silent noautocmd update")
                end)
            end
        end
    )
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls = require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.prettier,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    async_formatting(bufnr)
                end,
            })
        end
    end,
})

-- Lsp Installer
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
      capabilities = capabilities
    }
    -- Use null-ls for formatting
    if server.name == "tsserver" then
      opts.on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
      end
    end
    -- if server.name == "volar" then
    --   opts.on_attach = function(client)
    --     client.resolved_capabilities.document_formatting = false
    --     client.resolved_capabilities.document_range_formatting = false
    --   end
    -- end
    server:setup(opts)
end)

-- Setup lsp-saga
local saga = require 'lspsaga'
saga.init_lsp_saga {
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = true,
  },
}

-- Setup trouble
require("trouble").setup {}
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)

-- Setup octo
require"octo".setup({
  default_remote = {"upstream", "origin"}; -- order to try remotes
  reaction_viewer_hint_icon = "";         -- marker for user reactions
  user_icon = " ";                        -- user icon
  timeline_marker = "";                   -- timeline marker
  timeline_indent = "2";                   -- timeline indentation
  right_bubble_delimiter = "";            -- Bubble delimiter
  left_bubble_delimiter = "";             -- Bubble delimiter
  github_hostname = "";                    -- GitHub Enterprise host
  snippet_context_lines = 4;               -- number or lines around commented lines
  file_panel = {
    size = 10,                             -- changed files panel rows
    use_icons = true                       -- use web-devicons in file panel
  },
  mappings = {
    issue = {
      close_issue = "<space>ic",           -- close issue
      reopen_issue = "<space>io",          -- reopen issue
      list_issues = "<space>il",           -- list open issues on same repo
      reload = "<C-r>",                    -- reload issue
      open_in_browser = "<C-b>",           -- open issue in browser
      copy_url = "<C-y>",                  -- copy url to system clipboard
      add_assignee = "<space>aa",          -- add assignee
      remove_assignee = "<space>ad",       -- remove assignee
      create_label = "<space>lc",          -- create label
      add_label = "<space>la",             -- add label
      remove_label = "<space>ld",          -- remove label
      goto_issue = "<space>gi",            -- navigate to a local repo issue
      add_comment = "<space>ca",           -- add comment
      delete_comment = "<space>cd",        -- delete comment
      next_comment = "]c",                 -- go to next comment
      prev_comment = "[c",                 -- go to previous comment
      react_hooray = "<space>rp",          -- add/remove 🎉 reaction
      react_heart = "<space>rh",           -- add/remove ❤️ reaction
      react_eyes = "<space>re",            -- add/remove 👀 reaction
      react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
      react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
      react_rocket = "<space>rr",          -- add/remove 🚀 reaction
      react_laugh = "<space>rl",           -- add/remove 😄 reaction
      react_confused = "<space>rc",        -- add/remove 😕 reaction
    },
    pull_request = {
      checkout_pr = "<space>po",           -- checkout PR
      merge_pr = "<space>pm",              -- merge PR
      list_commits = "<space>pc",          -- list PR commits
      list_changed_files = "<space>pf",    -- list PR changed files
      show_pr_diff = "<space>pd",          -- show PR diff
      add_reviewer = "<space>va",          -- add reviewer
      remove_reviewer = "<space>vd",       -- remove reviewer request
      close_issue = "<space>ic",           -- close PR
      reopen_issue = "<space>io",          -- reopen PR
      list_issues = "<space>il",           -- list open issues on same repo
      reload = "<C-r>",                    -- reload PR
      open_in_browser = "<C-b>",           -- open PR in browser
      copy_url = "<C-y>",                  -- copy url to system clipboard
      add_assignee = "<space>aa",          -- add assignee
      remove_assignee = "<space>ad",       -- remove assignee
      create_label = "<space>lc",          -- create label
      add_label = "<space>la",             -- add label
      remove_label = "<space>ld",          -- remove label
      goto_issue = "<space>gi",            -- navigate to a local repo issue
      add_comment = "<space>ca",           -- add comment
      delete_comment = "<space>cd",        -- delete comment
      next_comment = "]c",                 -- go to next comment
      prev_comment = "[c",                 -- go to previous comment
      react_hooray = "<space>rp",          -- add/remove 🎉 reaction
      react_heart = "<space>rh",           -- add/remove ❤️ reaction
      react_eyes = "<space>re",            -- add/remove 👀 reaction
      react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
      react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
      react_rocket = "<space>rr",          -- add/remove 🚀 reaction
      react_laugh = "<space>rl",           -- add/remove 😄 reaction
      react_confused = "<space>rc",        -- add/remove 😕 reaction
    },
    review_thread = {
      goto_issue = "<space>gi",            -- navigate to a local repo issue
      add_comment = "<space>ca",           -- add comment
      add_suggestion = "<space>sa",        -- add suggestion
      delete_comment = "<space>cd",        -- delete comment
      next_comment = "]c",                 -- go to next comment
      prev_comment = "[c",                 -- go to previous comment
      select_next_entry = "]q",            -- move to previous changed file
      select_prev_entry = "[q",            -- move to next changed file
      close_review_tab = "<C-c>",          -- close review tab
      react_hooray = "<space>rp",          -- add/remove 🎉 reaction
      react_heart = "<space>rh",           -- add/remove ❤️ reaction
      react_eyes = "<space>re",            -- add/remove 👀 reaction
      react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
      react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
      react_rocket = "<space>rr",          -- add/remove 🚀 reaction
      react_laugh = "<space>rl",           -- add/remove 😄 reaction
      react_confused = "<space>rc",        -- add/remove 😕 reaction
    },
    submit_win = {
      approve_review = "<C-a>",            -- approve review
      comment_review = "<C-m>",            -- comment review
      request_changes = "<C-r>",           -- request changes review
      close_review_tab = "<C-c>",          -- close review tab
    },
    review_diff = {
      add_review_comment = "<space>ca",    -- add a new review comment
      add_review_suggestion = "<space>sa", -- add a new review suggestion
      focus_files = "<leader>e",           -- move focus to changed file panel
      toggle_files = "<leader>b",          -- hide/show changed files panel
      next_thread = "]t",                  -- move to next thread
      prev_thread = "[t",                  -- move to previous thread
      select_next_entry = "]q",            -- move to previous changed file
      select_prev_entry = "[q",            -- move to next changed file
      close_review_tab = "<C-c>",          -- close review tab
      toggle_viewed = "<leader><space>",   -- toggle viewer viewed state
    },
    file_panel = {
      next_entry = "j",                    -- move to next changed file
      prev_entry = "k",                    -- move to previous changed file
      select_entry = "<cr>",               -- show selected changed file diffs
      refresh_files = "R",                 -- refresh changed files panel
      focus_files = "<leader>e",           -- move focus to changed file panel
      toggle_files = "<leader>b",          -- hide/show changed files panel
      select_next_entry = "]q",            -- move to previous changed file
      select_prev_entry = "[q",            -- move to next changed file
      close_review_tab = "<C-c>",          -- close review tab
      toggle_viewed = "<leader><space>",   -- toggle viewer viewed state
    }
  }
})

--- Setup toggleterm
require("toggleterm").setup{}

-- Setup nightfox color theme
require('nightfox').setup({
  options = {
    transparent = true,
  }
})

vim.cmd("colorscheme nightfox")


local home = vim.fn.expand("~/zettelkasten")
require('telekasten').setup({
    home         = home,

    -- if true, telekasten will be enabled when opening a note within the configured home
    take_over_my_home = true,

    -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
    --                               and thus the telekasten syntax will not be loaded either
    auto_set_filetype = true,

    -- dir names for special notes (absolute path or subdir name)
    dailies      = home .. '/' .. 'daily',
    weeklies     = home .. '/' .. 'weekly',
    templates    = home .. '/' .. 'templates',

    -- image (sub)dir for pasting
    -- dir name (absolute path or subdir name)
    -- or nil if pasted images shouldn't go into a special subdir
    image_subdir = "img",

    -- markdown file extension
    extension    = ".md",

    -- prefix file with uuid
    prefix_title_by_uuid = false,
    -- file uuid type ("rand" or input for os.date()")
    uuid_type = "%Y%m%d%H%M",
    -- UUID separator
    uuid_sep = "-",

    -- following a link to a non-existing note will create it
    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,

    -- template for new notes (new_note, follow_link)
    -- set to `nil` or do not specify if you do not want a template
    template_new_note = home .. '/' .. 'templates/new_note.md',

    -- template for newly created daily notes (goto_today)
    -- set to `nil` or do not specify if you do not want a template
    template_new_daily = home .. '/' .. 'templates/daily.md',

    -- template for newly created weekly notes (goto_thisweek)
    -- set to `nil` or do not specify if you do not want a template
    template_new_weekly= home .. '/' .. 'templates/weekly.md',

    -- image link style
    -- wiki:     ![[image name]]
    -- markdown: ![](image_subdir/xxxxx.png)
    image_link_style = "markdown",

    -- integrate with calendar-vim
    plug_into_calendar = true,
    calendar_opts = {
        -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
        weeknm = 4,
        -- use monday as first day of week: 1 .. true, 0 .. false
        calendar_monday = 1,
        -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
        calendar_mark = 'left-fit',
    },

    -- telescope actions behavior
    close_after_yanking = false,
    insert_after_inserting = true,

    -- tag notation: '#tag', ':tag:', 'yaml-bare'
    tag_notation = "#tag",

    -- command palette theme: dropdown (window) or ivy (bottom panel)
    command_palette_theme = "ivy",

    -- tag list theme:
    -- get_cursor: small tag list at cursor; ivy and dropdown like above
    show_tags_theme = "ivy",

    -- when linking to a note in subdir/, create a [[subdir/title]] link
    -- instead of a [[title only]] link
    subdirs_in_links = true,

    -- template_handling
    -- What to do when creating a new note via `new_note()` or `follow_link()`
    -- to a non-existing note
    -- - prefer_new_note: use `new_note` template
    -- - smart: if day or week is detected in title, use daily / weekly templates (default)
    -- - always_ask: always ask before creating a note
    template_handling = "smart",

    -- path handling:
    --   this applies to:
    --     - new_note()
    --     - new_templated_note()
    --     - follow_link() to non-existing note
    --
    --   it does NOT apply to:
    --     - goto_today()
    --     - goto_thisweek()
    --
    --   Valid options:
    --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
    --              all other ones in home, except for notes/with/subdirs/in/title.
    --              (default)
    --
    --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
    --                    except for notes with subdirs/in/title.
    --
    --     - same_as_current: put all new notes in the dir of the current note if
    --                        present or else in home
    --                        except for notes/with/subdirs/in/title.
    new_note_location = "smart",

    -- should all links be updated when a file is renamed
    rename_update_links = true,
})

require('mkdnflow').setup({
    -- Config goes here; leave blank for defaults
})
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" ## telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ## hop
nnoremap <leader>hp <cmd>HopPattern<cr>
nnoremap <leader>hc <cmd>HopChar2<cr>
nnoremap <leader>hw <cmd>HopWord<cr>

" ## nvim-ts-hint-textobject
omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
vnoremap <silent> m :lua require('tsht').nodes()<CR>

" ## lspsaga
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent><leader>gr :Lspsaga rename<CR>
nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR> -- or open_float_terminal('lazygit')<CR>
tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>

let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 1 } }
