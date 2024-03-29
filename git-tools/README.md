## Installation

1. Clone the repo.
2. Run `./install.sh` to install the extensions and aliases.

    Or install using [GNU Stow]:

    `stow -t $HOME/bin bin`

3. Run `./install_manpages.sh` to install the man pages.
4. Pet a goat.

## Git aliases

git dirty

    git config --global alias.dirty 'ls --dirty -e'

git get-hash

    git config --global alias.get-hash rev-parse

git goto

    git config --global alias.goto '!sh -c '"'git rev-parse \$0 | xargs git checkout'"

git open

    git config --global alias.open '!f()'" { SHA=\$(git rev-parse \$0); open https://github.com/extjs/SDK/commit/\$SHA; }; f"

git open-sha

    git config --global alias.open-sha '!sh -c '"'open https://github.com/extjs/SDK/commit/\$0'"

git pre-commit hooks

    git config --global --add hooks.pre-commit.hook "debugger.sh"
    git config --global --add hooks.pre-commit.hook "EOF.sh"

## Git extensions

> **NOTE** Any commands that open files will use Vim as the editor.

- <a href="#git-load">git-load</a>
- <a href="#git-cleanup">git-cleanup</a>
- <a href="#git-get-hash">git-get-hash</a>
- <a href="#git-goto">git-goto</a>
- <a href="#git-hub">git-hub</a>
- <a href="#git-log-grep">git-log-grep</a>
- <a href="#git-ls">git-ls</a>
- <a href="#git-package-and-release">git-package-and-release</a>
- <a href="#git-review">git-review</a>

### git-load

Get up and running quickly with the versioned files that make up a commit.

In other words, all files from the specified commit will be automatically opened in Vim.  This is very handy when wanting to resume where you left off from your last editing session.

> `git-load` differs from the `git-dirty` alias!  The former opens committed files, while the latter opens staged and modified files.

If not given any arguments, `git-load` will assume the last commit.

Usage:

    --commit, -c         The commit from which to get the files.

    --help               Help.

    --recurse, -r        Get files from more than one commit.

    --split, --sp, -h    Open files in Vim in a horizontal split.

    --tabs, --tab, -p    Open files in Vim in tabs.

    --vsplit, --vsp, -v  Open files in Vim in a vertical split.

This script is just basically a nice front-end to `git ls`.  It runs the following command:

    git ls --edit "$VIM" --recurse "$RECURSE" --commit "$COMMIT"

### git-cleanup

This script will delete any git branch, both locally and remotely, that has been merged or unmerged and that matches the filtered search.

If unsure about which branches your fuzzy search will match and delete, it is recommended to first
do a dry run using the `-l` switch.

This uses the git command `git branch --merged` under the covers.

Example usage:

    git cleanup [defaults to -r origin -p "."]
    git cleanup -r upstream
    git cleanup -p "HELLO*"
    git cleanup -p "WORLD*" -r btoll
    git cleanup --no-merged
    git cleanup --no-merged -i

Usage:

    -h                  Help

    -f                  It's possible to specify a file to which all of the git branch deletion
                        commands will be written.
                        This will not delete any branches. It's intention is to allow for further
                        inspection of all the deletion candidates. The file will be executable.

    -i                  Interactive mode.

    --dry-run, -l       Will operate in DRY RUN mode.  Will list all branches to be deleted.
                        This is useful (and safe) when you are not sure which branches will be
                        removed by the filter.

    --no-merged         Operate on unmerged branches instead.

    --no-remote-delete  Do not delete the branches remotely.

    -p                  The pattern to use for existing local branches.
                        Defaults to 'EXTJS.*'

    -r                  The name of the remote repository from which to delete the branch.
                        Defaults to 'origin'.

This does the following:

- warn you if you're in danger of deleting the remote HEAD. See the truth table below for how that could happen.
- will delete all branches that match the filter, both local and remote

