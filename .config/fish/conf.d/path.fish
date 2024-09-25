# set PATH so it includes golang's bin if it exists
fish_add_path /usr/local/go/bin

# set path so it includes rust's bin if it exists
fish_add_path $HOME/.cargo/bin

# set PATH so it includes user's private bin if it exists
fish_add_path -m $HOME/.local/bin
