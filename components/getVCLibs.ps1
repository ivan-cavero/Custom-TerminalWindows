$repoName = "Microsoft.VCLibs.x64.14.00.Desktop.appx"
$downloadUri = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
$extractDirectory = "./tmp"

$extractPath = [System.IO.Path]::Combine($extractDirectory, $repoName)
Invoke-WebRequest -Uri $downloadUri -OutFile $extractPath
Add-AppPackage -path "./tmp/Microsoft.VCLibs*.appx"