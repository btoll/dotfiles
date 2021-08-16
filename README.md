# Dotfiles

## Install the complete development environment

    ./install.sh

## Or, install individually

Install to the `$HOME` directory using [GNU Stow]:

    cd dotfiles

    stow -t $HOME bash
    stow -t $HOME vim
    ...

Note that the default behavior is to symlink the files to the parent directory.

Uninstall:

    cd dotfiles

    stow -D -t $HOME bash
    stow -D -t $HOME vim
    ...

---

Don't know `Stow`?  Have a look at [this helpful tutorial] on getting started with it.

[GNU Stow]: https://www.gnu.org/software/stow/stow.html
[this helpful tutorial]: https://taihen.org/managing-dotfiles-with-gnu-stow/

