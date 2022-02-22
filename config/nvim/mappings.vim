" Use space as leader
let mapleader=" "

" Reload config
nnoremap <leader>R :source $MYVIMRC<CR>

" Buffers
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>q :bp <BAR> bd #<CR>

" Select everything
nmap <leader>a ggVG

" Too much shiftiness
:nmap ; :

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
