nnoremap <leader>c mq0i//<esc>`q
nnoremap <leader>C 02x
vnoremap <leader>c :s_^_//_g<cr>:noh<cr>
vnoremap <leader>C :s_^//__g<cr>:noh<cr>

nnoremap <leader>cb mqO/*<esc>j$%o*/<esc>`q
nnoremap <leader>Cb mqo*/<esc>hk%O/*<esc>`q
nnoremap <leader>cB mqkdd$%jdd<cr>`q
nnoremap <leader>CB mqjddk%kdd<cr>`q

nnoremap <leader>d odebugger;<esc>
nnoremap <leader>D Odebugger;<esc>
nnoremap <leader>gh oconsole.log("got here");<esc>
nnoremap <leader>l mqoconsole.log("<c-r>"", <c-r>");<esc>`q

" Set autocomplete for JS. <C-X><C-O> to initiate, <C-N> and <C-P> to step through.
"set omnifunc=javascriptcomplete#CompleteJS

cnoreabbrev <expr> dd getcmdtype() == ":" && getcmdline() == 'dd' ? '!clear && dump_describes -t %' : 'dd'
cnoreabbrev <expr> ddv getcmdtype() == ":" && getcmdline() == 'ddv' ? '!clear && dump_describes -t % -v' : 'ddv'

" Run specs only for the current file.
cnoreabbrev <expr> jas getcmdtype() == ":" && getcmdline() == 'jas' ? '!clear && jasmine %' : 'jas'
" Run all specs.
cnoreabbrev <expr> jall getcmdtype() == ":" && getcmdline() == 'jall' ? '!clear && npm run specs' : 'jall'

" anti-Mitchell pattern - removes \s between properties and colons in objects.
nnoremap <leader>mitch :% s/\>\(\s\+\):/:/gc<cr>
nnoremap <leader>line i/* -<esc>yl59pi */<esc>

vnoremap <leader>r y:echo system('node ', @")<cr>

setlocal autoindent expandtab shiftwidth=4 tabstop=4 fileformat=unix

