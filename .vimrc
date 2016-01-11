" Required Vundle configs BEGIN.
set nocompatible
filetype off

" Set the runtime path to include vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself.
Plugin 'VundleVim/Vundle.vim'

" Make sure to escape the spaces in the name properly.
set guifont=Source\ Code\ Pro\ for\ Powerline

"<------------------------------------------------------------->
" Plugins
"<------------------------------------------------------------->
Plugin 'mattn/gist-vim.git'
" https://github.com/mattn/gist-vim.git
" Instructions
"   1. git config --global github.user xxx@xxx.com (writes to ~/.gitconfig).
"   2. Install https://github.com/mattn/webapi-vim in ~/.vim/bundle (assuming Pathogen) to resolve errors.
"   3. Enter github password when prompted when creating gist (saves oAuth token in ~/.gist-vim).

Plugin 'tpope/vim-fugitive'
" https://github.com/tpope/vim-fugitive
" set statusline=%{fugitive#statusline()}
" Open up results of Ggrep and Glog in the quickfix window.
" autocmd QuickFixCmdPost *grep* cwindow

" http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
" Each time you open a git object using fugitive it creates a new buffer.
" This means that your buffer listing can quickly become swamped with fugitive buffers.
" Here’s an autocommand that prevents this from becomming an issue:
autocmd BufReadPost fugitive://* set bufhidden=delete

Plugin 'maksimr/vim-jsbeautify'
" https://github.com/maksimr/vim-jsbeautify
map <c-f>:call JsBeautify()<cr>

Plugin 'scrooloose/syntastic'
" https://github.com/scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint', 'jshint']


Plugin 'kien/ctrlp.vim'
" https://github.com/kien/ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Plugin 'marijnh/tern_for_vim'
" https://github.com/marijnh/tern_for_vim
let g:tern_map_keys=1

Plugin 'tpope/vim-surround'
" Text Objects
" https://github.com/tpope/vim-surround
" https://github.com/vim-scripts/argtextobj.vim

Plugin 'bitc/vim-bad-whitespace'
" bad-whitespace
" https://github.com/bitc/vim-bad-whitespace

" gundo
" http://sjl.bitbucket.org/gundo.vim/
let g:gundo_preview_bottom = 1

Plugin 'bling/vim-airline'
" vim-airline
" https://github.com/bling/vim-airline
set laststatus=2
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1

" Unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

Plugin 'flazz/vim-colorschemes'
" vim-colorschemes
" https://github.com/flazz/vim-colorschemes

Plugin 'ap/vim-css-color'
" vim-css-color
" https://github.com/ap/vim-css-color

" vim-eunuch
" git@github.com:tpope/vim-eunuch.git

Plugin 'easymotion/vim-easymotion'
" vim-easymotion
" https://github.com/easymotion/vim-easymotion

" YouCompleteMe
" https://github.com/Valloric/YouCompleteMe

call vundle#end()
filetype plugin indent on

" Required Vundle configs END.

"<------------------------------------------------------------->
" Crypto
"<------------------------------------------------------------->
set cryptmethod=blowfish2

" http://stelfox.net/blog/2013/11/using-vim-as-your-password-manager/
"autocmd BufReadPost * if &key != "" | set noswapfile nowritebackup viminfo= nobackup noshelltemp history=0 secure | endif

"<------------------------------------------------------------------------------------->
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
"<------------------------------------------------------------------------------------->
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

"<------------------------------------------------------------------------------------->
"<------------------------------------------------------------------------------------->

syntax on
colors desert
"colorscheme zen

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
"set foldmethod=indent "Auto-fold when opening.
"set foldtext=""
set dictionary+=/usr/share/dict/words "List of file names, separated by commas, that are used to lookup words for keyword completion commands |i_CTRL-X_CTRL-K|.
set thesaurus+=/usr/share/thesaurus/mthesaur.txt "List of file names, separated by commas, that are used to lookup words for thesaurus completion commands |i_CTRL-X_CTRL-T|. (http://www.gutenberg.org/dirs/etext02/mthes10.zip)
set tabstop=4 "Number of spaces that a <Tab> in the file counts for.
set visualbell "Turn off error sounds and screen flashing.

" Disable the arrow keys.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Disable the <esc> key in insert mode and map it to 'jk'.
" inoremap <buffer> <esc> <nop>
inoremap jk <esc>

noremap <C-T> <Esc>:tabnew<cr>

" Quickly open up my ~/.vimrc file in a vertically split window so I can add new things to it on the fly.
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Clear search highlighting.
nnoremap <leader><space> :noh<cr>

" Toggle!
nnoremap <leader>p :setlocal paste!<cr>
nnoremap <leader>n :setlocal number!<cr>

" List the cwd in a vertically-split window.
"   % = the name of the current file
"   p = gives its full path
"   h = gives its dir (the 'head' of the full path)
nnoremap <leader>ll :vsp %:p:h<cr>

