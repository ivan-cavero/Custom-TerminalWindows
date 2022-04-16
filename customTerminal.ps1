# Check if script is runing in root
if ('S-1-5-32-544' -notin [System.Security.Principal.WindowsIdentity]::GetCurrent().Groups) {
    throw 'Script must run as admin!'
}

# Install scoop
iwr -useb get.scoop.sh | iex

# Install curl
scoop install curl sudo jq

# Install Git
winget install -e --id Git.Git

# Install NeoVim
scoop install neovim gcc
