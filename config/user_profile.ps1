# Prompt
Import-Module posh-git
Import-Module oh-my-posh
# Set-PoshPrompt Paradox

# Load promt config
function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'ivan.omp.json'
oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression

# Icons
Import-Module -Name Terminal-Icons

# PSreadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSreadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Alias
Set-Alias vs code
Set-Alias na nano
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
# Set-Alias tig 'C:\Apps\Git\usr\bin\tig.exe'
# Set-Alias less 'C:\Apps\Git\usr\bin\less.exe'
Set-Alias node16 'nvm use 16.14.0'
Set-Alias node17 'nvm use 17.6.0'
Set-Alias gad 'git all .'
Set-Alias gc 'gitmoji -c'

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
