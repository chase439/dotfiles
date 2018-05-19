Dotfiles
===================
These dotfiles are prefs and settings for the Linux environment. I've generalized them as much as I can, but I've also personalized some files for my specific projects. Please review the files and use them at your own risk.

Installation
===================
  1. First, backup any dotfiles in your $HOME (e.g. ~/.bashrc, ~/.gitconfig, ~/.vimrc).
  1. Clone dotfiles repo to your directory
  1. Cd into the dotfiles project
  1. Run "bin/dotfiles install"

Un-Installation
===================
  1. Run "dotfiles uninstall"

The `dotfiles` command
===================

    $ dotfiles help
    Usage: dotfiles <command>

    Commands:
       clean            Clean up caches (brew, npm, gem, rvm)
       dock             Apply macOS Dock settings
       help             Display this help message
       macos            Apply MacOS system defaults
       test             Run tests
       update           Run MacOS softwareupdate
       install          Install sym links to $HOME
       uninstall        Uninstall sym links from $HOME

Troubleshooting
===================
  - If gitk GUI doesn't show the proper preferences and ~/.gitk exists, delete ~/.config/git/gitk
  - To run test suite, make sure to first install Bash Automated Testing System (bats). `brew install bats`
  - To run a single test, e.g., `bats --tap test/bin.bats`

Credits
===================
Thank you to the following:
  - https://github.com/webpro/dotfiles
  - https://github.com/garybernhardt/dotfiles
  - https://github.com/sstephenson/bats
