nnoremap <leader>c mq0i#<esc>`q
nnoremap <leader>C 0x<cr>
vnoremap <leader>c :s_^_#_g<cr>:noh<cr>
vnoremap <leader>C :s_^#__g<cr>:noh<cr>

nnoremap <leader>d odebugger<esc>
nnoremap <leader>D Odebugger<esc>
nnoremap <leader>gh oconsole.log("got here")<esc>
nnoremap <leader>l mqoconsole.log(<c-r>")<esc>`q

" dump_describes
" http://stackoverflow.com/a/7515418
cnoreabbrev <expr> dd getcmdtype() == ":" && getcmdline() == 'dd' ? '!clear && coffee -p %' : 'dd'

" anti-Mitchell pattern - removes \s between properties and colons in objects.
nnoremap <leader>mitch :% s/\>\(\s\+\):/:/gc<cr>

setlocal autoindent expandtab shiftwidth=4 tabstop=4 fileformat=unix

