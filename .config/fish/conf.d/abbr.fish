function multicd
  set -l length (math (string length -- $argv) - 1)
  echo cd (string repeat -n $length ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

abbr --add n nvim
abbr --add lzg lazygit
abbr --add lzd lazydocker


function __convert_slashes
    for arg in $argv
        if test (string match -r '^//' $arg)
            set -l temp (string replace -r '^//' '/mnt/' $arg)
            if test -e $temp
                echo $temp
                continue
            end
        end
        echo $arg
    end
end
abbr --add slashes --position anywhere --regex '^//.*' --function __convert_slashes
