if &compatible
  set nocompatible
endif

" install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'Shougo/deoplete.nvim'
" language pack
Plug 'sheerun/vim-polyglot'
" typescript
Plug 'Quramy/tsuquyomi'
" color schema
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" markdown
Plug 'joker1007/vim-markdown-quote-syntax'
" tree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" comment
Plug 'scrooloose/nerdcommenter'
" git, github
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
call plug#end()

filetype plugin indent on
syntax enable

let g:molokai_original = 1
let g:rehash256 = 1
if &term == "xterm-256color"
  colorscheme molokai
  hi Comment ctermfg=102
  hi Visual  ctermbg=236
  hi Delimiter ctermfg=none
endif

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

" vim-go
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

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
augroup markdown
  autocmd Filetype markdown highlight markdownHeadingDelimiter ctermfg=203
  autocmd Filetype markdown highlight markdownCodeDelimiter ctermfg=none
  autocmd Filetype markdown highlight markdownCode ctermfg=208
augroup END

" GitGutter
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg
hi GitGutterAdd ctermfg=154 ctermbg=none
hi GitGutterChange ctermfg=222 ctermbg=none
hi GitGutterDelete ctermfg=197 ctermbg=none
set updatetime=100

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
