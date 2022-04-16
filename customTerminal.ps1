# Check if script is runing in root
if ('S-1-5-32-544' -notin [System.Security.Principal.WindowsIdentity]::GetCurrent().Groups) {
    throw 'Script must run as admin!'
}

# Import installFonts
$ScriptRunInstallFonts= $PSScriptRoot+"\components\installFonts.ps1"
&$ScriptRunInstallFonts

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

# Import userProfile
$ScriptRunUserProfile= $PSScriptRoot+"\components\userProfile.ps1"
&$ScriptRunUserProfile

# Install Oh My Posh
Install-Module posh-git -Scope CurrentUser -Force
Install-Module oh-my-posh -Scope CurrentUser -Force

# Install nvm
scoop install nvm

# Install Terminal Icons
Install-Module -Name TerminalIcons -Repository PSGallery -Force

# Install Z Shell
Install-Module -Name z -Force

# Install PSReadLine - AutoCompletion
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck

# Install fzf
scoop install fzf
Install-Module -Name PSFzf -Scope CurrentUser -Force