Dotfiles for Windows
===================
These dotfiles are preferences, configurations, and settings for the Windows environment. They are generalized and personalized to the user and specific projects. Please review the files and use them at your own risk.

Installation
===================
  1. First, backup any dotfiles in your $HOME (e.g. ~/.bashrc, ~/.gitconfig, ~/.vimrc).
  1. Clone dotfiles repo to your directory
  1. Run "Windows PowerShell" as admin
  1. Run `dotfiles\windows\install.ps1`

UnInstallation
===================
  1. Remove $PROFILE symlink
  1. Remove C:\nuget.config
  1. Remove certain files in $HOME\vimfiles

Issues
===================
If issues pushing to this repo, try
git config --global --unset-all credential.helper
git config --system --unset-all credential.helper
git config --unset-all credential.helper
when prompted for password, use github personal access token from github > account > settings > Developer settings from left

https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github
  - https://github.com/settings/personal-access-tokens
  - https://desktop.github.com/download/ - GitHub Desktop

https://github.com/orgs/microsoft/sso

