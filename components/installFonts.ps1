# Declare variables

$repoName = "ryanoasis/nerd-fonts"
$assetPattern = "Hack.zip"
$extractDirectory = "./tmp"
$fontsFolder = "./tmp/fonts"

# Get latest release of the repo and download the asset with the pattern Hack.zip

$releasesUri = "https://api.github.com/repos/$repoName/releases/latest"
$asset = (Invoke-WebRequest $releasesUri | ConvertFrom-Json).assets | Where-Object name -like $assetPattern
$downloadUri = $asset.browser_download_url

$extractPath = [System.IO.Path]::Combine($extractDirectory, $asset.name)
Invoke-WebRequest -Uri $downloadUri -Out $extractPath

# Extract the zip file

Expand-Archive -path "./tmp/$assetPattern" -destinationpath $fontsFolder -Force

# Install the fonts

$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
foreach ($file in gci $fontsFolder/*.ttf)
{
    $fileName = $file.Name
    if (-not(Test-Path -Path "C:\Windows\fonts\$fileName" )) {
        echo $fileName
        dir $file | %{ $fonts.CopyHere($_.fullname) }
    }
}
cp *.ttf c:\windows\fonts\