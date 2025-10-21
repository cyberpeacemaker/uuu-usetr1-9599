# EU-RTR
# Disable the Routing and Remote Access service
Stop-Service -Name RemoteAccess

# LON-CL1
# 1. Remove from domain and restart
Add-Computer -WorkGroupName "WORKGROUP" -UnjoinDomainCredential (Get-Credential) -Force -Restart
(Get-WmiObject Win32_ComputerSystem).PartOfDomain
(Get-WmiObject Win32_ComputerSystem).Workgroup
# When prompted by (Get-Credential), enter your domain admin credentials like: `User name: DOMAIN\YourAdminUsername`

# 1-2. Import a root CA certificate on the client
$caCertPath = "\\172.16.0.10\c$\AdatumRootCA.cer"
# Get-ChildItem -Path Cert:\CurrentUser\
Import-Certificate -FilePath $caCertPath -CertStoreLocation Cert:\LocalMachine\Root

# 2. Move the Client to the Internet





Install-WebApplicationProxy `
    -FederationServiceTrustCredential (Get-Credential) `
    -CertificateThumbprint '015CFC6C7DDDAC1E7B1461D17DB4296EFE180F4C' `
    -FederationServiceName 'adfswap.adatum.com'

Add-WebApplicationProxyApplication -BackendServerUrl 'https://lon-svr1.adatum.com' -ExternalCertificateThumbprint '015CFC6C7DDDAC1E7B1461D17DB4296EFE180F4C' -ExternalUrl 'https://lon-svr1.adatum.com' -Name 'Adatum LOB Web App (LON-SVR1)' -ExternalPreAuthentication PassThrough