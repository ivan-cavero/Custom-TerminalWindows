$username=( ( Get-WMIObject -class Win32_ComputerSystem | Select-Object -ExpandProperty username ) -split '\\' )[1]
$user_profile = "C:\Users\$username\.config\powershell"

mkdir -p $user_profile

cp -r ..\config\user_profile.ps1 $user_profile

cp -r ..\config\ivan.omp.json $user_profile

$powershell_profile = "C:\Users\$username\Documents\PowerShell"

cp -r ..\config\Microsoft.PowerShell_profile.ps1 $powershell_profile

# Set Windows Terminal as default

$configLocation = "C:\Users\$username\AppData\Local\Packages\Microsoft.WindowsTerminal_*\LocalState\settings.json"

cp -r ..\config\settings.json $configLocation



