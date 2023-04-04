# create a symlink to a location where PowerShell sources its profiles
#New-Item -Path ~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Value (Get-Item ".\Microsoft.PowerShell_profile.ps1").FullName
New-Item -Path $PROFILE -ItemType SymbolicLink -Value (Get-Item ".\Microsoft.PowerShell_profile.ps1").FullName -Force