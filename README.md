# Dotfiles

## Install the complete development environment

    ./install.sh

## Or, install individually

Install to the `$HOME` directory using [GNU Stow]:

    cd dotfiles

    stow --dotfiles -t $HOME bash
    stow --dotfiles -t $HOME vim
    ...

Note that the default behavior is to symlink the files to the parent directory.

Uninstall:

    cd dotfiles

    stow -D -t $HOME bash
    stow -D -t $HOME vim
    ...

## FAQ

Q. Why do all of the hidden files start with `dot-` instead of `.`?

A. This is a `stow` feature that allows the `dot-` replaced with `.` when doing the symlinking.  The reason for this feature is so you can view all of the files to be symlinked without having to add the `-a` switch when listing a directory.

---

Don't know `Stow`?  Have a look at [this helpful tutorial] on getting started with it.

[GNU Stow]: https://www.gnu.org/software/stow/stow.html
[this helpful tutorial]: https://taihen.org/managing-dotfiles-with-gnu-stow/

