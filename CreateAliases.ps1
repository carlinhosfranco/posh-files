Add-Alias co 'git checkout'
Add-Alias coback 'git checkout -'
Add-Alias gst 'git status'
Add-Alias grb 'git rebase -i'
Add-Alias gglg 'git log --graph --oneline --decorate --all -30'
Add-Alias glgl 'git log --oneline -20'
Add-Alias fetch 'git fetch -ap'
Add-Alias push 'git push'
Add-Alias pull 'git pull'
Add-Alias pushsync 'git push --set-upstream origin HEAD'
Add-Alias fush 'git push --force-with-lease'
Add-Alias gredev 'git reset --hard origin/develop'
#Add-Alias rehead 'git reset --hard origin HEAD'
#git log --graph --oneline --decorate --all

function gllog {
    git log --oneline -$args
}

function gglog {
    git log --graph --oneline --decorate --all -$args
}

function gco {
    $branch = git branch -l | fzf --ansi --preview="git log --color=always {1}" --preview-window=up:70%

    if ($branch) {
        git checkout $branch.trim()
    }
}

#dotnet alias
Add-Alias rebuild 'dotnet clean; dotnet restore --interactive; dotnet build'
Add-Alias build 'dotnet build'

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
# function Change-Theme() {
# 	(@(& 'C:/Users/franc/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init pwsh --config='PATH_TO_THE_THEME' --print) -join "`n") | Invoke-Expression
# }

#winget list --upgrade-available

function gahelp {

    $stringHelp = "
    co 'git checkout'
    gst 'git status'
    grb 'git rebase -i'
    glg 'git log --oneline -10'
    fetch 'git fetch'
    push 'git push'
    pull 'git pull'
    pushsync 'git push --set-upstream origin HEAD'
    fush 'git push --force-with-lease'
    gredev 'git reset --hard origin/develop'
    gglg 'git log --graph --oneline --decorate --all -30'
    glgl 'git log --oneline -20'
    "

    Write-Host $stringHelp
}