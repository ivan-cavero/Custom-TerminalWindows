$username=( ( Get-WMIObject -class Win32_ComputerSystem | Select-Object -ExpandProperty username ) -split '\\' )[1]
$path1 = "C:\Users\$username\.config\powershell"

mkdir -p $path1

cp -r ..\config\user_profile.ps1 $path1

cp -r ..\config\ivan.omp.json $path1

$path2 = "C:\Users\$username\Documents\PowerShell"

cp -r ..\config\Microsoft.PowerShell_profile.ps1 $path2