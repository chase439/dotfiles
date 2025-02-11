# Set DOTFILES_PATH env variable to PSScriptRoot's parent path
$env:DOTFILES_PATH=(Split-Path -parent $PSScriptRoot)

Write-Output "DOTFILES_PATH: $env:DOTFILES_PATH"
Read-Host -Prompt "Press any key to continue"

# Copy Files
Copy-Item -Path $env:DOTFILES_PATH\runcom\.vimrc -Destination $HOME\.vimrc
# Copy .vim files to $HOME\vimfiles for windows (instead of ~/.vim for Linux)
Copy-Item -Path $env:DOTFILES_PATH\.vim\* -Destination $HOME\vimfiles -Recurse -Force
# nuget.config file can be found at multiple places, typically the closest to the command pwd is used.
# default is at %appdata%\NuGet\, but in my case it's at C:\nuget.config

#########################
# create a symlink to a location where PowerShell sources its profiles
# WARN: each PowerShell version/type may have a different $PROFILE location. Best to run this on each PS type as admin.
# SymbolicLink requires admin privileges, Junction doesn't but it only links directory
New-Item -Path $PROFILE -ItemType SymbolicLink -Value (Get-Item "$PSScriptRoot\Microsoft.PowerShell_profile.ps1").FullName -Force
# this PS profile loads a bunch of other PS scripts
#########################

# nuget.config file can be found at multiple places, typically the closest to the command pwd is used.
# default is at %appdata%\NuGet\, but in my case it's at C:\nuget.config
New-Item -Path "C:\nuget.config" -ItemType SymbolicLink -Value (Get-Item "$PSScriptRoot\nuget.config").FullName -Force

New-Item -Path "~\.gitconfig" -ItemType SymbolicLink -Value (Get-Item "$PSScriptRoot\.gitconfig").FullName -Force

# Install vim plug here as it's not available in winget repo
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force

# Install vim ctrlp plugin, https://github.com/ctrlpvim/ctrlp.vim
$ctrlpPath = "$HOME/.vim/bundle/ctrlp.vim"
if (Test-Path $ctrlpPath) {
    Write-Host "Vim's ctrlp plugin already exists, skipping."
} else {
    mkdir -p $ctrlpPath -Force
    git clone https://github.com/ctrlpvim/ctrlp.vim.git $ctrlpPath
}
