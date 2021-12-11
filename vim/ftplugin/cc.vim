inoreabbrev bp #include <iostream><cr><cr>using namespace std;<cr><cr>int main() {<cr><cr>return 0;<cr>}<cr>

nnoremap <leader>c mq0i//<esc>`q
nnoremap <leader>C 02x
vnoremap <leader>c :s_^_//_g<cr>:noh<cr>
vnoremap <leader>C :s_^//__g<cr>:noh<cr>

" Comment out the block, c-style.
" From top/down (Start with your cursor anywhere on the first line)...
nnoremap <leader>cb mqO/*<esc>j$%o*/<esc>`q
" ...and from bottom/up (cursor must be on the closing bracket).
" NOTE added `h` to back up one char in case it's an arrow function
" (the `%` won't go up to the opening bracket b/c it's on the
" semi-colon.
nnoremap <leader>Cb mqo*/<esc>hk%O/*<esc>`q
" Uncomment out the block, c-style.
" From top/down (Start with your cursor anywhere on the first line)...
nnoremap <leader>cB mqkdd$%jdd<cr>`q
" ...and from bottom/up (cursor must be on the closing bracket).
nnoremap <leader>CB mqjddk%kdd<cr>`q

nnoremap <leader>gh oprintf("got here\n");<esc>
nnoremap <leader>l mqoprintf("%s\n", <c-r>");<esc>`q
nnoremap <leader>r :!clear && g++ % && ./a.out<cr>

