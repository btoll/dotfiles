nnoremap <leader>c mq0i--<esc>`q
nnoremap <leader>C 02x
vnoremap <leader>c :s_^_--_g<cr>:noh<cr>
vnoremap <leader>C :s_^--__g<cr>:noh<cr>

nnoremap <leader>d :ElmShowDocs<cr>
nnoremap <leader>db :ElmBrowseDocs<cr>

nnoremap <leader>gh ogh = (Debug.log "DEBUG" "got here")<esc>

" This is a shortcut to log one word (the one under the cursor)
" See the `log` macro below to log more than one word.
"
" 1. Go back one or more words (in case there is a period, i.e. model.sports).
" 2. Inner yank the word that the cursor is over.
" 3. Begin the Elm debug syntax, i.e., ( Debug.log
" 4. Escape and paste in the yanked text that we want to log.
" 5. Enter insert mode to add the closing double quote and a space.
" 6. Jump over the word and finish macro with the closing paren.
nnoremap <leader>l mqyiwi(Debug.log "<esc>pa" <esc>ea)<esc>`q
"
" Log more than one word.
" It will paste as the argument(s) whatever is in the default register ("0p), so it can paste multiple words.
" Note that "E" will jump to the last letter of a multi-word.
nnoremap <leader>log mqi(Debug.log "<esc>"0pa" <esc>Ea)<esc>`q
"
" Remove debug log
" This will work as long as the cursor is between the parens!
" 1. Go back to the open paren.
" 2. Delete up to and including the second space.
" 3. Go to the last character before the work boundary, the closed paren in this case, and delete it.
nnoremap <leader>L mqF(d2f Ex`q

nnoremap <leader>line i-<esc>yl59p<esc>
nmap <leader>b :ElmMake<cr>
nmap <leader>r :ElmRepl<cr>
nmap <leader>t :ElmTest<cr>

setlocal autoindent expandtab shiftwidth=4 tabstop=4 fileformat=unix
