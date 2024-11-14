source $__fish_config_dir/private-config.fish

# Commands to run in interactive sessions can go here
if status is-interactive

  if not functions --query fisher
    echo "Installing fisher and fisher plugins"
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
    fish -c "fisher update"
  end

  # Starship prompt setup
  command --query starship && starship init fish | source

  set -U fish_greeting # Remove fish welcome message

  export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
  export FZF_DEFAULT_COMMAND='fd --ignore-file $HOME/.config/fd/ignore'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  if command --query bat
    export MANPAGER="sh -c 'col -bx | bat -l man -p --paging=always'"
  end

end
