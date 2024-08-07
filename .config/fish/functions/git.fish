function git
  if [ $PWD = $HOME ]
    command git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv
  else
    command git $argv
  end
end
