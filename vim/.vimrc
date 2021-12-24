" Instructions to compile with Python2.7 support:
" http://stackoverflow.com/a/5293524
"
let mapleader=','

if filereadable($HOME . "/.vim.functions")
  source ~/.vim.functions
endif

if filereadable($HOME . "/.vim.mappings")
  source ~/.vim.mappings
endif

if filereadable($HOME . "/.vim.plugins")
  source ~/.vim.plugins
endif

if filereadable($HOME . "/.vim.set")
  source ~/.vim.set
endif

" Vim needs to have been compiled with the autocmd flag. Do vim --version and verify +autocmd.
if has("autocmd")
    if filereadable($HOME . "/cscope_maps.vim")
      source ~/cscope_maps.vim
    endif

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

