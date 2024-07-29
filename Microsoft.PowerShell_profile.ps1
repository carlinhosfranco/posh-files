<# Issues

Dotnet Tab completion: https://learn.microsoft.com/en-us/dotnet/core/tools/enable-tab-autocomplete

#Help Commands
#oh-my-posh config migrate glyphs --write

#>

# A new release of Oh My Posh is available: v21.16.0 → v21.16.2
# To upgrade, run: 'oh-my-posh upgrade'

# To enable automated upgrades, set 'auto_upgrade' to 'true' in your configuration.

$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$localModulesDir = Join-Path $root Modules

#region Add Alias

Import-Module "$localModulesDir/posh-alias"
#. "$root/CreateAliases.ps1"
. "$root/Aliases/GeneralAliases.ps1"
. "$root/Aliases/GitAliases.ps1"

#External Codes
. "$root/ExternalCodes/rustTabCompletion.ps1"

#endregion

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

#region Import Modules

#Import-Module "$localModulesDir/posh-alias"
Import-Module PSReadline
Import-Module posh-git

#endregion

#region Configs

oh-my-posh init pwsh --config "$root/Themes/my-themes/carlos.omp.json" | Invoke-Expression

$env:POSH_GIT_ENABLED = $true

Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

if ($env:TERM_PROGRAM -eq "vscode") { . "$(code --locate-shell-integration-path pwsh)" }

#endregion