$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$localModulesDir = Join-Path $root Modules

Import-Module PSReadline

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Import-Module "$localModulesDir/posh-alias"

if (-Not (Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
}
Import-Module posh-git

oh-my-posh init pwsh --config "$root/Themes/my-themes/jef.omp.json" | Invoke-Expression

$env:POSH_GIT_ENABLED = $true

Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

Import-Module oh-my-posh
oh-my-posh --init --shell pwsh --config "$root/Themes/my-themes/default.omp.json" | Invoke-Expression
#Set-PoshPrompt -Theme "$root/tema.omp.json"
Set-PoshPrompt -Theme Paradox

if (-Not (Get-Module -ListAvailable -Name posh-cli)) {
    Install-Module posh-cli -Scope CurrentUser
    Install-TabCompletion

    Import-Module posh-dotnet
    Import-Module DockerCompletion
    Import-Module PSKubectlCompletion
}

. "$root/GitFlowAbc.Functions.ps1"
. "$root/CreateAliases.ps1"

Import-Module posh-dotnet
