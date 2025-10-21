# Define variables
$subjectName = 'CN=test.adatum.com'
#   TemplatePropCommonName = AdatumWebServer
#   TemplatePropFriendlyName = Adatum Web Server
$template = 'AdatumWebServer'  # Replace with the actual template name published by your CA

# Request the certificate
Get-Certificate `
    -Template $template `
    -SubjectName $subjectName `
    -CertStoreLocation 'Cert:\LocalMachine\My' `
    -Verbose



Add-WebApplicationProxyApplication `
    -BackendServerUrl 'https://rdgw.adatum.com' `
    -ExternalCertificateThumbprint '015CFC6C7DDDAC1E7B1461D17DB4296EFE180F4C' `
    -ExternalUrl 'https://rdgw.adatum.com' `
    -Name 'Adatum RD Gateway' `
    -ExternalPreAuthentication PassThrough