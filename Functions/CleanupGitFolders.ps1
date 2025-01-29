<#
Function to optimize git folders

TODO:
    - Add arguments to read from command line and set parameters
#>

function Write-Log {
    param (
        [Parameter(Mandatory = $false)]
        [string]$logString
    )

    Write-Host $logString
    Write-Prompt $logString
}

function Git-Commands {
    param ()

    git fetch -ap
    git gc --force
}

function Extract-Folders-Detailed {
    param (
        [Parameter(Mandatory = $true)]
        [string]$folder
    )

    $pathExists = Test-Path -Path $folder
    if (!$pathExists) {
        Write-Log "Folder ${folder} does not exist."
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
        Write-Log "Folder ${startFolder} does not exist."
        exit 1
    }

    $probalyGitFolders = Get-ChildItem -Path $startFolder -Directory

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

    Write-Log ""
    Write-Log "Cleanup partially complete"
    $log = "Not Git Folders:" + $notGitFolders.Count
    Write-Log "${log}"
    Write-Log ""

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
        Write-Log '########################################'
        $consoleLog = 'Fetching and cleaning ' + $currentItemName.Name
        Write-Log $consoleLog
        Set-Location -Path $currentItemName.ResolvedTarget
        Git-Commands
        Write-Log '########################################'
        Write-Log ""
    }

    Set-Location

    Write-Log "Cleanup complete"
    Write-Log ""
    $log = "Git Folders: " + $gitFolders.Count
    Write-Log "${log}"

    $log = "Not Git Folders: " + $notGitFolders.Count
    Write-Log "${log}"
    $log = "Summary from Not Git Folders: " + $newNotGitFolders.Count
    Write-Log "${log}"
    Write-Log ""

    foreach ($currentItemName in $newNotGitFolders) {
        Write-Log $currentItemName.ResolvedTarget
    }
}


Write-Log "Init Cleanup "
Write-Log "${args}"
Write-Log ""
Optimize-Git-Local-Repos "${args}"
# Write-Host "Number Arguments: " $args.Length
# Write-Host "Arg: $args";
#Optimize-Git-Local-Repos ""
Optimize-Git-Local-Repos "FOLDER-NAME"