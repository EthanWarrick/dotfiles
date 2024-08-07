function fish_user_key_bindings
  fzf --fish | source
  atuin init fish --disable-up-arrow | source
end
