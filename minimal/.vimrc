" Instructions to compile with Python2.7 support:
" http://stackoverflow.com/a/5293524
"
let mapleader=','

" Allow saving of files as sudo when I forgot to start vim using sudo.
" http://stackoverflow.com/a/7078429
"cmap w!! w !sudo tee > /dev/null %

if filereadable($HOME . "/.vim.functions")
  source ~/.vim.functions
endif

if filereadable($HOME . "/.vim.mappings")
  source ~/.vim.mappings
endif

if filereadable($HOME . "/.vim.set")
  source ~/.vim.set
endif

" Vim needs to have been compiled with the autocmd flag. Do :version and verify +autocmd.
if has("autocmd")
    if filereadable($HOME . "/.vim.abbreviations")
      source ~/.vim.abbreviations
    endif

    if filereadable($HOME . "/.vim.commenting")
      source ~/.vim.commenting
    endif

    if filereadable($HOME . "/.vim.misc")
      source ~/.vim.misc
    endif

    if filereadable($HOME . "/.vim.syntax")
      source ~/.vim.syntax
    endif

    if filereadable($HOME . "/.vim.whitespace")
      source ~/.vim.whitespace
    endif

    if filereadable($HOME . "/cscope_maps.vim")
      source ~/cscope_maps.vim
    endif
endif

