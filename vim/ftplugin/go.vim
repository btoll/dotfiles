" Note that the `bp` abbreviation is unnecessary if vim-go plugin is installed.
"inoreabbrev bp package main<cr><cr>func main() {<cr>}<cr>
inoreabbrev iferr if err != nil {<cr>fmt.Println(err)<cr>return err<cr>}

nnoremap <leader>c mq0i//<esc>`q
setlocal autoindent expandtab shiftwidth=4 tabstop=4 fileformat=unix

nnoremap <leader>c mq0i//<esc>`q
nnoremap <leader>C 02x
vnoremap <leader>c :s_^_//_g<cr>:noh<cr>
vnoremap <leader>C :s_^//__g<cr>:noh<cr>

nnoremap <leader>cb mqO/*<esc>j$%o*/<esc>`q
nnoremap <leader>Cb mqo*/<esc>hk%O/*<esc>`q
nnoremap <leader>cB mqkdd$%jdd<cr>`q
nnoremap <leader>CB mqjddk%kdd<cr>`q

nnoremap <leader>d oruntime.Breakpoint()<esc>
nnoremap <leader>D Oruntime.Breakpoint()<esc>

nnoremap <leader>gh ofmt.Println("got here")<esc>
nnoremap f<space> :normal [[V$%<cr>

" Note that if the `fmt` package hasn't been explicitly imported that this snippet will fail unless
"           let g:go_fmt_command = "goimports"
" is set (it is).
nnoremap <leader>l mqofmt.Println("<c-r>"", <c-r>")<esc>`q

" anti-Mitchell pattern - removes \s between properties and colons in objects.
nnoremap <leader>mitch :% s/\>\(\s\+\):/:/gc<cr>
nnoremap <leader>line i/* -<esc>yl59pi */<esc>

" https://github.com/fatih/vim-go/wiki/Tutorial#vimrc-improvements-1
nnoremap <leader>b :<C-u>call Build_go_files()<cr>
nnoremap <Leader>co <Plug>(go-coverage-toggle)
nnoremap <Leader>cob <Plug>(go-coverage-browser)
nnoremap <Leader>i <Plug>(go-info)
nnoremap <leader>r :!clear<cr><Plug>(go-run)
"nnoremap <leader>r :!clear && go run %<cr>
nnoremap <leader>t <Plug>(go-test)
nnoremap <leader>tc <Plug>(go-test-compile) " Compiles but does not test!
nnoremap <leader>tf <Plug>(go-test-func) " Only test the function under the cursor.

