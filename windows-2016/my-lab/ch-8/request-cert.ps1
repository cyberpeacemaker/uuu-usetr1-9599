# TODO: Subject Name Type Optimization
$subjectNameType = 'CN'
$subjectNameSuffix = 'test.adatum.com'
$subjectName = "$subjectNameType=$subjectNameSuffix"
$template = 'AdatumWebServer' # Can be found via get-certTemplate.ps1

# Request the certificate
Get-Certificate `
    -Template $template `
    -SubjectName $subjectName `
    -CertStoreLocation 'Cert:\LocalMachine\My' `
    -Verbose
    
Write-Host "Certificate request for '$subjectName' using template '$template' has been submitted."