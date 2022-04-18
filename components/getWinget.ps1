# Declare variables
$repoName = "microsoft/winget-cli"
$assetPattern = "Microsoft.DesktopAppInstaller_*.msixbundle"
$extractDirectory = "./tmp"

# Get latest release of the repo and download the asset with the pattern Microsoft.DesktopAppInstaller_*.msixbundle
$releasesUri = "https://api.github.com/repos/$repoName/releases/latest"
$asset = (Invoke-WebRequest $releasesUri | ConvertFrom-Json).assets | Where-Object name -like $assetPattern
$downloadUri = $asset.browser_download_url

$extractPath = [System.IO.Path]::Combine($extractDirectory, $asset.name)
Invoke-WebRequest -Uri $downloadUri -OutFile $extractPath

Add-AppPackage -path "./tmp/$assetPattern"