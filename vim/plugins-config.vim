" Plugin settings

if has_key(g:plugs, 'vim-closetag')
  let g:closetag_filenames="*.html,*.jsx"
endif

if has_key(g:plugs, 'vim-devicons')
  let g:WebDevIconsOS='Darwin'
  let g:WebDevIconsUnicodeDecorateFolderNodes=1
  let g:DevIconsEnableFoldersOpenClose=1
endif

if has_key(g:plugs, 'vim-easymotion')
  let g:EasyMotion_do_mapping=0
  let g:EasyMotion_smartcase=1

  map <leader> <Plug>(easymotion-prefix)

  " s{char}{char} to move to {char}{char}
  nmap s <Plug>(easymotion-overwin-f2)

  " <Leader>f{char} to move to {char}
  map  <Leader>f <Plug>(easymotion-bd-f)
  nmap <Leader>f <Plug>(easymotion-overwin-f)

  " Move to line
  map S <Plug>(easymotion-bd-jk)
  nmap S <Plug>(easymotion-overwin-line)

  " Move to word
  map  <Leader>w <Plug>(easymotion-bd-w)
  nmap <Leader>w <Plug>(easymotion-overwin-w)
endif

if has_key(g:plugs, 'vim-easyclip')
  let g:EasyClipUseCutDefaults=0

  nmap x <Plug>MoveMotionPlug
  xmap x <Plug>MoveMotionXPlug
  nmap xx <Plug>MoveMotionLinePlug
endif

if has_key(g:plugs, 'editorconfig-vim')
  let g:EditorConfig_exclude_patterns=['fugitive://.*', 'scp://.*']
endif

if has_key(g:plugs, 'vim-polyglot')
  let g:jsx_ext_required=0
  let g:vim_markdown_conceal=0
endif

if has_key(g:plugs, 'matchtagalways')
  let g:mta_filetypes={
    \ 'javascript.jsx': 1,
    \ 'html' : 1,
    \ }
endif

if has_key(g:plugs, 'ctrlp.vim')
  let g:ctrlp_prompt_mappings={
    \ 'AcceptSelection("h")': ['<c-s>'],
    \ 'AcceptSelection("v")': ['<c-v>'],
    \  }

  nmap <leader>p :CtrlPBuffer<cr>
  map <leader>r :CtrlPClearCache<cr>

  if executable('ag')
    " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
    set grepprg=ag\ --nogroup\ --nocolor
    " Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
    " and .agignore. Ignores hidden files by default.
    let g:ctrlp_user_command='ag %s -l --nocolor -f -g ""'
  endif
endif

if has_key(g:plugs, 'nerdtree')
  let NERDTreeMapActivateNode='l'
  let NERDTreeMapCloseDir='h'
  let NERDTreeMapOpenSplit='<c-s>'
  let NERDTreeMapOpenVSplit='<c-v>'

  map <C-n> :NERDTreeToggle<CR>
endif

if has_key(g:plugs, 'gruvbox')
  let g:gruvbox_italic=1
  colorscheme gruvbox
endif

if has_key(g:plugs, 'ale')
  nmap <Leader>k <Plug>(ale_previous_wrap)
  nmap <Leader>j <Plug>(ale_next_wrap)

  let g:ale_set_signs=0
endif

if has_key(g:plugs, 'vim-smooth-scroll')
  noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
  noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
  noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
  noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
endif

if has_key(g:plugs, 'neocomplete.vim')
  let g:acp_enableAtStartup=0
  let g:neocomplete#enable_at_startup=1

  inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
endif

if has_key(g:plugs, 'vim-airline')
  set laststatus=2 " Always show airline
  set noshowmode

  let g:airline_powerline_fonts=1
  let g:airline#extensions#tabline#enabled=1
  let g:airline_theme='gruvbox'
  let g:airline_left_sep=''
  let g:airline_left_alt_sep=''
  let g:airline_right_sep=''
  let g:airline_right_alt_sep=''
endif

if has_key(g:plugs, 'auto-pairs')
  let g:AutoPairsMultilineClose = 0
  let g:AutoPairsFlyMode = 0
endif
