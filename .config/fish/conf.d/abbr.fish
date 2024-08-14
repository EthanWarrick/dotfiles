function multicd
  set -l length (math (string length -- $argv) - 1)
  echo cd (string repeat -n $length ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

abbr --add n nvim
abbr --add lzg lazygit
abbr --add lzd lazydocker
