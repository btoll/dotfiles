" Instructions to compile with Python2.7 support:
" http://stackoverflow.com/a/5293524
"
let mapleader=','

filetype plugin indent on

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

" https://github.com/fatih/vim-go-tutorial#struct-split-and-join (for golang)
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ap/vim-css-color'
Plug 'bitc/vim-bad-whitespace'
Plug 'flazz/vim-colorschemes'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
" Install instructions:
" https://github.com/ycm-core/YouCompleteMe#linux-64-bit
Plug 'ycm-core/YouCompleteMe'

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
    if filereadable($HOME . "/cscope_maps.vim")
      source ~/cscope_maps.vim
    endif
endif

if has("autocmd")
	" Highlight word (all filetypes).
	nnoremap <space> viw

	" Immediately apply any changes to .vimrc after writing.
	autocmd BufWritePost .vimrc source $MYVIMRC

	" Add the main function that restores the cursor position and its autocmd so that it gets triggered:
	function! ResCur()
	    if line("'\"") <= line("$")
		normal! g`"
		return 1
	    endif
	endfunction

	autocmd BufWinEnter * call ResCur()

	" Set default syntax for files with no extension.
	autocmd BufNewFile,BufRead * if &filetype == '' | set filetype=conf | endif
endif

