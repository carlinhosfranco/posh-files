$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$localModulesDir = Join-Path $root Modules

Import-Module PSReadline
Import-Module "$localModulesDir/posh-alias"

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

if (-Not (Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
}

Import-Module posh-git

oh-my-posh init pwsh --config "$root/Themes/my-themes/carlos.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config 'C:\Users\franc\AppData\Local\Programs\oh-my-posh\themes\amro.omp.json' | Invoke-Expression
#oh-my-posh --init --shell pwsh --config "$root/Themes/my-themes/default.omp.json" | Invoke-Expression
#Set-PoshPrompt -Theme Paradox
#Set-PoshPrompt -Theme "$root/tema.omp.json"

$env:POSH_GIT_ENABLED = $true

Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

if (-Not (Get-Module -ListAvailable -Name posh-cli)) {
    Install-Module posh-cli -Scope CurrentUser
    Install-TabCompletion

    Import-Module posh-dotnet
    Import-Module DockerCompletion
    Import-Module PSKubectlCompletion
}

. "$root/GitFlowAbc.Functions.ps1"
. "$root/CreateAliases.ps1"

if ($env:TERM_PROGRAM -eq "vscode") { . "$(code --locate-shell-integration-path pwsh)" }
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

function gco {
  $branch = git branch -l | fzf --ansi --preview="git log --color=always {1}" --preview-window=up:70%

  if($branch){
    git checkout $branch.trim()
  }
}

Import-Module posh-dotnet
Import-Module posh-cargo
Import-Module posh-dotnet
Import-Module DockerCompletion
Import-Module PSKubectlCompletion
