# create a symlink to a location where PowerShell sources its profiles
# WARN: each PowerShell version/type may have a different $PROFILE location. Best to run this on each PS type as admin.
# SymbolicLink requires admin privileges, Junction doesn't but it only links directory

#New-Item -Path ~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Value (Get-Item ".\Microsoft.PowerShell_profile.ps1").FullName
# New-Item -Path "$env:OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Value (Get-Item ".\Microsoft.PowerShell_profile.ps1").FullName -Force

New-Item -Path $PROFILE -ItemType SymbolicLink -Value (Get-Item ".\Microsoft.PowerShell_profile.ps1").FullName -Force
