

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
set autowrite

set wildmenu
set laststatus=2
set spelllang=en,cjk

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

nnoremap <leader>a :cclose<CR>
nnoremap <Leader>l :Buffers<CR>
nnoremap <Leader>f :Files<CR>
"nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>d :Gdiff<CR>
nnoremap <Leader>s :Gstatus<CR>

nnoremap x "_x

call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'fatih/vim-go', { 'do': 'GoUpdateBinaries' }
"Plug 'AndrewRadev/splitjoin.vim'
"Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'cohama/lexima.vim'
Plug 'w0rp/ale'
call plug#end()

autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
"autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_auto_sameids = 1

syntax on
let g:airline_powerline_fonts = 1
colorscheme onedark
let g:airline_theme='onedark'
