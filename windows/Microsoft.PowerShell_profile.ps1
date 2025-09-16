# Use symlink.ps1 to link this file to PowerShell profile location
# examples: https://github.com/jayharris/dotfiles-windows

# .\components.ps1 : Load various PowerShell components and modules.
# .\functions.ps1 : Configure custom PowerShell functions.
# .\aliases.ps1 : Configure alias-based commands.
# .\exports.ps1 : Configure environment variables.
# .\extra.ps1 : Secrets and secret commands that are not tracked by the Git repository.

# .\dependencies.ps1  # Dependencies: Tools, Utilities, and Packages

# source existing files
Push-Location (Split-Path -parent (Get-Item $PROFILE).Target)
"components","functions","aliases","exports","extra" | Where-Object {Test-Path "$_.ps1"} | ForEach-Object -process {Invoke-Expression ". .\$_.ps1"}
Pop-Location

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

