# Set DOTFILES_PATH env variable to PSScriptRoot's parent path
$env:DOTFILES_PATH=(Split-Path -parent $PSScriptRoot)

Write-Output "Ensure you're running this script as admin."
Write-Output "DOTFILES_PATH: $env:DOTFILES_PATH"
Read-Host -Prompt "Press any key to continue"

# Link .vimrc
New-Item -Path $HOME\.vimrc -ItemType SymbolicLink -Value (Get-Item "$env:DOTFILES_PATH\runcom\.vimrc").FullName -Force

# Copy .vim files to $HOME\vimfiles for windows (instead of ~/.vim for Linux)
Copy-Item -Path $env:DOTFILES_PATH\.vim\* -Destination $HOME\vimfiles -Recurse -Force
# Don't want to symlink the .vim directory as I don't want new files to be created in this directory
# New-Item -Path $HOME\vimfiles -ItemType SymbolicLink -Value (Get-Item "$env:DOTFILES_PATH\.vim").FullName -Force

# WARN: each PowerShell version/type may have a different $PROFILE location. Best to run this on each PS type as admin.
# PowerShell 7 intentionally uses a different profile location than Windows PowerShell 5.1 to avoid conflicts.
$source_ps_profile = (Get-Item "$PSScriptRoot\Microsoft.PowerShell_profile.ps1").FullName
$dest_ps5_profile = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
$dest_ps7_profile = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
New-Item -Path $dest_ps5_profile -ItemType SymbolicLink -Value $source_ps_profile -Force
New-Item -Path $dest_ps7_profile -ItemType SymbolicLink -Value $source_ps_profile -Force

# nuget.config file can be found at multiple places, typically the closest to the command pwd is used.
# default is at %appdata%\NuGet\, but in my case it's at C:\nuget.config
New-Item -Path "C:\nuget.config" -ItemType SymbolicLink -Value (Get-Item "$PSScriptRoot\nuget.config").FullName -Force

New-Item -Path "~\.gitconfig" -ItemType SymbolicLink -Value (Get-Item "$PSScriptRoot\.gitconfig_global").FullName -Force
New-Item -Path "~\.gitignore_global" -ItemType SymbolicLink -Value (Get-Item "$PSScriptRoot\.gitignore_global").FullName -Force

Copy-Item -Path $env:DOTFILES_PATH\.git\config -Destination $env:DOTFILES_PATH\.git\config_backup
New-Item -Path $env:DOTFILES_PATH\.git\config -ItemType SymbolicLink -Value (Get-Item "$PSScriptRoot\.gitconfig_local").FullName -Force

# Restore Windows "Quick Access" settings
$quick_access_script = Join-Path $PSScriptRoot "quick_access\restore_settings.ps1"
& $quick_access_script

# if nuget is already installed, skip the installation
$nugetPath = "C:\Program Files\PackageManagement\ProviderAssemblies\nuget"
if (Test-Path $nugetPath) {
    Write-Host "NuGet is already installed, skipping."
} else {
    Write-Host "Installing NuGet PowerShell module from PSGallery..."
    Install-PackageProvider -Name NuGet -Force -Scope CurrentUser | Out-Null
    Write-Host "Done."
}

# Install WinGet, which is a package manager for Windows, similar to apt-get or brew
# if WinGet is already installed, skip the installation
$wingetPath = "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*\winget.exe"
if (Test-Path $wingetPath) {
    Write-Host "WinGet is already installed, skipping."
} else {
    $progressPreference = 'silentlyContinue'
    Write-Host "Installing WinGet PowerShell module from PSGallery..."
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
    Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
    Repair-WinGetPackageManager
    Write-Host "Done."
}

winget install -e --id Microsoft.PowerShell # latest PowerShell
winget install -e --id Git.Git # install Git for Windows with Git SCM
winget install -e --id Notepad++.Notepad++
winget install -e --id GitHub.GitHubDesktop
# winget install -e --id GitHub.cli	## for auth and caching credentials, use command: gh auth login
# winget install -e --id Microsoft.GitCredentialManagerCore ## already installed with latest Git for Windows
winget install -e --id 7zip.7zip
# winget install -e --id Adobe.Acrobat.Reader.64-bit
winget install -e --id GIMP.GIMP
winget install -e --id Google.Chrome
winget install -e --id Logitech.GHUB
winget install -e --id Microsoft.SQLServerManagementStudio
winget install -e --id Microsoft.AzureStorageExplorer
winget install -e --id Microsoft.AzureCLI
winget install -e --id Yubico.YubikeyManager
winget install -e --id TheOSCARTeam.OSCAR # for CPAP
winget install -e --id splode.pomotroid # Pomodoro timer
winget install -e --id Zoom.Zoom
winget install fzf # fzf for vim
winget install -e --id Python.Python.3.11
winget install --id=astral-sh.uv -e # UV Python package manager, for creating mcp server

