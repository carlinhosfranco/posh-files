#[Environment]::SetEnvironmentVariable('Foo', 'Bar', 'Machine')
$SERVICOS = "D:\CWI\ABCBank\Servicos\"


#oh My Posh
Add-Alias ohPoshUpgrade 'winget upgrade JanDeDobbeleer.OhMyPosh -s winget'
#oh-my-posh config migrate glyphs --write

#dotnet alias
Add-Alias rebuild 'dotnet clean; dotnet restore --interactive; dotnet build'
Add-Alias build 'dotnet build'