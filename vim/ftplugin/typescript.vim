nnoremap <leader>c mq0i//<esc>`q
nnoremap <leader>C 02x
vnoremap <leader>c :s_^_//_g<cr>:noh<cr>
vnoremap <leader>C :s_^//__g<cr>:noh<cr>

nnoremap <leader>cb mqO/*<esc>j$%o*/<esc>`q
nnoremap <leader>Cb mqo*/<esc>hk%O/*<esc>`q
nnoremap <leader>cB mqkdd$%jdd<cr>`q
nnoremap <leader>CB mqjddk%kdd<cr>`q

nnoremap <leader>l mqoconsole.log("<c-r>"", <c-r>");<esc>`q

" Run all specs.
cnoreabbrev <expr> ts getcmdtype() == ":" && getcmdline() == 'ts' ? '!clear && ts-node %' : 'ts'

" Redefine makeprg for typescript to clear screen before compiling.
set makeprg=clear\ &&\ tsc\ $*\ %

setlocal autoindent expandtab shiftwidth=4 tabstop=4 fileformat=unix

