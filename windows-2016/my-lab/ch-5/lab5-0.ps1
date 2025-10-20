# Install IPAM Services
Install-WindowsFeature IPAM -IncludeManagementTools

#Begin script
Write-Output "Starting Script"
#Install and configure DHCP as in Mod 1
Add-WindowsFeature DHCP
Add-WindowsFeature RSAT-DHCP
Add-DhcpServerInDC

#Install and configure DNS as in Mod 2
Add-WindowsFeature DNS
Add-WindowsFeature RSAT-DNS-Server
Add-DnsServerPrimaryZone -Name "contoso.com" -ZoneFile "contoso.com"
Add-DnsServerResourceRecordA -Name "www" -ZoneName "contoso.com" -IPv4Address 172.16.0.11
Add-DnsServerResourceRecordA -Name "mail" -ZoneName "contoso.com" -IPv4Address 172.16.0.12
Write-Output "Script Complete"