Note that you can also define the following environment variables used by the script:

    GIT_CLEANUP_PATTERN
    GIT_CLEANUP_REPO

The biggest fear is of accidentally deleting a branch that hasn't been merged yet, and the most
likely scenario for this is that of an unpushed branch. To help ease that fear, the following
truth table shows the outcome of running the command for UNMERGED branches:
```
+-----------------------------------------------------------------------------------------------------+
|    Command          |  Is pushed  |  Has commits  |  On `foo`  |  Deleted Local  |  Deleted Remote  |
+-----------------------------------------------------------------------------------------------------+
|  git cleanup -p foo         Y              Y                                                        |
+-----------------------------------------------------------------------------------------------------+
|  git cleanup -p foo         Y              Y            Y                                 Y         |
+-----------------------------------------------------------------------------------------------------+
|  git cleanup -p foo         Y                           Y                                 Y         |
+-----------------------------------------------------------------------------------------------------+
|  git cleanup -p foo         Y                                           Y                 Y         |
+-----------------------------------------------------------------------------------------------------+
|  git cleanup -p foo                        Y            Y                                           |
+-----------------------------------------------------------------------------------------------------+
|  git cleanup -p foo                        Y                                                        |
+-----------------------------------------------------------------------------------------------------+
|  git cleanup -p foo                                     Y                                           |
+-----------------------------------------------------------------------------------------------------+
|  git cleanup -p foo                                                     Y                           |
+-----------------------------------------------------------------------------------------------------+
```
For example, this first line can be read as:
'If I run the following command from a branch that is not `foo`, has one or more commits and has
been pushed to a remote repo, the branch will not be deleted either locally or remotely.'

The second line can be read as:
'If I run the following command from a branch that is `foo`, has one or more commits and has been
pushed to a remote repo, the branch will not be deleted locally but will be deleted remotely.'

The only scenarios in which a local branch will be deleted is when it contains no commits.

The script will not force delete (`-D`) any branches unless in --no-merged mode!

But as usual, make sure you know what you're doing! I am not responsible for lost branches!

### git-get-hash

    !!! This is deprecated. Use the git alias instead. !!!

This will grep for the first commit hash in the branch or tag description. It can be useful in many different ways.

For example:

- Use it to check out a tagged version.
- Use it for the good or bad anchor when bisecting.
- Use it in a pipeline.

When bisecting:

    git get-hash 4.2.2 | xargs git bisect good
    git bisect good $(git get-hash 4.2.2)
    git bisect bad `git get-hash 4.2.2`

This will grep for the first commit hash in the tag description and use it for the good or bad commit anchor for git-bisect.

When checking out a tagged version:

    git get-hash 5.2.2 | xargs git checkout
    git checkout $(git get-hash 4.2.2)
    git checkout `git get-hash 4.2.2`

When cherry picking:

    git cherry-pick $(git get-hash listfilter_prototype)

### git-goto

    !!! This is deprecated. Use the git alias instead. !!!

Example usages:

    git goto 5.1.0
    git goto extjs5.1.0

This is most useful when needing to quickly check out a release without having to know the tagged hash.

### git-hub

Open any file, directory or commit on GitHub in regular view or blame view.

It's best to show what this tool can do through examples.

- Open the current working directory:

    `git hub`

- Open the file:

    `git hub --file grid/filters/filter/List.js`

- Open the file in a blame view:

    `git hub -f grid/header/Container --blame`

- Open the file in a remote branch other than the one that is currently checked out:

    `git hub --branch extjs-4.2.x -f Component.js`

- Open the commit hash:

    `git hub --hash b51abf6f38902`

- Open the commit hash to which the local topic branch points:

    `git hub --get-hash EXTJS-15755`

- Open the commit hash to which the tag points:

    `git hub --get-hash extjs5.1.0`

### git-log-grep

    !!! This is deprecated. Use git-ls instead. !!!

Find the commit(s) that introduced or removed a method or other search pattern.

