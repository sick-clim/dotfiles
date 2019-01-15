

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

" Move between open buffers.
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Emacs-like bingind in insert mode
nmap <C-e> <C-o>$
nmap <C-a> <C-o>0

" Windws movement shortcuts
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

let mapleader = "\<Space>"

nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Files<CR>
"nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>d :Gdiff<CR>
nnoremap <Leader>s :Gstatus<CR>

call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'fatih/vim-go', { 'do': 'GoUpdateBinaries' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
call plug#end()

syntax on
let g:airline_powerline_fonts = 1
colorscheme onedark
let g:airline_theme='onedark'
