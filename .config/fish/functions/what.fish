function what
  echo "Executable Information:"
  builtin type -a $argv 2>&1

  echo -e "\nFile Information:"
  set -l output $(builtin type -ap $argv)
  for word in $output
    [ -e $word ] && file $word
  end
  for word in $argv
    [ -e $word ] && file $word
  end
  return 0
end
