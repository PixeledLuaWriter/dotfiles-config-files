# Clear Default Bullshit Lol

Clear-Host

# Reset Powershell's Text Encoding

[Console]::InputEncoding = New-Object System.Text.UTF8Encoding
[Console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Checking If posh-git, oh-my-posh, Terminal-Icons, z, and PSFzf Are Installed From PSGallery

if(!(Get-Module -Name posh-git) && !(Get-Module -Name oh-my-posh) && !(Get-Module -Name Terminal-Icons) && !(Get-Module -Name z) && !(Get-Module -Name PSFzf)){
	Write-Host "Installing posh-git, oh-my-posh, Terminal-Icons, z, and PSFzf From PSGallery" -ForegroundColor Yellow
	Install-Module -Name posh-git -Scope CurrentUser -Force
	Install-Module -Name oh-my-posh -Scope CurrentUser -Force
	Install-Module -Name Terminal-Icons -Scope CurrentUser -Repository PSGallery -Force
	Install-Module -Name z -Scope CurrentUser -Force -AllowClobber
	Install-Module -Name PSFzf -Scope CurrentUser -Force
} else {
	Write-Host "posh-git, oh-my-posh, Terminal-Icons, z, and PSFzf Are Already Installed"
}

if ((Get-Module -Name PSReadline)) {
	Write-Host "Updating PSReadline to Prerelease Version" -ForegroundColor Yellow
	Install-Module -Name PSReadline -Scope CurrentUser -Force -AllowPrerelease -SkipPublisherCheck
}

# Importing Main Pieces Of Customization Engine

Import-Module -Name posh-git
Import-Module -Name oh-my-posh
Import-Module -Name Terminal-Icons
Import-Module -Name PSFzf

# Initiating Oh My Powershell Customizer

oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH/atomic.omp.json | Invoke-Expression

Clear-Host

# Setting Aliases

Set-Alias -Name vim -Value nvim
Set-Alias -Name gt -Value git
Set-Alias -Name grep -Value findstr
Set-Alias -Name tig -Value 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias -Name less -Value 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias -Name bash -Value 'C:\Program Files\Git\usr\bin\bash.exe'

# Setting PSReadLine Stuff

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Setting PSFzf (Powershell Fuzzy Finder)

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# GitSSH Env

$env:GIT_SSH = "C:\Windows\System32\OpenSSH\ssh.exe"

# Utility Stuff

function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
