inoreabbrev bp #!/bin/bash<cr><cr>set -euo pipefail<cr>LANG=C<cr><cr>umask 0022<cr><cr>

nnoremap <leader>c mq0i#<esc>`q
nnoremap <leader>C 0x<cr>
vnoremap <leader>c :s_^_#_g<cr>:noh<cr>
vnoremap <leader>C :s_^#__g<cr>:noh<cr>

nnoremap <leader>gh oecho "got here"<esc>
nnoremap <leader>l mqoecho "$<c-r>""<esc>`q
nnoremap <leader>line i#<esc>yl59p<esc>

setlocal autoindent expandtab shiftwidth=4 tabstop=4 fileformat=unix

