$moduleName = "VcRedist"
$extractDirectory = "./tmp"

Install-Module -Name $moduleName -Force
Import-Module -Name $moduleName
Get-VcList -Export All
New-Item $extractDirectory/VcRedist -ItemType Directory
Get-VcList | Get-VcRedist -Path $extractDirectory/VcRedist
Get-VcList | Install-VcRedist -Path $extractDirectory/VcRedist