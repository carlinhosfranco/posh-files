#$previousOutputEncoding = [Console]::OutputEncoding
# [Console]::OutputEncoding = [Text.Encoding]::UTF8

# try {
#     oh-my-posh init pwsh --config "$root/Themes/my-themes/carlos.omp.json" | Invoke-Expression
# } finally {
#     [Console]::OutputEncoding = $previousOutputEncoding
# }

# if (-Not (Get-Module -ListAvailable -Name posh-git)) {
#     Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
# }

# if (-Not (Get-Module -ListAvailable -Name posh-cli)) {
#     Install-Module posh-cli -Scope CurrentUser
#     Install-TabCompletion

#     Import-Module posh-dotnet
#     Import-Module DockerCompletion
#     Import-Module PSKubectlCompletion
#     Import-Module posh-cargo
# }

# Import-Module posh-cargo
# Import-Module posh-dotnet
# Import-Module DockerCompletion
# Import-Module PSKubectlCompletion

# $previousOutputEncoding = [Console]::OutputEncoding
# [Console]::OutputEncoding = [Text.Encoding]::UTF8

# try {
#     oh-my-posh init pwsh --config "$root/Themes/my-themes/carlos.omp.json" | Invoke-Expression
# } finally {
#     [Console]::OutputEncoding = $previousOutputEncoding
# }