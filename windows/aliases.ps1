
# Easier Navigation: .., ..., ...., ....., and ~
${function:~} = { Set-Location ~ }
# PoSh won't allow ${function:..} because of an invalid path error, so...
${function:Set-ParentLocation} = { Set-Location .. }; Set-Alias ".." Set-ParentLocation
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }

# Navigation Shortcuts
${function:cdcpxage} = { Set-Location C:\git\One\CPX-AGE }
${function:cdacr} = { Set-Location C:\AI-AzureCIP-Distribution }
${function:cdacrbuildout} = { Set-Location C:\AI-AzureCIP-Distribution\src\AI.DataDistribution\AzureConsumptionRevenue\AcrInfra_Bootstrap\Airgap_Infra_Deployment }
${function:cddotfiles} = { Set-Location C:\Users\chasetran\source\repos\dotfiles }
${function:cddesktop} = { Set-Location ~\Desktop }

# Correct PowerShell Aliases if tools are available (aliases win if set)
# Directory Listing: Use `ls.exe` if available
if (Get-Command ls.exe -ErrorAction SilentlyContinue | Test-Path) {
    rm alias:ls -ErrorAction SilentlyContinue
    # Set `ls` to call `ls.exe` and always use --color
    ${function:ls} = { ls.exe --color @args }
    # List all files in long format
    ${function:ll} = { ls -lF @args }
    # List all files in long format, including hidden files
    ${function:la} = { ls -laF @args }
    # List only directories
    ${function:lsd} = { Get-ChildItem -Directory -Force @args }
} else {
    # List all files, including hidden files
    ${function:la} = { ls -Force @args }
    Set-Alias ll la
    # List only directories
    ${function:lsd} = { Get-ChildItem -Directory -Force @args }
}

# WGet: Use `wget.exe` if available
if (Get-Command wget.exe -ErrorAction SilentlyContinue | Test-Path) {
	rm alias:wget -ErrorAction SilentlyContinue
}

# curl: Use `curl.exe` if available
if (Get-Command curl.exe -ErrorAction SilentlyContinue | Test-Path) {
    rm alias:curl -ErrorAction SilentlyContinue
    # Set `ls` to call `ls.exe` and always use --color
    ${function:curl} = { curl.exe @args }
    # Gzip-enabled `curl`
    ${function:gurl} = { curl --compressed @args }
} else {
    # Gzip-enabled `curl`
    ${function:gurl} = { curl -TransferEncoding GZip }
}

# Create a new directory and enter it
Set-Alias mkd CreateAndSet-Directory

# Determine size of a file or total size of a directory
Set-Alias fs Get-DiskUsage

# Empty the Recycle Bin on all drives
Set-Alias emptytrash Empty-RecycleBin

# Cleanup old files all drives
Set-Alias cleandisks Clean-Disks

# Reload the shell
Set-Alias reload Reload-Powershell

# Update installed Ruby Gems, NPM, and their installed packages.
Set-Alias update System-Update

# Set GVim as default vim
Set-Alias vim gvim
