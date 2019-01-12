
let mapleader = "\<Space>"

set number
set noswapfile

nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :GFiles<CR>

call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()