augroup commenting
    autocmd!
    " Comment/uncomment out the visual block and clear search highlighting.
    autocmd FileType javascript,go vnoremap <leader>c :s_^_//_g<cr>:noh<cr>:w<cr>
    autocmd FileType javascript,go vnoremap <leader>C :s_^//__g<cr>:noh<cr>:w<cr>
    " autocmd FileType html vnoremap <leader>c :s_^_<!--_g|s_$_-->_g<cr>:noh<cr>:w<cr>
    " autocmd FileType html vnoremap <leader>C :s_^<!--__g|s_-->$__g<cr>:noh<cr>:w<cr>
    autocmd FileType sh,php,python vnoremap <leader>c :s_^_#_g<cr>:noh<cr>:w<cr>
    autocmd FileType sh,php,python vnoremap <leader>C :s_^#__g<cr>:noh<cr>:w<cr>

    " Comment/uncomment out the single line.
    autocmd FileType javascript,go nnoremap <leader>c I//<esc>:w<cr>
    autocmd FileType javascript,go nnoremap <leader>C ^xx:w<cr>
    autocmd FileType html nnoremap <leader>c I<!--<esc>A--><esc>:w<cr>
    autocmd FileType html nnoremap <leader>C ^4x$xxx:w<cr>
    autocmd FileType sh,php,python nnoremap <leader>c I#<esc>:w<cr>
    autocmd FileType sh,php,python nnoremap <leader>C ^x:w<cr>

    " Comment out the block, c-style.
    " From top/down (Start with your cursor anywhere on the first line)...
    autocmd FileType html,javascript,go,php nnoremap <leader>b O/*<esc>jf{%o*/<esc>:w<cr>
    " ...and from bottom/up (cursor must be on the closing bracket).
    autocmd FileType html,javascript,go,php nnoremap <leader>B o*/<esc>k%O/*<esc>:w<cr>
    " Uncomment out the block, c-style.
    " From top/down (Start with your cursor anywhere on the first line)...
    autocmd FileType html,javascript,go,php nnoremap <leader>ub kddf{%jdd:w<cr>
    " ...and from bottom/up (cursor must be on the closing bracket).
    autocmd FileType html,javascript,go,php nnoremap <leader>uB jddk%kdd:w<cr>
augroup END

augroup syntax
    autocmd!
    " JavaScript syntax helpers.
    " Typing 'iff' will create an empty if block and then put the cursor within the parens.
    autocmd FileType html,javascript,go iabbrev <buffer> iff if () {<cr>}<esc>kt)
    " Typing 'ifd' will create an if block with a debugger and then put the cursor within the parens.
    autocmd FileType html,javascript iabbrev <buffer> ifd if () {<cr>debugger;<cr>}<esc>2kt)
    " Typing 'iife' will create an IIFE (es6).
    " Note `<<o` will dedent and then create a new line.
    autocmd FileType html,javascript iabbrev <buffer> iife (() => {<cr><tab>'use strict';<cr><cr>})();<esc><<o<esc>
    " Typing 'forr' will create an empty for block, insert two semi-colons within the parens and then put the cursor within the first paren in insert mode.
    autocmd FileType html,javascript iabbrev <buffer> forr for (;;) {<cr>}<cr><esc>2kt;
    " Typing 'forin' will create an empty for block, insert the keyword in within the parens and then put the cursor within the first paren in insert mode.
    autocmd FileType html,javascript iabbrev <buffer> forin for (in) {<cr>}<cr><esc>2kti
    " Typing 'func' will create a function expression, insert the keyword in within the parens and then put the cursor within the first paren in insert mode.
    autocmd FileType html,javascript iabbrev <buffer> func function () {<cr>};<esc>kf(a

    """""""""""""""""""""""""
    " Common abbreviations "
    """""""""""""""""""""""""
    " Go boilerplate.
    autocmd FileType go iabbrev goBP package main<cr><cr>func main() {<cr>}<cr>

    " HTML boilerplate.
    autocmd FileType html iabbrev htmlBP <!DOCTYPE html><cr><html><cr><head><cr><style><cr></style><cr><script><cr></script><cr></head><cr><cr><body><cr></body><cr></html><cr>

    " CSS and JavaScript resources.
    autocmd FileType html iabbrev doctype <!DOCTYPE html>

    "Misc
    "anti-Mitchell pattern - removes \s between properties and colons in objects.
    autocmd FileType html,javascript nnoremap <leader>mitch :% s/\>\(\s\+\):/:/gc<cr>
augroup END

" There are references to Jira tickets littered all over the codebase, i.e., 'see EXTJS-14745'.
" To open in the default browser, simply position the cursor anywhere within 'EXTJS'.
nnoremap <leader>go 3yiw :silent :!open https://sencha.jira.com/browse/<c-r>0<cr> :redraw!<cr>

" Save fingers from having to type 'debugger;' over and over!
nnoremap <leader>d odebugger;<esc>:w<cr>
nnoremap <leader>D Odebugger;<esc>:w<cr>

" Auto-indent blocks.
nnoremap <leader>i V$%>
nnoremap <leader>I V$%<

" Change all instances of " to ' in a line and clear search highlighting.
nnoremap <leader>' V:s/"/'/g<cr>:noh<cr>

" Save fingers from typing console.log. It will paste as the argument(s) whatever is in the default register.
nnoremap <leader>log oconsole.log(<esc>pa);<esc>
nnoremap <leader>gh oconsole.log('got here');<esc>

" http://net.tutsplus.com/tutorials/other/vim-essential-plugin-markdown-to-html/
noremap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>

" Set autocomplete for JS. <C-X><C-O> to initiate, <C-N> and <C-P> to step through.
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" Allow saving of files as sudo when I forgot to start vim using sudo.
" http://stackoverflow.com/a/7078429
cmap w!! w !sudo tee > /dev/null %

