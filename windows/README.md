Dotfiles for Windows
===================
These dotfiles are preferences, configurations, and settings for the Windows environment. They are generalized and personalized to the user and specific projects. Please review the files and use them at your own risk.

Installation
===================
  1. First, backup any dotfiles in your $HOME (e.g. ~/.bashrc, ~/.gitconfig, ~/.vimrc).
  1. Clone dotfiles repo to your directory
  1. Run PowerShell as admin
  1. `cd dotfiles\windows`
  1. Run `.\symlink.ps1`
  1. Copy `dotfiles\runcom\.vimrc` to `$HOME`
  1. Copy `dotfiles\.vim\*` into `$HOME\vimfiles` (instead of ~/.vim for Linux)

UnInstallation
===================
  1. Remove $PROFILE symlink
  1. Remove certain files in $HOME\vimfiles
