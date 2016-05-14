let mapleader=','

call plug#begin('~/.vim/plugged')

" Make sure to escape the spaces in the name properly.
set guifont=Source\ Code\ Pro\ for\ Powerline

"<------------------------------------------------------------->
" Plugins
"<------------------------------------------------------------->
"Plug 'mattn/gist-vim.git'
" https://github.com/mattn/gist-vim.git
" Instructions
"   1. git config --global github.user xxx@xxx.com (writes to ~/.gitconfig).
"   2. Install https://github.com/mattn/webapi-vim in ~/.vim/bundle (assuming Pathogen) to resolve errors.
"   3. Enter github password when prompted when creating gist (saves oAuth token in ~/.gist-vim).

Plug 'maksimr/vim-jsbeautify'
" https://github.com/maksimr/vim-jsbeautify
map <c-f>:call JsBeautify()<cr>

Plug 'scrooloose/syntastic'
" https://github.com/scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint', 'jshint']

Plug 'kien/ctrlp.vim'
" https://github.com/kien/ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Opens ctrlp in buffer mode.
let g:ctrlp_cmd = 'CtrlPBuffer'

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" https://github.com/marijnh/tern_for_vim
Plug 'marijnh/tern_for_vim'
let g:tern_map_keys=1

Plug 'tpope/vim-surround'
" Text Objects
" https://github.com/tpope/vim-surround
" https://github.com/vim-scripts/argtextobj.vim

Plug 'bitc/vim-bad-whitespace'
" bad-whitespace
" https://github.com/bitc/vim-bad-whitespace

" gundo
" http://sjl.bitbucket.org/gundo.vim/
let g:gundo_preview_bottom = 1

Plug 'bling/vim-airline'
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

Plug 'flazz/vim-colorschemes'
" vim-colorschemes
" https://github.com/flazz/vim-colorschemes

Plug 'ap/vim-css-color'
" vim-css-color
" https://github.com/ap/vim-css-color

" vim-eunuch
" git@github.com:tpope/vim-eunuch.git

Plug 'easymotion/vim-easymotion'
" vim-easymotion
" https://github.com/easymotion/vim-easymotion

" YouCompleteMe
" https://github.com/Valloric/YouCompleteMe
Plug 'Valloric/YouCompleteMe'

Plug 'tpope/vim-repeat.git'
Plug 'kchmck/vim-coffee-script'
Plug 'rking/ag.vim'
Plug 'mileszs/ack.vim'

" Add plugins to &runtimepath
call plug#end()

" Allow saving of files as sudo when I forgot to start vim using sudo.
" http://stackoverflow.com/a/7078429
"cmap w!! w !sudo tee > /dev/null %

if filereadable($HOME . "/.vim.functions")
  source ~/.vim.functions
endif

if filereadable($HOME . "/.vim.mappings")
  source ~/.vim.mappings
endif

if filereadable($HOME . "/.vim.set")
  source ~/.vim.set
endif

" Vim needs to have been compiled with the autocmd flag. Do :version and verify +autocmd.
if has("autocmd")
    if filereadable($HOME . "/.vim.abbreviations")
      source ~/.vim.abbreviations
    endif

    if filereadable($HOME . "/.vim.commenting")
      source ~/.vim.commenting
    endif

    if filereadable($HOME . "/.vim.misc")
      source ~/.vim.misc
    endif

    if filereadable($HOME . "/.vim.syntax")
      source ~/.vim.syntax
    endif

    if filereadable($HOME . "/.vim.whitespace")
      source ~/.vim.whitespace
    endif
endif

