# Clear Default Startup Text

Clear-Host

Start-Sleep -Milliseconds 300

Write-Host "Please Wait While The Profile Configuration Loads" -ForegroundColor Yellow
Start-Sleep -Milliseconds 500

Write-Host "." -ForegroundColor Yellow
Start-Sleep -Milliseconds 300

Write-Host ".." -ForegroundColor Yellow
Start-Sleep -Milliseconds 300

Write-Host "..." -ForegroundColor Yellow

# Reset Powershell's Text Encoding

Write-Host "Resetting PowerShell's Text Encoding"

[Console]::InputEncoding = New-Object System.Text.UTF8Encoding
[Console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Start-Sleep -Milliseconds 300

# Importing Main Pieces Of Customization Engine

Write-Host "Loading Up Customization Modules And The Customization Engine From Oh-My-Posh" -ForegroundColor Green

Import-Module -Name posh-git
Import-Module -Name oh-my-posh
Import-Module -Name Terminal-Icons

# Initiating Oh My Powershell Customizer

oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH/atomic.omp.json | Invoke-Expression

Clear-Host

# Setting Aliases

Set-Alias -Name vim -Value nvim
Set-Alias -Name gt -Value git
Set-Alias -Name grep -Value findstr
Set-Alias -Name tig -Value 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias -Name less -Value 'C:\Program Files\Git\usr\bin\less.exe'

# Setting PSReadLine Stuff

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Setting PSFzf (Powershell Fuzzy Finder)

Import-Module -Name PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# GitSSH Env

$env:GIT_SSH = "C:\Windows\System32\OpenSSH\ssh.exe"

# Utility Stuff

function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
