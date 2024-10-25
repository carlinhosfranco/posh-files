function Write-Log {
    param (
        [Parameter(Mandatory = $false)]
        [string]$logString
    )

    Write-Host $logString
    Write-Prompt $logString
}

function Extract-Folders-Detailed {
    param (
        [Parameter(Mandatory = $true)]
        [string]$folder
    )

    $pathExists = Test-Path -Path $folder
    if (!$pathExists) {
        Write-Host 'Folder' $folder 'does not exist.'
        exit 1
    }

    $probalyGitFolders = Get-ChildItem -Path $folder -Directory

    $indexNotGitFolder = 0
    $notGitFolders = [System.Collections.Generic.List[PSObject]]::new()

    $indexGitFolder = 0
    $gitFolders = [System.Collections.Generic.List[PSObject]]::new()

    foreach ($element in $probalyGitFolders) {

        Set-Location -Path $element.ResolvedTarget
        $pathExists = Test-Path -Path '.git'
        if ($pathExists) {
            $gitFolders.Add($element)
            $indexGitFolder++
        }
        else {
            $notGitFolders.Add($element)
            $indexNotGitFolder++
        }
    }

    $resultObject = [PSCustomObject]@{
        TotalGitFolders    = $indexGitFolder
        TotalNotGitFolders = $indexNotGitFolder
        NotGitFoldersList  = $notGitFolders
        GitFoldersList     = $gitFolders
    }

    Return $resultObject
}

function Optimize-Git-Local-Repos {
    param (
        [Parameter(Mandatory = $true)]
        [string]$startFolder
    )

    $pathExists = Test-Path -Path $startFolder
    if (!$pathExists) {
        Write-Host 'Folder' $startFolder 'does not exist.'
        exit 1
    }

    $probalyGitFolders = Get-ChildItem -Path $startFolder -Directory

    #$notGitFolders = @() * 20
    $notGitFolders = [System.Collections.Generic.List[PSObject]]::new()
    $gitFolders = [System.Collections.Generic.List[PSObject]]::new()
    $totalNotGitFolder = 0
    $totalGitFolder = 0

    foreach ($element in $probalyGitFolders) {

        Set-Location -Path $element.ResolvedTarget
        $pathExists = Test-Path -Path '.git'
        if ($pathExists) {
            $gitFolders.Add($element)
            $totalGitFolder++
        }
        else {
            $notGitFolders.Add($element)
            $totalNotGitFolder++
        }
    }

    Write-Host 'Cleanup partially complete'
    Write-Host 'Not Git Folders: ' $notGitFolders.Count
    $newNotGitFolders = [System.Collections.Generic.List[PSObject]]::new()
    foreach ($currentItemName in $notGitFolders) {

        $result = Extract-Folders-Detailed $currentItemName.ResolvedTarget

        if ($result.TotalGitFolders -gt 0) {
            $gitFolders.AddRange($result.GitFoldersList)
        }

        if ($result.TotalNotGitFolders -gt 0) {
            $newNotGitFolders.AddRange($result.NotGitFoldersList)
        }
    }

    foreach ($currentItemName in $gitFolders) {
        Write-Prompt '########################################'
        $consoleLog = 'Fetching ' + $currentItemName.Name
        Write-Prompt $consoleLog
        #Set-Location -Path $element.ResolvedTarget
        git fetch -ap
        git gc --force
        Write-Prompt '########################################'
        Write-Prompt
    }

    $cameBack = 'C:\Users\franc\Documents\PowerShell\Sandbox'
    Set-Location -Path $cameBack

    Write-Host
    Write-Host 'Cleanup complete'
    Write-Host 'Git Folders: ' $gitFolders.Count
    Write-Host 'Not Git Folders: ' $notGitFolders.Count
    Write-Host 'Summary from Not Git Folders: ' $newNotGitFolders.Count

    foreach ($currentItemName in $newNotGitFolders) {
        Write-Host $currentItemName.ResolvedTarget
    }

    #Set-Location $folder
    #git checkout -b "us-$feature/feat" $from
}

#Cleanup-Optimize-Git-Local-Repos "C:\Users"
#Optimize-Git-Local-Repos "D:\CWI\ABCBank\Servicos"
Write-Log "Number Arguments: ${args.Length}"
Write-Log "Arg: ${args}"
Write-Log ""

# $result = Select-String -Pattern $serviceName -InputObject $element

# if ($null -ne $result) {
#     $simpleMath = $result.Line.Split("=")
#     $full = $AbcServicesRootPath + '\' + $simpleMath[1].Replace("}", "")
#     return $full
# }