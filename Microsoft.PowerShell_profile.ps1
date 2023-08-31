$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$localModulesDir = Join-Path $root Modules

Import-Module PSReadline

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Import-Module "$localModulesDir/posh-alias"
#
if (-Not (Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
}
Import-Module posh-git

oh-my-posh init pwsh --config "$root/Themes/my-themes/jef.omp.json" | Invoke-Expression

$env:POSH_GIT_ENABLED = $true
Import-Module posh-git
oh-my-posh init pwsh | Invoke-Expression
# if (-Not (Get-Module -ListAvailable -Name oh-my-posh)) {
#     Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease -Force
# }

Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
#Import-Module oh-my-posh
oh-my-posh init pwsh --config 'C:\Users\franc\AppData\Local\Programs\oh-my-posh\themes\amro.omp.json' | Invoke-Expression


if (-Not (Get-Module -ListAvailable -Name posh-cli)) {
    Install-Module posh-cli -Scope CurrentUser
    Install-TabCompletion

    Import-Module posh-dotnet
    Import-Module DockerCompletion
    Import-Module PSKubectlCompletion
}

Import-Module oh-my-posh
oh-my-posh --init --shell pwsh --config "$root/Themes/my-themes/default.omp.json" | Invoke-Expression
#Set-PoshPrompt -Theme "$root/tema.omp.json"
Set-PoshPrompt -Theme Paradox

. "$root/GitFlowAbc.Functions.ps1"
. "$root/CreateAliases.ps1"

if ($env:TERM_PROGRAM -eq "vscode") { . "$(code --locate-shell-integration-path pwsh)" }
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

# function gco {
#     $branch = git branch -l | fzf

#     if($branch){
#       git checkout $branch.trim()
#     }
# }

#--preview-window=up:70%
function gco {
  $branch = git branch -l | fzf --ansi --preview="git log --color=always {1}" --preview-window=up:70%

  if($branch){
    git checkout $branch.trim()
  }
}


Import-Module posh-dotnet