# if VS Code Insider is already installed, skip the installation
$vsCodeInsidersPath = "C:\Users\chasetran\AppData\Local\Programs\Microsoft VS Code Insiders"
if (Test-Path $vsCodeInsidersPath) {
    Write-Host "VS Code Insiders is already installed, skipping."
} else {
    Write-Host "Installing VS Code Insiders..."
    winget install -e --id Microsoft.VisualStudioCode.Insiders
}

# if Visual Studio 2022 Community is already installed, skip the installation
$vs2022Path = "C:\Program Files\Microsoft Visual Studio\2022\Community"
if (Test-Path $vs2022Path) {
    Write-Host "Visual Studio 2022 Community is already installed, skipping."
} else {
    Write-Host "Installing Visual Studio 2022 Community..."
    winget install -e --id Microsoft.VisualStudio.2022.Community # newer version available in Microsoft Store
}

Write-Host "Installing NPM..."
winget install -e --id OpenJS.NodeJS # latest Node.JS and NPM
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") # reload the environment variables to get npm in PATH
npm install -g vsts-npm-auth # for Microsoft npm auth
# if npmrc file already exists, skip the installation
# copy instead of symlink as the file will contain sensitive information
$npmrcPath = "$HOME\.npmrc"
if (Test-Path $npmrcPath) {
    Write-Host ".npmrc file already exists, skipping."
} else {
    Write-Host "Creating .npmrc file..."
    Copy-Item -Path (Get-Item "$PSScriptRoot\.npmrc").FullName -Destination $npmrcPath
}

<#
$windows_terminal_settings = "C:\Users\chasetran\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
if (Test-Path $windows_terminal_settings) {
    Write-Host "Windows Terminal Settings already exist, skipping."
} else {
    Write-Host "Installing Windows Terminal Settings..."
    New-Item -Path $windows_terminal_settings -ItemType SymbolicLink -Value (Get-Item "$env:DOTFILES_PATH\windows\windows_terminal_settings.json").FullName -Force
    winget install -e --id Microsoft.VisualStudioCode.Insiders
}
#>

# Install gVim
winget install -e --id vim.vim

# Install vim plug for Windows as it's not available in winget repo
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force

# Install vim plug for Unix as it's used by git bash (git commit --amend)
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/.vim/autoload/plug.vim -Force

# Install vim ctrlp plugin, https://github.com/ctrlpvim/ctrlp.vim
$ctrlpPath = "$HOME/.vim/bundle/ctrlp.vim"
if (Test-Path $ctrlpPath) {
    Write-Host "Vim's ctrlp plugin already exists, skipping."
} else {
    mkdir -p $ctrlpPath -Force
    git clone https://github.com/ctrlpvim/ctrlp.vim.git $ctrlpPath
}

# Install chocolatey
# Chocolatey is a package manager for Windows, similar to apt-get or brew or winget
# if chocolatey is already installed, skip the installation
$chocoPath = "C:\ProgramData\chocolatey"
if (Test-Path $chocoPath) {
    Write-Host "Chocolatey is already installed, skipping."
} else {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

$npp_script = Join-Path $PSScriptRoot "notepadpp_restore_settings.ps1"
& $npp_script


Write-Host
Write-Host
Write-Host "--------------------------------------------------------------"
Write-Host "Next (Manual) Steps:"
Write-Host "  Use the built-in VS Code Settings Sync functionality in VS Code to sync settings, keybindings, snippets, and extensions across devices"
Write-Host "    https://code.visualstudio.com/docs/editor/settings-sync"
Write-Host "    VS Code > Settings Sync > Turn on"
Write-Host
Write-Host "  Install Brother printer tools"
Write-Host "    https://support.brother.com/g/b/downloadtop.aspx?c=us&lang=en&prod=hll2350dw_us_eu_as"
Write-Host "    https://support.brother.com/g/b/downloadtop.aspx?c=us&lang=en&prod=ds640_us_eu_as"
Write-Host
Write-Host "  Use 'Company Portal' app to install Microsoft Smart Card Manager"
Write-Host "  Use 'Company Portal' app to install Adobe Creative Cloud Apps. Once installed, open App > Help > Sign in with browser > use Msft account. Then go to Apps menu > install Acrobat and Photoshop"
Write-Host
Write-Host "  Change Teams settings (Appearance > Theme > Dark; Devices > Camera). No way to automate this yet."
Write-Host
Write-Host "  For Windows personalization, change the colors that appear in Windows and your apps to Dark."
Write-Host "  Change Windows Settings > Personalization (Theme > Dark; Color > Dark). Automation doesn't work well."
Write-Host
Write-Host "  Add auth token to .npmrc"
Write-Host "    https://dev.azure.com/msazure/One/_artifacts/feed/cpx-age-zerotouch-Consumption/connect"
Write-Host "    https://microsoft.visualstudio.com/Universal%20Store/_artifacts/feed/ccp_ptt_availability/connect"
Write-Host
Write-Host "  Install Github Copilot CLI
Write-Host "    https://docs.github.com/en/copilot/managing-copilot/configure-personal-settings/installing-github-copilot-in-the-cli
Write-Host "--------------------------------------------------------------"
