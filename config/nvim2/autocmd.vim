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
