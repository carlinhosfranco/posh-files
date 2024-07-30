# function Find-AbcService-Folder {
#     param (
#         [Parameter(Mandatory = $true)]
#         [string]$serviceName
#     )
    
#     $AbcServicesRootPath = 'C:\Users\carlosam\ABC\Servicos'
#     $abcServices = Get-ChildItem -Path $AbcServicesRootPath -Directory | Select-Object Name

#     foreach ($element in $abcServices) {
#         $result = Select-String -InputObject $element -Pattern $serviceName 
    
#         if ($null -ne $result) {       
#             #$t = $result | Get-Member -View All -Type Properties            

#             #$full = $AbcServicesRootPath + '\' + $result.Line            
#             #Write-Host $result.Line
#             $t1 = $result.Line.Split("=")    #| Select-Object -ExpandProperty Line |  
#             Write-Host $t1[1].Replace("}", "")
#             #$t2 = $result | Out-String -Stream | Select-String                                    
#             $retorno = $t1[1].Replace()
#         }
#     }

#     $retorno
# }
#$path = 
# function Find-AbcService-Folder {
#     param (
#         [Parameter(Mandatory = $true)]
#         [string]$serviceName
#     )
    
#     $AbcServicesRootPath = 'C:\Users\carlosam\ABC\Servicos'
#     $abcServices = Get-ChildItem -Path $AbcServicesRootPath -Directory | Select-Object Name    
    
#     foreach ($element in $abcServices) {
#         $result = Select-String -Pattern $serviceName -InputObject $element
    
#         if ($null -ne $result) {    
#             $simpleMath = $result.Line.Split("=")                       
#             $full = $AbcServicesRootPath + '\' + $simpleMath[1].Replace("}", "")
#             return $full
#         }
#     }

#     return $AbcServicesRootPath
# }
# Find-AbcService-Folder 'intencao.api'
#$path | Get-Member -Type Properties 


#$path = Find-AbcService-Folder 'intencao.api'
#Write-Host $path

# function Acd-Help{
#     $AbcServicesRootPath = 'C:\Users\carlosam\ABC\Servicos'
#     Write-Host 'Serviços no Diretório' $AbcServicesRootPath
#     Get-ChildItem -Path $AbcServicesRootPath -Directory | Select-Object Name    
# }

function cure {
    #https://stackoverflow.com/questions/4950725/how-can-i-see-which-git-branches-are-tracking-which-remote-upstream-branch
    # git config --global alias.track '!f() { ([ $# -eq 2 ] && ( echo "Setting tracking for branch " $1 " -> " $2;git branch --set-upstream $1 $2; ) || ( git for-each-ref --format="local: %(refname:short) <--sync--> remote: %(upstream:short)" refs/heads && echo --Remotes && git remote -v)); }; f'
        $currentBranch = git branch --format='%(upstream:short)'
        Write-Host git reset --hard $currentBranch.trim()
    }

    cure