# -Path: \\domain.com\NamespaceName
# -TargetPath: \\Server\NamespaceShare$ (host server)

New-Item -Path "C:\CorpData" -ItemType Directory
New-SmbShare -Name "CorpData" -Path "C:\CorpData" -FullAccess "Domain Admins"
Test-Path "\\LON-SVR1\CorpData"


New-DfsnRoot `
  -Path "\\Adatum.com\CorpData" `
  -TargetPath "\\LON-SVR1\CorpData" `
  -Type DomainV2 `
  -EnableSiteCosting $true  

New-DfsnFolder `
  -Path "\\adatum.com\CorpData\HR" `
  -TargetPath "\\adatum.com\CorpData\real-folder"
New-DfsnFolder `
  -Path "\\adatum.com\CorpData\IT" `
  -TargetPath "\\FS2\ITShare"
# (Optional) Step 3: Add More Namespace Servers (for Redundancy)
# Add-DfsnRootTarget `
#   -Path "\\adatum.com\CorpData" `
#   -TargetPath "\\DFS2\CorpData"
# Bonus: Add Multiple Targets to a Folder (for redundancy)
# Add-DfsnFolderTarget `
#   -Path "\\adatum.com\CorpData\HR" `
#   -TargetPath "\\FS3\HRShare_Backup"


# Add Nameespace to Display
Get-DfsnRoot
Get-DfsnFolder -Path "\\adatum.com\CorpData\HR"
Get-DfsnRootTarget -Path "\\adatum.com\CorpData"


