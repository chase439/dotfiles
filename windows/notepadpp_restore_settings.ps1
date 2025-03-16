Write-Host "Restoring Notepad++ settings..."

# Get the AppData path
$appdata = $env:AppData
$npp_dir = Join-Path $appdata "Notepad++"
$backup_dir = Join-Path $appdata "Notepad++backup"
$my_notepadpp_dir = Join-Path $PSScriptRoot "notepadpp"

# Create the Notepad++ directory if it doesn't exist
if (!(Test-Path -Path $npp_dir -PathType Container)) {
    New-Item -ItemType Directory -Path $npp_dir | Out-Null
}

# Backup original data
if (Test-Path -Path $backup_dir -PathType Container) {
    Write-Host "Backup directory already exists, skipping backup."
} else {
    New-Item -ItemType Directory -Path $backup_dir | Out-Null
    Write-Host "Backing up original Notepad++ settings..."
    Copy-Item -Path "$npp_dir\*" -Destination $backup_dir -Recurse -Force
}

# Copy the configuration files
$source_files = Get-ChildItem -Path "$my_notepadpp_dir\*" -File
foreach ($file in $source_files) {
    Copy-Item -Path $file.FullName -Destination $npp_dir -Force
}

#Copy plugin folders
$source_folders = Get-ChildItem -Path "$my_notepadpp_dir\*" -Directory
foreach($folder in $source_folders){
    Copy-Item -Path $folder.FullName -Destination $npp_dir -Recurse -Force
}

Write-Host "Notepad++ settings restored."