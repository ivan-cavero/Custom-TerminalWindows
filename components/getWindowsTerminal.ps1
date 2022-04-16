# Declare variables

$repoName = "microsoft/terminal"
$assetPattern = "Microsoft.WindowsTerminal_Win11*.msixbundle"
$extractDirectory = "../tmp"

# Get latest release of the repo and download the asset with the pattern Microsoft.WindowsTerminal_Win11*.msixbundle

$releasesUri = "https://api.github.com/repos/$repoName/releases/latest"
$asset = (Invoke-WebRequest $releasesUri | ConvertFrom-Json).assets | Where-Object name -like $assetPattern
$downloadUri = $asset.browser_download_url

$extractPath = [System.IO.Path]::Combine($extractDirectory, $asset.name)
Invoke-WebRequest -Uri $downloadUri -Out $extractPath

Add-AppPackage -path "../tmp/Microsoft.WindowsTerminal_Win11*.msixbundle"

# Set Windows Terminal as default

$configLocation = "C:\Users\ivang\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$config = Get-Content $configLocation
$config.defaultApp = "Microsoft.WindowsTerminal_8wekyb3d8bbwe"
Set-Content $configLocation $config

