# Check if script is runing in root
if ('S-1-5-32-544' -notin [System.Security.Principal.WindowsIdentity]::GetCurrent().Groups) {
    throw 'Script must run as admin!'
}

$ProgressPreference = 'SilentlyContinue'

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Set-ExecutionPolicy Unrestricted

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 2

# Unlock scripts
Get-ChildItem -Filter *.ps1 | Unblock-File
Get-ChildItem -Filter .\components\*.ps1 | Unblock-File

mkdir .\tmp -Force

# Update NuGet packages
Install-Module PowershellGet -Force

# Import installFonts
$ScriptRunInstallFonts= $PSScriptRoot+"\components\installFonts.ps1"
&$ScriptRunInstallFonts

# Install dependencies for components (e.g. .VC++)
$ScriptRunGetVLC= $PSScriptRoot+"\components\getVCLibs.ps1"
&$ScriptRunGetVLC
$ScriptRunGetVcRedist= $PSScriptRoot+"\components\getVcRedist.ps1"
&$ScriptRunGetVcRedist
$ScriptRunGetWinget= $PSScriptRoot+"\components\getWinget.ps1"
&$ScriptRunGetWinget

# Import getWindowsTerminal
$ScriptRunWindowsTerminal= $PSScriptRoot+"\components\getWindowsTerminal.ps1"
&$ScriptRunWindowsTerminal

# Import getPowerShell
$ScriptRunPowerShell= $PSScriptRoot+"\components\getPowerShell.ps1"
&$ScriptRunPowerShell

# Install scoop
iwr -useb get.scoop.sh -outfile '.\tmp\scoop.ps1'
.\tmp\scoop.ps1 -RunAsAdmin

# Install curl
scoop install curl sudo jq

# Install Git
winget install -e --id Git.Git

# Install NeoVim
scoop install neovim gcc

# Start wt and sleep for it starts
wt
sleep 5
taskkill /f /im WindowsTerminal.exe

# Import userProfile
$ScriptRunUserProfile= $PSScriptRoot+"\components\userProfile.ps1"
&$ScriptRunUserProfile

# Install Oh My Posh
Install-Module posh-git -Scope CurrentUser -Force
Install-Module oh-my-posh -Scope CurrentUser -Force

# Install nvm
scoop install nvm

# Install Terminal Icons
Install-Module -Name Terminal-Icons -Repository PSGallery -Force

# Install Z Shell
Install-Module -Name z -Force -AllowClobber

# Install PSReadLine - AutoCompletion
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

# Install fzf
scoop install fzf
Install-Module -Name PSFzf -Scope CurrentUser -Force

# Remove all tmp files
Remove-Item -path ".\tmp" -Force -Recurse -ErrorAction SilentlyContinue

# Finish message
wt
echo "Installation finished!"
