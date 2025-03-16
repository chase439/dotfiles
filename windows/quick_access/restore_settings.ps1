Write-Host "Restoring Quick Access settings..."

$sourceFile = "$PSScriptRoot\f01b4d95cf55d32a.automaticDestinations-ms"
$destinationFile = "$env:AppData\Microsoft\Windows\Recent\AutomaticDestinations\f01b4d95cf55d32a.automaticDestinations-ms"

# Check if the source file exists
if (Test-Path -Path $sourceFile -PathType Leaf) {

    # Check if the destination directory exists
    if (Test-Path -Path (Split-Path $destinationFile) -PathType Container) {
        # Replace the file
        New-Item -Path $destinationFile -ItemType SymbolicLink -Value (Get-Item "$sourceFile").FullName -Force

        Write-Host "Quick Access file replaced successfully."
    } else {
        Write-Warning "Destination directory not found."
    }
} else {
    Write-Warning "Source file not found."
}