#[Environment]::SetEnvironmentVariable('Foo', 'Bar', 'Machine')
$SERVICOS = "D:\CWI\ABCBank\Servicos\"

#region oh My Posh

#winget upgrade JanDeDobbeleer.OhMyPosh -s winget
Add-Alias ohPoshUpgrade 'winget upgrade JanDeDobbeleer.OhMyPosh -s winget'
#oh-my-posh config migrate glyphs --write

#endregion

#region Winget

#winget list --upgrade-available

#endregion

#region dotnet alias

Add-Alias rebuild 'dotnet clean; dotnet restore --interactive; dotnet build'
Add-Alias build 'dotnet build'
Add-Alias nugetdis 'dotnet nuget disable source'


function Nuget-DisableSource {
    param (
        [Parameter(Mandatory = $true)]
        [string]$source
    )

    #dotnet nuget list source
    #git checkout -b "us-$feature/feat" $from
}
#endregion