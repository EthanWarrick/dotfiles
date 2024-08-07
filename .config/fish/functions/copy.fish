function copy --wraps='xclip -rmlastnl -sel clip' --description 'alias copy=xclip -rmlastnl -sel clip'
  xclip -rmlastnl -sel clip $argv
        
end
