Install to the `$HOME` directory using [GNU Stow]:

    git clone git@github.com:btoll/dotfiles.git
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

[Here] is a helpful tutorial on getting started with Stow.

[GNU Stow]: https://www.gnu.org/software/stow/stow.html
[Here]: https://taihen.org/managing-dotfiles-with-gnu-stow/

