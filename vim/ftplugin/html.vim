inoreabbrev doctype <!DOCTYPE html>
inoreabbrev scripttag <script src="" type="text/javascript" charset="utf-8"></script>
inoreabbrev linktag <link href="" rel="stylesheet" type="text/css">

nnoremap <leader>c 0i<!--<esc>A--><esc>
nnoremap <leader>C 04x$xxx
"vnoremap <leader>c :s_^_<!--_g|s_$_-->_g<cr>:noh<cr>
"vnoremap <leader>C :s_^<!--__g|s_-->$__g<cr>:noh<cr>

" Comment out the block, c-style.
nnoremap <leader>cb mqO/*<esc>j$%o*/<esc>`q
nnoremap <leader>Cb mqo*/<esc>hk%O/*<esc>`q

" Uncomment out the block, c-style.
nnoremap <leader>cB mqkdd$%jdd<cr>`q
nnoremap <leader>CB mqjddk%kdd<cr>`q

nnoremap <leader>d odebugger;<esc>
nnoremap <leader>D Odebugger;<esc>

nnoremap <leader>gh oconsole.log("got here");<esc>
nnoremap <leader>l mqoconsole.log("<c-r>"", <c-r>");<esc>`q

" anti-Mitchell pattern - removes \s between properties and colons in objects.
nnoremap <leader>mitch :% s/\>\(\s\+\):/:/gc<cr>

setlocal autoindent expandtab shiftwidth=4 tabstop=4 fileformat=unix

