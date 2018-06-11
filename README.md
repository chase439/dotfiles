Dotfiles
===================
These dotfiles are preferences, configurations, and settings for the Linux environment. They are generalized and personalized to the user and specific projects. Please review the files and use them at your own risk.

Installation
===================
  1. First, backup any dotfiles in your $HOME (e.g. ~/.bashrc, ~/.gitconfig, ~/.vimrc).
  1. Clone dotfiles repo to your directory
  1. Cd into the dotfiles project
  1. Run `bin/dotfiles install`

UnInstallation
===================
  1. Run `dotfiles uninstall`

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
       install          Add (force) sym links to $HOME
       uninstall        Remove sym links from $HOME
       install_pkgs     Install Brew, NPM, Bash, Gem and their packages

Files / Directories
===================
  - runcom directory is for rc files, e.g., .bashrc, .vimrc. RC part stands for "runcom" which expands to "run commands". The RC files are mostly software configuration files.
  - references is a file used to store notes and it's used by the `gg` bash function to `git grep` text in the dotfiles repo.

Troubleshooting
===================
  - If gitk GUI doesn't show the proper preferences and ~/.gitk exists, delete ~/.config/git/gitk
  - To run test suite, make sure to first install Bash Automated Testing System (bats). `brew install bats`
  - To run a single test, e.g., `bats --tap test/bin.bats`

Credits
===================
Huge Thank You to the following:
  - https://github.com/webpro/dotfiles
  - https://github.com/garybernhardt/dotfiles
  - https://github.com/sstephenson/bats
