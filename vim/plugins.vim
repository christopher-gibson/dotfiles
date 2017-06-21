" Plugins

call plug#begin()

" Navigation
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Konfekt/vim-smartbraces' " {} as paragraph navigation
Plug 'terryma/vim-smooth-scroll'

Plug 'vim-airline/vim-airline'

" ui related
Plug 'dietsche/vim-lastplace' " Reopen files at last edit place
Plug 'yggdroot/indentline' " Add vertical line for space indent

" git
Plug 'tpope/vim-fugitive' " Git wrapper

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Syntax
Plug 'sheerun/vim-polyglot' " Language pack
Plug 'w0rp/ale' " Lint engine
Plug 'hail2u/vim-css3-syntax'
Plug 'editorconfig/editorconfig-vim'

" Autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'mhartington/nvim-typescript', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/neocomplete.vim'
endif

Plug 'wokalski/autocomplete-flow'
Plug 'slashmili/alchemist.vim'
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Comments
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag' " Autoclose HTML tags
Plug 'valloric/matchtagalways' " Highlight HTML tags
Plug 'jiangmiao/auto-pairs' " Insert/delete in pairs

Plug 'svermeulen/vim-easyclip'
Plug 'ryanoasis/vim-devicons'

" Theme
Plug 'morhetz/gruvbox'


call plug#end()
