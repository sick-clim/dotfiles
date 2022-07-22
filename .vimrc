

" encoding
set encoding=utf-8

set number
set title
set noswapfile
" if hidden is not set, TextEdit might fail.
set hidden
" always show signcolumns
set signcolumn=yes
" Better display for messages
set cmdheight=2
" more powerful backspacing
set backspace=indent,eol,start

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

" ESCx2 でハイライトの切替
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

set clipboard=unnamed,autoselect

" 不可視文字を表示：タブ>- 半角スペース.で表示
set list
set listchars=tab:»\ ,trail:-,extends:»,precedes:«,nbsp:% "space 対応"

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

" ALE
nmap ]a :ALENextWrap<CR>
nmap [a :ALEPreviousWrap<CR>
let g:ale_linters = {
    \ 'sh': ['bash-language_server','shellcheck'],
    \ }
let g:ale_fixers = {
    \ '*': ['trim_whitespace'],
    \ 'python': ['black','autoimport'],
    \ 'sh': ['shfmt'],
    \ }
let g:ale_fix_on_save = 0

" quickfix
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let mapleader = "\<Space>"

nnoremap <leader>a :cclose<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>r :Rg<CR>
"nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>d :Gdiffsplit<CR>
nnoremap <Leader>s :G<CR>
nnoremap <Leader>p :<C-u>CocList files<CR>

"fzf
"let g:fzf_preview_window = []

"open browser
let g:netrw_nogx = 1 "disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
nnoremap <Leader>o:<C-u>execute "OpenBrowser" "file:///".expand('%:p:gs?\\?/?')<CR>

nnoremap x "_x
inoremap ;; <Esc>

call plug#begin('~/.vim/plugged')
"Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'fatih/vim-go', { 'do': 'GoUpdateBinaries' }
"Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'cohama/lexima.vim'
"Plug 'w0rp/ale'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tyru/open-browser.vim'
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
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_auto_sameids = 1
let g:go_term_mode = 'split'

syntax on
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
colorscheme onedark
let g:airline_theme='onedark'


" Coc Extensions
let g:coc_global_extensions = [
            \'coc-sh',
            \'coc-pyright'
            \]
