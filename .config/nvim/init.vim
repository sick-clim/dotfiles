" Basic config
let mapleader = "\<Space>"

set shell=/bin/zsh
set number
set shiftwidth=4
set tabstop=4
set expandtab
set textwidth=0
set autoindent
set hlsearch
" set clipboard=unnamed
set clipboard+=unnamedplus

syntax off

set ignorecase
" set history=1000

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

" x は yank しない
nnoremap x "_x

" vim-plug
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ajmwagar/vim-deus'
Plug 'Yggdroot/indentLine'
Plug 'cohama/lexima.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/vim-goimports'
call plug#end()

" fzf
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>c :History:<CR>
nnoremap <Leader>r :Rg<CR>
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_layout = { 'window': { 'width': 1, 'height': 1  }  }

" git fugitive
nnoremap <Leader>d :Gdiffsplit<CR>
nnoremap <Leader>s :G<CR>

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
colorscheme deus
let g:airline_theme='deus'

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" coc-explorer
nmap <space>e <Cmd>CocCommand explorer<CR>

" Use `[h` and `]h` to navigate hunk
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

"スペースfmtでFormat
" nmap <silent> <space>mt <Plug>(coc-format)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

