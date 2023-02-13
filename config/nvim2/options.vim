set nocompatible
set encoding=utf8

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

