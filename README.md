Dotfiles
===================
These dotfiles are prefs and settings for the Linux environment. I've generalized them as much as I can, but also personalized for specific projects I've been working on. Please review the files and use them at your own risk. 

Installation
===================
  1. First, backup any dotfiles in your $HOME (e.g. ~/.bashrc, ~/.gitconfig, ~/.vimrc).
  1. Clone dotfiles repo to your directory
  1. Run the install.sh
  1. Modify dotfiles to your preferences

Troubleshooting
===================
  - If gitk GUI doesn't show the proper preferences and ~/.gitk exists, delete ~/.config/git/gitk


## The `dotfiles` command

    $ dotfiles help
    Usage: dotfiles <command>
    
    Commands:
       clean            Clean up caches (brew, npm, gem, rvm)
       dock             Apply macOS Dock settings
       edit             Open dotfiles in IDE (code) and Git GUI (stree)
       help             This help message
       macos            Apply macOS system defaults
       test             Run tests
       update           Update packages and pkg managers (OS, brew, npm, gem)

