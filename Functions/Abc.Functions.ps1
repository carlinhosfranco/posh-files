# Name                      Property       string Name {get;}
# Parent                    Property       System.IO.DirectoryInfo Parent {get;}
# Root                      Property       System.IO.DirectoryInfo Root {get;}
# UnixFileMode              Property       System.IO.UnixFileMode UnixFileMode {get;set;}
# BaseName               

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

function Acd-Help{
    $AbcServicesRootPath = 'C:\Users\carlosam\ABC\Servicos'
    Write-Host 'Serviços no Diretório' $AbcServicesRootPath
    Get-ChildItem -Path $AbcServicesRootPath -Directory | Select-Object Name    
}


function Take-Me-To {
    param (
        [Parameter(Mandatory = $false)]
        [string]$folder        
    )

    $path = Find-AbcService-Folder $folder    

    if (!$path) {
        Acd-Help
        Return
    }

    Set-Location $path    
}

<#
    .Synopsis
    Lista os serviços de Api do ABC na Pasta 'C:\Users\carlosam\ABC\Servicos'

    .Parameter serviceName
    Nome do Serviço    
#>
function Find-AbcService-Folder {
    param (
        [Parameter(Mandatory = $true)]
        [string]$serviceName
    )
    
    $AbcServicesRootPath = 'C:\Users\carlosam\ABC\Servicos'
    $abcServices = Get-ChildItem -Path $AbcServicesRootPath -Directory | Select-Object Name    
    
    foreach ($element in $abcServices) {
        $result = Select-String -Pattern $serviceName -InputObject $element
    
        if ($null -ne $result) {    
            $simpleMath = $result.Line.Split("=")                       
            $full = $AbcServicesRootPath + '\' + $simpleMath[1].Replace("}", "")
            return $full
        }
    }

    return $AbcServicesRootPath
}