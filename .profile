# set PATH so it includes golang's bin if it exists
if [ -d "/usr/local/go/bin" ] ; then
    PATH="$PATH:/usr/local/go/bin"
fi

# set PATH so it includes rust's bin if it exists
if [ -e "$HOME/.cargo/env" ] ; then
  . "$HOME/.cargo/env"
fi

# set PATH so it includes atuin's bin if it exists
if [ -e "$HOME/.atuin/bin/env" ] ; then
  . "$HOME/.atuin/bin/env"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

[[ -r ~/.bashrc ]] && . ~/.bashrc
