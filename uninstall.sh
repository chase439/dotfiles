#!/usr/bin/env bash

# Get current dir
export DOTFILES_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# remove symlinks from user's $HOME
unlink ~/.gitconfig
unlink ~/.bashrc
unlink ~/.vimrc

