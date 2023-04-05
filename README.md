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
       install          Add (force) runcom sym links to $HOME
       uninstall        Remove runcom sym links from $HOME
       install_pkgs     Install Brew, Brew Cask, NPM, RVM and their packages

Files / Directories
===================
  - `runcom` contains rc files, e.g., .bashrc, .vimrc. RC stands for "runcom" which expands to "run commands". The RC files are mostly software configuration files.
  - `install` contains scripts to install things like brew, brew cask, npm, rvm and their packages.
  - `.gitmodules` is for git submodules -- other git projects within this git project, e.g., ctrlp.vim.
  - `test` contains automated test scripts to be used by Bash Automated Testing System (bats).
  - `.vim` contains vim plugins
  - `macos` contains script(s) related to configurating the user's desktop on Mac
  - `system` contains extra runcom bash files
  - `references` is a file used to store notes and it's used by the `gg` bash function to `git grep` text in the dotfiles repo.
  - others are self-explanatory

Troubleshooting
===================
  - If gitk GUI doesn't show the proper preferences and ~/.gitk exists, delete ~/.config/git/gitk
  - To run test suite, make sure to first install Bash Automated Testing System (bats). `brew install bats`
  - To run a single test, e.g., `bats --tap test/bin.bats`
  - If `syntax error: unexpected end of file`, dos2unix the file to fix its line endings.

Adding Vim Plugins
===================
  - For example, to add nerdtree:
    ```
    git clone https://github.com/scrooloose/nerdtree.git .vim/bundle/nerdtree
    git submodule add https://github.com/scrooloose/nerdtree.git .vim/bundle/nerdtree
    ```
  - It will be autoloaded by pathogen https://github.com/tpope/vim-pathogen

Credits
===================
Huge Thank You to the following:
  - https://github.com/webpro/dotfiles
  - https://github.com/garybernhardt/dotfiles
  - https://github.com/sstephenson/bats
  - https://github.com/jayharris/dotfiles-windows
