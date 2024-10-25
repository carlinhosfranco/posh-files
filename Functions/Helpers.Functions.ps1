#Get-ChildItem Env:
<#
    .Synopsis
    Cria uma nova feature branch no formato story-[IdFeature]/feature

    .Parameter feature
    Id da feature

    .Parameter from
    Define a branch que será usada como origem para criar a nova branch.
    Se não for informada, toma 'main' como padrão
#>
function Take-Me-To {
    param (
        [Parameter(Mandatory = $false)]
        [string]$folder
    )
    if (!$folder) {
        Set-Location $HOMEPATH
        Return
    }

    Set-Location $folder
    #git checkout -b "us-$feature/feat" $from
}

#Get-ChildItem Env:
<#
    .Synopsis
    Cria uma nova feature branch no formato story-[IdFeature]/feature

    .Parameter feature
    Id da feature

    .Parameter from
    Define a branch que será usada como origem para criar a nova branch.
    Se não for informada, toma 'main' como padrão
#>
function Cleanup-Optimize-Git-Local-Repos {
    param (
        [Parameter(Mandatory = $false)]
        [string]$startFolder
    )
    if (!$startFolder) {
        Set-Location $HOMEPATH
        Return
    }

    Set-Location $folder
    #git checkout -b "us-$feature/feat" $from
}