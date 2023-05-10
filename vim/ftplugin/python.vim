inoreabbrev bp import ipdb<cr><cr><cr>def main():<cr>""" derp """<cr>pass<cr><esc>O<cr><cr>if __name__ == "__main__":<cr>main()

nnoremap <leader>c mq0i#<esc>`q
nnoremap <leader>C 0x<cr>
vnoremap <leader>c :s_^_#_g<cr>:noh<cr>
vnoremap <leader>C :s_^#__g<cr>:noh<cr>

nnoremap <leader>d oipdb.set_trace()<esc>
nnoremap <leader>D Oipdb.set_trace()<esc>

nnoremap <leader>gh oprint("got here")<esc>
nnoremap <leader>l mqoprint("<c-r>"", <c-r>")<esc>`q

nnoremap <leader>r :!clear && python3 %<cr>
vnoremap <leader>r :echo system('python3 ' @")<cr>

setlocal autoindent expandtab shiftwidth=4 tabstop=4 fileformat=unix

