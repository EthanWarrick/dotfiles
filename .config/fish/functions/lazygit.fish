  function lazygit
    if [ $PWD = $HOME ]
      command lazygit --git-dir="$HOME/.dotfiles" --work-tree="$HOME" $argv
    else
      command lazygit $argv
    end
  end
