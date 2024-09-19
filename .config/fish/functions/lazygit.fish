  function lazygit
    set -l config $HOME/.config/lazygit/config.yml
    if [ -f $HOME/.config/lazygit/private-config.yml ]
      set --append config ,$HOME/.config/lazygit/private-config.yml
    end
    if [ $PWD = $HOME ]
      LG_CONFIG_FILE=$(string join '' $config) command lazygit --git-dir="$HOME/.dotfiles" --work-tree="$HOME" $argv
    else
      LG_CONFIG_FILE=$(string join '' $config) command lazygit $argv
    end
  end
