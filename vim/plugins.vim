" Plugins

# Automatically install plug
# https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Navigation
" Plug 'easymotion/vim-easymotion'
" Plug 'scrooloose/nerdtree'
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'camspiers/snap'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'Konfekt/vim-smartbraces' " {} as paragraph navigation
Plug 'dietsche/vim-lastplace' " Reopen files at last edit place

" Sorting
Plug 'christoomey/vim-sort-motion'

" ui related
Plug 'vim-airline/vim-airline'
Plug 'yggdroot/indentline' " Add vertical line for space indent

" git
Plug 'tpope/vim-fugitive' " Git wrapper

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Syntax
Plug 'sheerun/vim-polyglot' " Language pack
" Plug 'hail2u/vim-css3-syntax'
Plug 'editorconfig/editorconfig-vim'

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale' " Lint engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'terryma/vim-multiple-cursors'

Plug 'mileszs/ack.vim'

" Plug 'flowtype/vim-flow'

" Comments
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'valloric/matchtagalways' " Highlight HTML tags
Plug 'jiangmiao/auto-pairs' " Insert/delete in pairs

Plug 'svermeulen/vim-easyclip'
Plug 'ryanoasis/vim-devicons'

" Theme
Plug 'morhetz/gruvbox'


call plug#end()
