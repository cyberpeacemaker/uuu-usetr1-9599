$targetUnitName = "Special Accounts"
$targetClientGroupName = "DirectAccessClients"
$computerName = "LON-CL1"
$domainDN = (Get-ADDomain).DistinguishedName
$ouPath = "OU=$targetUnitName," + $domainDN
$computer = Get-ADComputer -Identity $computerName

# TODO: OPtimize
New-ADOrganizationalUnit -Name $targetUnitName -Path $domainDN
New-ADGroup -Name $targetClientGroupName -GroupScope Global -GroupCategory Security -Path $ouPath

# $group = Get-ADGroup -Identity $targetClientGroupName -SearchBase $ouPath
# Add-ADGroupMember -Identity $group -Members ("CN=$computerName,OU=Computers," + $domainDN)
$group = Get-ADGroup -Filter "Name -eq '$targetClientGroupName'" -SearchBase $ouPath
Add-ADGroupMember -Identity $group -Members $computer