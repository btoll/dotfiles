"<------------------------------------------------------------->
" Plugins
"<------------------------------------------------------------->
" https://github.com/tpope/vim-pathogen
call pathogen#infect()
execute pathogen#helptags()

" https://github.com/mattn/gist-vim.git
" Instructions
"   1. git config --global github.user xxx@xxx.com (writes to ~/.gitconfig).
"   2. Install https://github.com/mattn/webapi-vim in ~/.vim/bundle (assuming Pathogen) to resolve errors.
"   3. Enter github password when prompted when creating gist (saves oAuth token in ~/.gist-vim).

" https://github.com/maksimr/vim-jsbeautify
map <c-f>:call JsBeautify()<cr>

" https://github.com/scrooloose/syntastic
let g:syntastic_enable_signs=1 " Put errors on left side
let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_javascript_checkers = ['jslint', 'jshint']

" https://github.com/kien/ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" https://github.com/marijnh/tern_for_vim
" let g:tern_map_keys=1

"<------------------------------------------------------------->
" Crypto
"<------------------------------------------------------------->
set cryptmethod=blowfish
" http://stelfox.net/blog/2013/11/using-vim-as-your-password-manager/
autocmd BufReadPost * if &key != "" | set noswapfile nowritebackup viminfo= nobackup noshelltemp history=0 secure | endif

"<------------------------------------------------------------->
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
"<------------------------------------------------------------->
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" Add the main function that restores the cursor position and its autocmd so that it gets triggered:
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
let mapleader=","

"<------------------------------------------------------------->
"<------------------------------------------------------------->

syntax on
colors desert

set ruler "Show the line and column number of the cursor position, separated by a comma.  When there is room, the relative position of the displayed text in the file is shown on the far right.
set autoindent "Copy indent from current line when starting a new line.
set shiftwidth=4 "Number of spaces to use for each step of (auto)indent.
set ignorecase "If the 'ignorecase' option is on, the case of normal letters is ignored.  'smartcase' can be set to ignore case when the pattern contains lowercase letters only.
set smartcase "Override the 'ignorecase' option if the search pattern contains upper case characters.
set incsearch "While typing a search command, show where the pattern, as it was typed so far, matches.  The matched string is highlighted.
set hlsearch "When there is a previous search pattern, highlight all its matches.
set showcmd "Show (partial) command in the last line of the screen.
set timeoutlen=2000 "The time in milliseconds that is waited for a key code or mapped key sequence to complete.
set expandtab "Spaces are used in indents with the '>' and '<' commands and when 'autoindent' is on.
set number "Same as :print, but precede each line with its line number.
set dictionary+=/usr/share/dict/words "List of file names, separated by commas, that are used to lookup words for keyword completion commands |i_CTRL-X_CTRL-K|.
set thesaurus+=/usr/share/thesaurus/mthesaur.txt "List of file names, separated by commas, that are used to lookup words for thesaurus completion commands |i_CTRL-X_CTRL-T|. (http://www.gutenberg.org/dirs/etext02/mthes10.zip)
set tabstop=4 "Number of spaces that a <Tab> in the file counts for.

" Disable the arrow keys.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

:map <C-T> <Esc>:tabnew<CR>

" Quickly open up my ~/.vimrc file in a vertically split window so I can add new things to it on the fly.
nnoremap <leader>ev :vsp $MYVIMRC<CR>

" Clear search highlighting.
nnoremap <leader><space> :noh<CR> 

" np = no paste
nnoremap <leader>np :set nopaste<CR>
nnoremap <leader>op :set paste<CR>

" nn = no line numbers
nnoremap <leader>nn :set nonumber<CR>
nnoremap <leader>on :set number<CR>

" Close all windows (cd == close all).
nnoremap <leader>ca :windo :q<CR>

" http://net.tutsplus.com/tutorials/other/vim-essential-plugin-markdown-to-html/
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <CR>

"<------------------------------------------------------------->
" searching by keyword "
"<------------------------------------------------------------->
" By pressing 's' on a word open the quickfix window with grepped files.
nnoremap <leader>s :cclose <Bar> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" Start recursive search one level up on a word and open the quickfix window with grepped files.
nnoremap <leader>s1 :cclose <Bar> :execute "vimgrep /" . expand("<cword>") . "/j ../**/*.js" <Bar> cw<CR>

" Start recursive search two levels up on a word and open the quickfix window with grepped files.
nnoremap <leader>s2 :cclose <Bar> :execute "vimgrep /" . expand("<cword>") . "/j ../../**/*.js" <Bar> cw<CR>

" Easily grep current word in current file.
command GREP :execute 'vimgrep '.expand('<cword>').' '.expand('%') | :copen | :cc

"<------------------------------------------------------------->
" Tabbing.
"<------------------------------------------------------------->
nnoremap <leader>tp <Esc>:tabp<CR>
nnoremap <leader>tn <Esc>:tabn<CR>

" Indentexpr, autoload indent files ($VIMRUNTIME/indent) based on file type.
"filetype indent on

" Possible functions:
"1. remove all whitespace before property names and colon:
"   :% s/\s\{1,\}:/:/gc

" Set autocomplete for JS. <C-X><C-O> to initiate, <C-N> and <C-P> to step through.
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" Allow saving of files as sudo when I forgot to start vim using sudo.
" http://stackoverflow.com/a/7078429
cmap w!! w !sudo tee > /dev/null %
