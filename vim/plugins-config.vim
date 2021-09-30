" Plugin settings
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
  " map  <Leader>f <Plug>(easymotion-bd-f)
  " nmap <Leader>f <Plug>(easymotion-overwin-f)

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
  let g:javascript_plugin_flow= 1
  let g:javascript_plugin_jsdoc=1
endif

if has_key(g:plugs, 'matchtagalways')
  let g:mta_filetypes={
    \ 'javascript.jsx': 1,
    \ 'javascriptreact': 1,
    \ 'typescript': 1,
    \ 'typescriptreact': 1,
    \ 'html' : 1,
    \ }
endif

if has_key(g:plugs, 'telescope.nvim')
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
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

  map <C-b> :NERDTreeToggle<CR>
endif

if has_key(g:plugs, 'gruvbox')
  let g:gruvbox_italic=1
  colorscheme gruvbox
endif

if has_key(g:plugs, 'ale')
  nmap <Leader>k <Plug>(ale_previous_wrap)
  nmap <Leader>j <Plug>(ale_next_wrap)

  let g:ale_linters = {
    \ 'html': ['htmlhint'],
    \ 'javascript': ['eslint', 'flow'],
    \ 'javascriptreact': ['eslint', 'flow'],
    \ }

    " let g:ale_fixers = {
    " \   'javascript': ['prettier'],
    " \   'javascriptreact': ['prettier'],
    " \   'css': ['prettier'],
    " \}

  let g:ale_sign_column_always = 1
  let g:ale_fix_on_save = 1
endif

if has_key(g:plugs, 'deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#file#enable_buffer_path = 1

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

if has_key(g:plugs, 'vim-gitgutter')
  " Disable keys since they cause a delay with <leader>h
  let g:gitgutter_map_keys = 0
endif

if has_key(g:plugs, 'ack.vim')
  let g:ackprg = 'ag --vimgrep'

  cnoreabbrev Ack Ack!
  nnoremap <Leader>a :Ack!<Space>
endif


" COC has a ton of config
if has_key(g:plugs, 'coc.nvim')
  " Give more space for displaying messages.
  set cmdheight=1

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  if has('patch8.1.1068')
    " Use `complete_info` if your (Neo)Vim version supports it.
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end


  " Use <TAB> for selections ranges.
  " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  " coc-tsserver, coc-python are the examples of servers that support it.
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings using CoCList:
  " Show all diagnostics.
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  " nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

  " Prettier
  command! -nargs=0 Prettier :CocCommand prettier.formatFile
  " nmap <Leader>f <Plug>(coc-format-selected)

  " nmap <silent> [g <Plug>(coc-diagnostic-prev)
  " nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " Enable if not using ale
  " nmap <silent> <Leader>k <Plug>(coc-diagnostic-prev)
  " nmap <silent> <Leader>j <Plug>(coc-diagnostic-next)


  " Disable stuff that I don't need fo rnow
  " " Remap keys for applying codeAction to the current line.
  " nmap <leader>ac  <Plug>(coc-codeaction)
  " " Apply AutoFix to problem on the current line.
  " nmap <leader>qf  <Plug>(coc-fix-current)

  " " Introduce function text object
  " " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  " xmap if <Plug>(coc-funcobj-i)
  " xmap af <Plug>(coc-funcobj-a)
  " omap if <Plug>(coc-funcobj-i)
  " omap af <Plug>(coc-funcobj-a)

  " " Formatting selected code.
  " xmap <leader>f  <Plug>(coc-format-selected)
  " nmap <leader>f  <Plug>(coc-format-selected)

  " " Do default action for next item.
  " nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " " Do default action for previous item.
  " nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " " Resume latest coc list.
  " nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


"   " Add `:Fold` command to fold current buffer.
"   command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"   " Add `:OR` command for organize imports of the current buffer.
"   command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  " xmap <leader>a  <Plug>(coc-codeaction-selected)
  " nmap <leader>a  <Plug>(coc-codeaction-selected)
endif
