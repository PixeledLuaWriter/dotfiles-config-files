# Ask The User If They Want To Install Git, Node.JS, and Scoop
# If Yes, Install Git and Node.JS Via Winget and Scoop Via An Invoked WebRequest
if(!(Test-Path -Path "C:\Program Files\Git\bin\git.exe") && !(Test-Path -Path "C:\Program Files\nodejs\node.exe") && !(Test-Path -Path "C:\Program Files\Scoop\Scoop.exe")) {
    Write-Host "Do You Want To Install Git, Node.JS, and Scoop?"
    Write-Host "Type 'yes' To Install Git, Node.JS, and Scoop Or Type 'no' To Exit"

    $answr = Read-Host ": "

    if($answr -eq "yes") {
        Write-Host "Installing Git, Node.JS, and Scoop"
        winget install -id Git.Git -e --source winget
        winget install -id OpenJS.NodeJS -e --source winget
        Invoke-WebRequest -UseBasicParsing get.scoop.sh | Invoke-Expression
    } else {
        Write-Host "Exiting"
        exit
    }
}

# Ask the user if they want to install either vim or neovim in scoop
if(!(Get-Command -Name vim) && !(Get-Command -Name nvim)) {
    Write-Host "Do You Want To Install Vim Or Neovim?"
    Write-Host "Type 'vim' To Install Vim Or Type 'nvim' To Install Neovim Or Type 'no' To Exit"

    $answr = Read-Host ": "

    if($answr -eq "vim") {
        Write-Host "Installing Vim"
        scoop install vim
    } elseif($answr -eq "nvim") {
        Write-Host "Installing Neovim"
        scoop install neovim
    } else {
        Write-Host "Exiting"
        exit
    }
}