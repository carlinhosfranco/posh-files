#winget upgrade JanDeDobbeleer.OhMyPosh -s winget
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
    Import-Module posh-cargo
}

#. "$root/CreateAliases.ps1"
. "$root/Aliases/GeneralAliases.ps1"
. "$root/Aliases/GitAliases.ps1"

if ($env:TERM_PROGRAM -eq "vscode") { . "$(code --locate-shell-integration-path pwsh)" }

# Import-Module posh-cargo
# Import-Module posh-dotnet
# Import-Module DockerCompletion
# Import-Module PSKubectlCompletion

# $previousOutputEncoding = [Console]::OutputEncoding
# [Console]::OutputEncoding = [Text.Encoding]::UTF8

# try {
#     oh-my-posh init pwsh --config ~/custom.omp.json | Invoke-Expression
# } finally {
#     [Console]::OutputEncoding = $previousOutputEncoding
# }

#Help Commands
#oh-my-posh config migrate glyphs --write