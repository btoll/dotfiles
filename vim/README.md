## Vim Functions

### Interacting with GitHub

#### `function! G(...)`

Opens the current file.

Invoke using `<leader>g`.

#### `function! Gblame(...)`

Triggers blame view for current file with an optional `a:branch` argument.

Invoke using `<leader>gb`.

#### `function! Grange(...)`

Highlight a visual range for the current file. `a:blame` and `a:branch` are optional arguments.

Invoke using `<leader>gbr`.

> In addition, it's possible to call each function specifying a branch other than the current one.
> Refer to the code in [.vim.functions].

[.vim.functions]: /vim/.vim.functions

