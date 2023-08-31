Add-Alias co 'git checkout'
Add-Alias gst 'git status'
Add-Alias grb 'git rebase'
Add-Alias glg 'git log --oneline -10'
Add-Alias fetch 'git fetch'
Add-Alias push 'git push'
Add-Alias pull 'git pull'
Add-Alias pushsync 'git push --set-upstream origin HEAD'
Add-Alias fush 'git push --force-with-lease'
Add-Alias gredev 'git reset --hard origin/develop'

function glog {
    git log --oneline -$args
}

#dotnet alias
Add-Alias rebuild 'dotnet clean; dotnet restore --interactive; dotnet build'
Add-Alias build 'dotnet build'

function rebuilt {
    dotnet msbuild -t:Rebuild -m:$args
}

function built {
    dotnet msbuild -m:$args
}

<#
    .Synopsis
    Cria uma nova feature branch de tarefa no formato story-Id/task/[Tarefa].
    É possível especificar a feature de origem usando o parâmetro -feature ou criar automaticamente com base na branch atual desde que ela respeite o padrão story-id/feature.
    Também é possível criar a feature (a partir da main) usando o switch -createFeature

    .Parameter task
    Id da tarefa

    .Parameter feature
    [Opcional] Id da feature que a tarefa pertence.
    Caso não seja informado será usada a branch atual (desde que ela respeite o padrão de nome de uma feature).
    Caso seja informado, mas a feature não existir será retornado um erro, a não ser que seja usado o switch -createFeature

    .Parameter createFeature
    [Opcional] Define se a branch feature deve ser criada também (com base na branch 'main')
#>

function update-Cred {
    param (
        [Parameter(Mandatory = $true)]
        [string]$gitUserEmail
    )

    git config user.name "Carlos Alberto Franco Maron"
    git config user.email $gitUserEmail
}

function cg-th() {
	Change-Theme
}

<#
    .Synopsis
    Altera para um tema do OMP menos poluído
#>
function Change-Theme(){
	(@(& 'C:/Users/bueno/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init pwsh --config='C:\Users\bueno\AppData\Local\Programs\oh-my-posh\themes\craver.omp.json' --print) -join "`n") | Invoke-Expression
}