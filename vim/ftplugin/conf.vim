inoreabbrev filetype /* vim: set filetype=text : */

nnoremap <leader>c mq0i#<esc>`q
nnoremap <leader>C 0x<cr>
vnoremap <leader>c :s_^_#_g<cr>:noh<cr>
vnoremap <leader>C :s_^#__g<cr>:noh<cr>

setlocal autoindent expandtab shiftwidth=4 tabstop=4 fileformat=unix

