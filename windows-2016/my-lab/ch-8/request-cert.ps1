param(
    [Parameter(Position = 0)]
    [ValidateNotNullOrEmpty()]
    [string]$subjectNameType = 'CN',

    [Parameter(Position = 1)]
    [ValidateNotNullOrEmpty()]
    [string]$subjectNameSuffix = 'test.adatum.com',

    # Can be found via get-certTemplate.ps1
    [Parameter(Position = 2)]
    [ValidateNotNullOrEmpty()]
    [string]$template = 'AdatumWebServer',

    # Can by found via check-cert.ps1
    [Parameter(Position = 3)]
    [ValidateNotNullOrEmpty()]
    [string]$targetStore = 'Cert:\LocalMachine\My'
)

$subjectName = "$subjectNameType=$subjectNameSuffix"

# Request the certificate
Get-Certificate `
    -Template $template `
    -SubjectName $subjectName `
    -CertStoreLocation $targetStore `
    -Verbose

Write-Host "Certificate request for '$subjectName' using template '$template' has been submitted."