# Dotfiles Repo
This is used to store my dotfiles to maintain consistency across devices and
environments.

### Table of Contents:
1. [Install Dotfiles](#install-dotfiles)
2. [Adding/Changing Dotfiles](#addingchanging-dotfiles)
3. [Private Configs](#private-configs)
4. [Rationale and Philosophy](#rationale-and-philosophy)
5. [Lazygit](#lazygit)
6. [Credit](#credit)

## Install Dotfiles
To use this dotfiles configuration, follow the following steps:
```bash
# Clone as bare repo
git clone --bare https://github.com/EthanWarrick/dotfiles.git $HOME/.dotfiles

# Install (overwrite!!) dotfiles in home directory
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout -f

# Don't show untracked files git status to avoid clutter
git --git-dir=$HOME/.dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no
```
> The above commands will **overwrite** any conflicting files with those of this
> repo. To avoid this, you may remove the `-f` flag from the above git checkout
> command. The checkout will fail upon any conflicting files and show these
> files in the error message. You can backup these files and repeat the
> checkout command.

## Adding/Changing Dotfiles
1. Source the following function (bash specific). This is already done if using
   the bash configuration provided in this repo.
   ```bash
   git() {
       if [ "$PWD" = "$HOME" ]; then
           command git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
       else
           command git "$@"
       fi
   }
   ```
2. Run `git add <dotfile>` from your home directory on the desired config
   file(s) that have been added or modified.

3. Commit the changes -- `git commit`.

## Private Configs
Some dotfiles contain private or sensitive information that should not be
publicly tracked. A method of separating these configurations is to put them in
separate files to be referenced by an application's main config. These private
configurations are included in this repo and denoted by having `private` in
their filename. Private configs are included to avoid being a missing dependency
(and potentially throwing an error) when an application's main configuration
references them by name.

To avoid tracking changes (and secrets) added to these private config files, run
the following command:
```bash
git update-index --skip-worktree <private-filename>
```

If a private config ever does need a tracked change, stop ignoring it by running
the following command:
```bash
git update-index --no--skip-worktree <private-filename>
```

This method keeps any private config file present but *empty* in the repo. It will
still be cloned, but ideally never edited despite containing local changes.

## Rationale and Philosophy
The goal here is to store dotfiles in a way that they can easily be downloaded
and installed to their proper locations. The way I have seen this done in the
past is to create a repo containing all dotfiles and containing a script that
creates symlinks to each file at the necessary location. I went with an
alternate approach. If installed as shown above, the cloned repo is a
[bare](https://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/)
repository with the work-tree set up to be your home directory. This allows
dotfiles to be installed and tracked at their actual locations instead of some
random directory. I like this more because it avoids creating a host of symlinks
that can be tricky to interact with for some applications. It also doesn't
require creating/updating/tracking a script or any extra tooling to create the
necessary directories and symlinks on the host system.

## Lazygit
Use [lazygit](https://github.com/jesseduffield/lazygit) to manage this
dotfiles repo by aliasing it to the following function. This is already done if
using the bash config provided by this repo. This function references the bare
git repository if run from the home directory, and checks for an optional
private lazygit config file.
```bash
lazygit ()
{
    config="$HOME/.config/lazygit/config.yml";
    if [ -f $HOME/.config/lazygit/private-config.yml ]; then
        config+=",$HOME/.config/lazygit/private-config.yml";
    fi;
    if [ "$PWD" = "$HOME" ]; then
        LG_CONFIG_FILE=$config lazygit --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@";
    else
        LG_CONFIG_FILE=$config lazygit "$@";
    fi
}
```

## Credit
The structure of this repo is based on the following tutorials:  
https://www.atlassian.com/git/tutorials/dotfiles  
https://gpanders.com/blog/managing-dotfiles-with-git/
