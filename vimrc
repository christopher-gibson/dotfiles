" MacVim Settings

set nocompatible

syntax on
filetype off
filetype plugin indent on

set timeoutlen=1000
set ttimeoutlen=0
set ttyfast
set visualbell
set noerrorbells
set showcmd


set background=dark
set termguicolors
set colorcolumn=80
set cursorline

" Enable mouse but hide when typing
set mouse=a
set mousehide

set clipboard=unnamed
set history=100
set shortmess+=aAIsT

" Show relative line numbers
set number
set relativenumber
set ruler

set scrolloff=5
set sidescroll=1
set sidescrolloff=5

set wildmenu
set wildmode=longest:full,full

" Wrapping
set nowrap
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start

set hidden " Hide buffers instead of closing
set autoread " Update file when changed outside vim

" Set tabs to 2 spaces
set expandtab
set shiftround
set shiftwidth=2
set softtabstop=2
set tabstop=2
set autoindent

set nojoinspaces
set nofoldenable
set splitbelow
set splitright

" Show tab, trailing spaces and nbsp
set list
set listchars=tab:>·,trail:·,nbsp:¬

" Use smart case and highlight searches as you type
set hlsearch
set incsearch
set ignorecase
set smartcase

" No backups
set nobackup
set nowritebackup
set noswapfile

" Set undo storage
set undodir=~/.vim/undo
set undofile
set undolevels=1000

if !&readonly
  set fileencoding=utf-8
endif

" Use space as leader
let mapleader=" "

" Reload config
nnoremap <leader>R :source $MYVIMRC<CR>

" Buffers
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>q :bp <BAR> bd #<CR>

" Add new line outside insert
nnoremap <cr> o<esc>

" Move to beginning/end of line
noremap H ^
noremap L $

" Keep selection after indent
vnoremap < <gv
vnoremap > >gv

" Clear search
nmap <silent> <leader>c :nohlsearch<CR>

" Use arrows to adjust window size
noremap <right> <C-w>10>
noremap <left> <C-w>10<
noremap <up> <C-w>10+
noremap <down> <C-w>10-

augroup vimrcEx
  autocmd!

  " Disable auto comment
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  " Only show a cursorline in the active window
  autocmd WinLeave * set nocursorline
  autocmd WinEnter * set cursorline
  autocmd InsertEnter * set nocursorline
  autocmd InsertLeave * set cursorline
augroup END

source $HOME/.vim/plugins.vim
source $HOME/.vim/plugins-config.vim
