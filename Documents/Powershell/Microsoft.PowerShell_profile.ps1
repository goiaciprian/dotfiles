Import-Module -Name Terminal-Icons

function snvm() {
  try {
    $version = Get-Content .nvmrc -ErrorAction Stop
    nvm use $version
  }
  catch {
    nvm use newest
  }
}


if($host.Name -eq "ConsoleHost") {
  Import-Module PSReadLine
}

function forecast {
  Param ( [string]$locatie )
  Invoke-RestMethod https://wttr.in/$locatie
}

function gst {
  git status
}


function Get-Git { & git $args }
Set-Alias -Name g -Value Get-Git

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-Alias -Name touch -Value New-Item
Set-Alias -Name grep -Value Select-String
Set-Alias -Name cp -Value Copy-Item -Option AllScope

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

# takes 11 seconds
# Import-Module -Name Microsoft.WinGet.CommandNotFound

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\cipriangodlike.omp.json" | Invoke-Expression


Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })
