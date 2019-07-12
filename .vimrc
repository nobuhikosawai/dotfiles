if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  " javascript
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')
  " typescript
  call dein#add('leafgarland/typescript-vim')
  call dein#add('Quramy/tsuquyomi')
  " color schema
  call dein#add('tomasr/molokai')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  " markdown
  call dein#add('joker1007/vim-markdown-quote-syntax')
  " tree
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

set encoding=utf-8

" display position
set number
set ruler

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

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline_theme = 'simple'
let g:airline_theme = 'minimalist'

" Markdown Syntax
let g:markdown_quote_syntax_filetypes = {
      \ "typescript": {
      \   "start": "\\%(typescript\\|ts\\)",
      \   },
      \ }
