#!/usr/bin/env bash

# Get current dir
export DOTFILES_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# force creation of symlinks in user's $HOME regardless of file existent, overwrite what's there in ~.
ln -sfv $DOTFILES_PATH/.gitconfig ~/
ln -sfv $DOTFILES_PATH/.bashrc ~/
ln -sfv $DOTFILES_PATH/.vimrc ~/

