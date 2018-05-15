# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

# Get current dir knowing this file is a symlink from $HOME
export DOTFILES_PATH="$( cd "$( dirname "$( readlink "${BASH_SOURCE[0]}" )" )" && pwd )"

# Add dotfiles bin to PATH
export PATH="$PATH:$DOTFILES_PATH/bin"

