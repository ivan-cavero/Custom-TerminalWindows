$username=( ( Get-WMIObject -class Win32_ComputerSystem | Select-Object -ExpandProperty username ) -split '\\' )[1]
$path = "C:\Users\$username"

mkdir -p $path\.config\powershell

cp -r ..\config\user_profile.ps1 $path\.config\powershell