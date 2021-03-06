" Instructions to compile with Python2.7 support:
" http://stackoverflow.com/a/5293524
"
let mapleader=','

" https://github.com/junegunn/vim-plug/wiki/faq
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

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

" https://github.com/scrooloose/syntastic
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint', 'jshint']
let g:syntastic_sh_checkers = ['shellcheck']

let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python']

" https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree'

" https://github.com/kien/ctrlp.vim
Plug 'kien/ctrlp.vim'
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

Plug 'rking/ag.vim'

" https://github.com/bitc/vim-bad-whitespace
Plug 'bitc/vim-bad-whitespace'

" https://github.com/flazz/vim-colorschemes
Plug 'flazz/vim-colorschemes'

" https://github.com/ap/vim-css-color
Plug 'ap/vim-css-color'

" https://github.com/fatih/vim-go
" https://github.com/fatih/vim-go-tutorial
" To update, :GoUpdateBinaries
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_version_warning = 0

" https://github.com/fatih/vim-go-tutorial#struct-split-and-join (for golang)
Plug 'AndrewRadev/splitjoin.vim'

"Plug 'elmcast/elm-vim'
"let g:elm_syntastic_show_warnings = 1
"let g:elm_setup_keybindings = 0
"let g:elm_jump_to_error = 0
"let g:elm_make_output_file = "elm.js"
"let g:elm_make_show_warnings = 0
"let g:elm_browser_command = ""
"let g:elm_detailed_complete = 0
"let g:elm_format_autosave = 1
"let g:elm_format_fail_silently = 0

"Plug 'pangloss/vim-javascript'

call plug#end()

if filereadable($HOME . "/.vim.functions")
  source ~/.vim.functions
endif

if filereadable($HOME . "/.vim.mappings")
  source ~/.vim.mappings
endif

if filereadable($HOME . "/.vim.set")
  source ~/.vim.set
endif

" Vim needs to have been compiled with the autocmd flag. Do vim --version and verify +autocmd.
if has("autocmd")
    if filereadable($HOME . "/.vim.autocmd")
      source ~/.vim.autocmd
    endif

    if filereadable($HOME . "/cscope_maps.vim")
      source ~/cscope_maps.vim
    endif
endif

