" Test 2
set nocompatible              " be iMproved, required
filetype off                  " required

" turn absolute line numbers on
:set number relativenumber
:set nu rnu

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Press F3 to paste text without autoindent
set pastetoggle=<F3>

" Highlight dynamically as pattern is typed
set incsearch

" Enable syntax highlighting
syntax on

"colorscheme
:colorscheme delek
set background=dark

