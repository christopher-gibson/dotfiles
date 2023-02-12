let s:core_conf_files = [
      \ 'options.vim',
      \ 'mappings.vim',
      \ 'autocmd.vim',
      \ 'plugins.vim',
      \ ]

for s:fname in s:core_conf_files
  execute printf('source %s/%s', stdpath('config'), s:fname)
endfor

lua require('init')
