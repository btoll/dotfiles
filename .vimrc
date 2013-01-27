let mapleader=","

call pathogen#infect() "https://github.com/tpope/vim-pathogen

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

"disable the arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

:map <C-T> <Esc>:tabnew<CR>

"quickly open up my ~/.vimrc file in a vertically split window so I can add new things to it on the fly
nnoremap <leader>ev :vsp $MYVIMRC<CR>

"clear search highlighting
nnoremap <leader><space> :noh<CR> 

"np = no paste
nnoremap <leader>np :set nopaste<CR>
nnoremap <leader>op :set paste<CR>

nnoremap <leader>na :set noautoindent<CR>
nnoremap <leader>a :set autoindent<CR>

"nn = no line numbers
nnoremap <leader>nn :set nonumber<CR>
nnoremap <leader>on :set number<CR>

"close all windows
nnoremap <leader>ca :windo :q<CR>

"Markdown to HTML
"http://net.tutsplus.com/tutorials/other/vim-essential-plugin-markdown-to-html/
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <CR>

""""""""""""""""""""""""
" searching by keyword "
""""""""""""""""""""""""
"by pressing 's' on a word open the quickfix window with grepped files
nnoremap <leader>s :cclose <Bar> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

"start recursive search one level up on a word and open the quickfix window with grepped files
nnoremap <leader>s1 :cclose <Bar> :execute "vimgrep /" . expand("<cword>") . "/j ../**/*.js" <Bar> cw<CR>

"start recursive search two levels up on a word and open the quickfix window with grepped files
nnoremap <leader>s2 :cclose <Bar> :execute "vimgrep /" . expand("<cword>") . "/j ../../**/*.js" <Bar> cw<CR>

""""""""""""""""""""""""
""""""""""""""""""""""""

"indentexpr, autoload indent files ($VIMRUNTIME/indent) based on file type
"filetype indent on

""""""""""""""""""""""""
""""""""""""""""""""""""

"js-beautify (https://github.com/maksimr/vim-jsbeautify)
let g:jsbeautify = {'indent_size': 1, 'indent_char': '    '}
let g:htmlbeautify = {'indent_size': 4, 'indent_char': ' ', 'max_char': 78, 'brace_style': 'expand', 'unformatted': ['a', 'sub', 'sup', 'b', 'i', 'u']}
let g:cssbeautify = {'indent_size': 4, 'indent_char': ' '}

map <C-F> :call JsBeautify()<CR>

"possible functions:
"1. remove all whitespace before property names and colon:
"   :% s/\s\{1,\}:/:/gc
