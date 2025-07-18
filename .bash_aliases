if command -v eza &> /dev/null; then
  alias eza="eza --color=always --icons=always --smart-group"
  alias l="eza"
  alias ll="eza -al"
  alias LL="eza -al --total-size"
  alias la="eza -a"
  alias tree="eza -aTL2"
else
  alias ll="ls -alF"
  alias la="ls -A"
  alias l="ls -CF"
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# cd to a file (go to the parent directory)
cd() {
    local args=() arg

    for arg in "$@"; do
        if [[ $arg != -* && -e $arg && ! -d $arg ]]; then
            args+=("$(dirname "$arg")")
        else
            args+=("$arg")
        fi
    done

    builtin cd ${args[0]+"${args[@]}"}
}

# Adds a confirmation prompt before turning off the computer
reboot () { echo 'Reboot? (y/N)' && read x && [[ "$x" == "y" ]] && /sbin/reboot; }
poweroff () { echo 'Poweroff? (y/N)' && read x && [[ "$x" == "y" ]] && /sbin/poweroff; }

alias n="nvim"

function lzg() { 
  if [ "$PWD" = "$HOME" ]; then
    command lazygit --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
  else
    command lazygit "$@"
  fi
}

alias lzd="lazydocker"

# alias fd="fd --hidden --no-ignore --ignore-file=$HOME/.config/fd/ignore"
alias fd="fd --hidden --no-ignore"

# Copy command output to system clipboard by piping the command to this alias
alias copy="xclip -rmlastnl -sel clip"

what() {
  echo "Executable Information:"
  builtin type -a $@ 2>&1

  echo -e "\nFile Information:"
  OUTPUT=$(builtin type -atp $@ 2>&1)
  # echo -e "$OUTPUT\n"
  for WORD in $OUTPUT; do
    if [ -e $WORD ]; then
      file $WORD
    fi
  done
  for WORD in "$@"; do
    if [ -e $WORD ]; then
      file $WORD
    fi
  done
}

git() {
	if [ "$PWD" = "$HOME" ]; then
		command git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
	else
		command git "$@"
	fi
}
