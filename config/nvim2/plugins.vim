" Devicons
let g:WebDevIconsOS='Darwin'
let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:DevIconsEnableFoldersOpenClose=1

" Editorconfig
let g:EditorConfig_exclude_patterns=['fugitive://.*', 'scp://.*']

" Polyglot
let g:jsx_ext_required=0
let g:vim_markdown_conceal=0
let g:javascript_plugin_flow= 1
let g:javascript_plugin_jsdoc=1


" Airline
  set laststatus=2 " Always show airline
  set noshowmode

  let g:airline_powerline_fonts=1
  let g:airline#extensions#tabline#enabled=1
  let g:airline_theme='base16_gruvbox_dark_medium'
  let g:airline_left_sep=''
  let g:airline_left_alt_sep=''
  let g:airline_right_sep=''
  let g:airline_right_alt_sep=''

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
