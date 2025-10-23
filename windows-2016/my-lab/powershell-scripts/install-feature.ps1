
# Get-WindowsFeature is no longer shipped with Windows or Windows Server and must be installed separately 
# by installing the Windows Server Remote Administration Tools.
# Resource links:
# https://learn.microsoft.com/en-us/troubleshoot/windows-server/system-management-components/remote-server-administration-tools
# https://learn.microsoft.com/en-us/windows-server/administration/install-remote-server-administration-tools?tabs=windows-powershell%2Cdesktop-experience&pivots=windows-server-2025
# $serverManager = Get-Module -ListAvailable -Name ServerManager
# if (-not $serverManager) {
#     Write-Host 'ServerManager module not found. Install Windows Server Remote Administration Tools to enable Get-WindowsFeature.' -ForegroundColor Yellow
# } else {
#     Import-Module ServerManager
# }

# TODO:
# Get-WindowsFeature -Name RSAT*
# Install-WindowsFeature -Name RSAT-DFS-Mgmt-Con -IncludeManagementTools
# Uninstall-WindowsFeature -name RSAT-DFS-Mgmt-Con

Get-WindowsFeature -Name "*FS-DFS*"
Install-WindowsFeature FS-DFS-Namespace, FS-DFS-Replication -IncludeManagementTools
write-Host "DFS Namespace and Replication features installed."
Get-WindowsFeature -Name "*FS-DFS*"

