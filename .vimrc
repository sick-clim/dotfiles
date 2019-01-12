

" encoding
set encoding=utf-8

set number
set noswapfile
set hidden

set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set shiftwidth=4

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

set wildmenu
set laststatus=2

let mapleader = "\<Space>"

nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Files<CR>
"nnoremap <Leader>f :GFiles<CR>

call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'fatih/vim-go'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
call plug#end()

syntax on
let g:airline_powerline_fonts = 1
colorscheme onedark
let g:airline_theme='onedark'
