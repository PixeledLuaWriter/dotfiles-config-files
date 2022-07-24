$repoOwner = "PixeledLuaWriter"
$repoName = "dotfiles-config-files"
#$repoFilePath = ".config/powershell"
$repoPath = "https://raw.githubusercontent.com/$repoOwner/$repoName/main/"

#download the prerequisites

if((Test-Path -Path "$PSScriptRoot\create.ps1") && (Test-Path -Path "$PSScriptRoot\prompting.ps1")) {
    Invoke-WebRequest "$repoPath\create.ps1" -OutFile "$PSScriptRoot\create.ps1"
    Invoke-WebRequest "$repoPath\prompting.ps1" -OutFile "$PSScriptRoot\prompting.ps1"
}