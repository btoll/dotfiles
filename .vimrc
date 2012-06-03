let mapleader=","

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

nnoremap <leader>na :set noautoindent<CR>
nnoremap <leader>a :set autoindent<CR>

"close all windows
nnoremap <leader>ca :windo :q<CR>

"function! ToggleAutoIndent()
"  if (&foldcolumn != 12)
"    set laststatus=0
"    set numberwidth=10
"    set foldcolumn=12
"    set noruler
"    hi FoldColumn ctermbg=none
"    hi LineNr ctermfg=0 ctermbg=none
"    hi NonText ctermfg=0
"  else
"    set laststatus=2
"    set numberwidth=4
"    set foldcolumn=0
"    set ruler
"    execute 'colorscheme ' . g:colors_name
"  endif
"endfunc
"nnoremap <leader>f :call ToggleAutoIndent()<CR>

""" FocusMode http://paulrouget.com/e/vimdarkroom/
function! ToggleFocusMode()
  if (&foldcolumn != 12)
    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
    set noruler
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0
  else
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    execute 'colorscheme ' . g:colors_name
  endif
endfunc
nnoremap <leader>f :call ToggleFocusMode()<cr>

let g:Favcolorschemes = ["desert", "darkblue", "desert", "evening"]
function SetTimeOfDayColors()
    " currentHour will be 0, 1, 2 or 3
    let g:CurrentHour = (strftime("%H") + 0) / 6
    if g:colors_name !~ g:Favcolorschemes[g:CurrentHour]
        execute "colorscheme " . g:Favcolorschemes[g:CurrentHour]
	echo "execute " "colorscheme " . g:Favcolorschemes[g:CurrentHour]
	redraw
    endif
endfunc
