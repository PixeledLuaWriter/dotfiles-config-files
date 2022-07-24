# Create the powershell user profile text file if it doesn't exist

if(!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
    Set-Content $PROFILE "# Load And Set The Environment For The Profile"
    Add-Content $PROFILE ". $env:USERPROFILE/.config/powershell/user_profile.ps1"
}

# create the .config directory in the user's home directory if it doesn't exist

if(!(Test-Path -Path $env:USERPROFILE/.config)) {
    New-Item -ItemType Directory -Path $env:USERPROFILE/.config -Force
}

# create the powershell directory in the user's .config directory if it doesn't exist

if(!(Test-Path -Path $env:USERPROFILE/.config/powershell)) {
    New-Item -ItemType Directory -Path $env:USERPROFILE/.config/powershell -Force
}

# set a variable with the repository owner's name and the name of the actual repository to
# get the contents of the user_profile.ps1 file from the repository
# and write it into the directory created above

if(!$IsCoreCLR) {
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
}

$repoOwner = "PixeledLuaWriter"
$repoName = "dotfiles-config-files"
$repoFilePath = ".config/powershell"
$repoPath = "https://raw.githubusercontent.com/$repoOwner/$repoName/main/$repoFilePath/$repoFile"
$repoFile = "user_profile.ps1"

if(!(Test-Path -Path "$env:USERPROFILE/.config/powershell/user_profile.ps1")) {
    Invoke-WebRequest $repoPath -OutFile $env:USERPROFILE/.config/powershell/$repoFile
}

if((Get-Command -Name neovim) && !(Test-Path -Path "~/AppData/Local/nvim/init.vim")) {
    Invoke-WebRequest "https://raw.githubusercontent.com/PixeledLuaWriter/dotfiles-config-files/main/.config/nvim/init.vim" -OutFile "~/AppData/Local/nvim/init.vim"
}

if(Test-Path -Path "$PSScriptRoot\prompting.ps1") {
    . "$PSScriptRoot\prompting.ps1"
}