# Declare variables

$repoName = "PowerShell/PowerShell"
$assetPattern = "PowerShell*x64.msi"
$extractDirectory = "../tmp"

# Get latest release of the repo and download the asset with the pattern Microsoft.WindowsTerminal_Win11*.msixbundle

$releasesUri = "https://api.github.com/repos/$repoName/releases/latest"
$asset = (Invoke-WebRequest $releasesUri | ConvertFrom-Json).assets | Where-Object name -like $assetPattern
$downloadUri = $asset.browser_download_url

$extractPath = [System.IO.Path]::Combine($extractDirectory, $asset.name)
Invoke-WebRequest -Uri $downloadUri -Out $extractPath

Start-Process msiexec.exe -Wait -ArgumentList '/I ../tmp/$assetPattern /quiet'