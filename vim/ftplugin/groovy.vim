nnoremap <leader>c mq0i//<esc>`q
nnoremap <leader>C 02x
vnoremap <leader>c :s_^_//_g<cr>:noh<cr>
vnoremap <leader>C :s_^//__g<cr>:noh<cr>

nnoremap <leader>gh oprint("got here")<esc>
nnoremap <leader>l mqoprint("<c-r>"", <c-r>")<esc>`q

setlocal autoindent expandtab shiftwidth=4 tabstop=4 fileformat=unix

