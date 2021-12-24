" Instructions to compile with Python2.7 support:
" http://stackoverflow.com/a/5293524
"
let mapleader=','

if filereadable($HOME . "/.vim.functions")
  source ~/.vim.functions
endif

if filereadable($HOME . "/.vim.mappings")
  source ~/.vim.mappings
endif

if filereadable($HOME . "/.vim.plugins")
  source ~/.vim.plugins
endif

if filereadable($HOME . "/.vim.set")
  source ~/.vim.set
endif

" Vim needs to have been compiled with the autocmd flag. Do vim --version and verify +autocmd.
if has("autocmd")
    if filereadable($HOME . "/.vim.autocmd")
      source ~/.vim.autocmd
    endif
endif