Example usages:

    git grep --pattern onGridDestroy
    git grep -p injectLockable --open-in-browser
    git grep -pattern onDestroy -file ext/src/grid --no-delete-file
    git grep -p getDragData -l dd | tee my_search_results

It is basically a wrapper for ```git log -S``` and returns the same results, however there are several advantages to it:

    - Opens all search results in its own tabbed browser window.
      This can be incredibly useful when discussing an issue with a colleague over the internets.
      Currently only supported on Mac OS X.

    - Ease of typing.
      Since it provides sensible defaults for the formatting, it's not necessary to lookup the tokens to
      provide your own. In addition, it will automatically use the current working directory as the search
      location (as the last argument after the ```--```) which can significantly speed up the query.

      The found matches will be in the following format (to STDOUT):

          Hash (short)    ->  6449ce9
          Author name     ->  Benjamin Toll
          Author email    ->  benjam72@yahoo.com
          Commit message  ->  Ensure column filter menu is destroyed when adding new column filters.
          Merge date      ->  Mon Nov 24 13:27:27 2014 -0500
          Url             ->  https://github.com/extjs/SDK/commit/6449ce9

    - Will keep the auto-generated CSV file on disk by passing the ```--no-delete-file``` flag.

### git-ls

List the files that are staged and modifed or that make up any given commit and optionally open in Vim for editing.

- List the files that make up the latest commit.

    `git ls`

- List the files that are in the staged area and are modified in the workspace.  This is the `git dirty` alias.

    `git ls --dirty`

- Opens all listed files in Vim in vertically-split windows.

    `git ls --edit v`

- Opens all listed files in Vim in tabs for the specified hash (note that it will default to HEAD).

    `git ls --commit HEAD -e t`

- Opens all listed files in Vim (in buffers).

    `git ls --edit b`

- Opens all listed files for the specified hash (cf457b6) in horizontally-split windows.

    `git ls -c cf457b6 -e h`

- Opens all listed files for the specified hash (cf457b6) that match that specified regular expression in horizontally-split windows.

    `git ls -c cf457b6 --pattern debugger -e h`

### git-package-and-release

This will initiate a number of automated processes which culminates with a release and its assets being programmatically created on GitHub.

Here are the steps:

1. Run this script:
   `git package-and-release 1.0.0`

1. A container (systemd-nspawn) will clone the project and then build
   and sign the packages (see /etc/systemd/nspawn) and the
   {deb,rpm}-packaging machines on my GitHub.

1. The packaging build scripts executed in the container(s) will place
   the signed package assets in /root/build in the container which is
   bind mounted to ~/projects/reprepro/packages on the host.

1. A systemd service is monitoring this host directory, and when it
   detects that there has been a modification (i.e., a new package dir),
   it will run the /home/btoll/projects/reprepro/release.sh shell script
   which will determine the path of the new dir and from its bits call the
   github-release Go module.

1. This Go module will create a new release in the respective repository
   on GitHub and upload its package build assets from the new subdirectory
   on the host at ~/projects/reprepro/packages.

See also:
- /lib/systemd/system/releasing.path
- /lib/systemd/system/releasing.service
- ~/projects/reprepro/release.sh

### git-review

    !!! This is deprecated. Use git-ls instead. !!!

Example usages:

    git review
        - List the files that make up the latest commit.

    git review --edit v
        - Opens all listed files in Vim in vertically-split windows.

    git review -edit b -limit 4
        - Opens all listed files in Vim (in buffers), limiting the number of files opened to the first four.

    git review -e h -l 3
        - Opens all listed files in horizontally-split windows, limiting the number of files opened to the
          first three.

    git review -pattern debugger -e h -l 3
        - Opens all modified files that match that specified regular expression in horizontally-split windows,
          limiting the number of files opened to the first three.

## Generating man pages

    pod2man git-hub.pod > git-hub.1

- http://linuxfocus.org/English/November2003/article309.shtml

[GNU Stow]: https://www.gnu.org/software/stow/stow.html

