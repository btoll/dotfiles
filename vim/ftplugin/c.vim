inoreabbrev bp #include <stdlib.h><cr>#include <stdio.h><cr><cr>int main(int argc, char **argv) {<cr>return 0;<cr>}<cr>

nnoremap <leader>c mq0i//<esc>`q
nnoremap <leader>C 02x
vnoremap <leader>c :s_^_//_g<cr>:noh<cr>
vnoremap <leader>C :s_^//__g<cr>:noh<cr>

nnoremap <leader>cb mqO/*<esc>j$%o*/<esc>`q
nnoremap <leader>Cb mqo*/<esc>hk%O/*<esc>`q
nnoremap <leader>cB mqkdd$%jdd<cr>`q
nnoremap <leader>CB mqjddk%kdd<cr>`q

nnoremap <leader>gh oprintf("got here\n");<esc>
nnoremap <leader>l mqoprintf("%s\n", <c-r>");<esc>`q
nnoremap <leader>r :!clear && gcc % && ./a.out && rm a.out<cr>

setlocal autoindent expandtab shiftwidth=4 tabstop=4 fileformat=unix

