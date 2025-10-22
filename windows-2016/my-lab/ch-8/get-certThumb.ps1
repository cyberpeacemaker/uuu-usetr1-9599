# Get a list of certs from LocalMachine\My
$targetCertName = "CN=131.107.0.10"
$targetPath = "Cert:\LocalMachine\My"
# Get-ChildItem -Path $targetPath | Where-Object {
#     $_.Subject -like "*${targetCertName}*" -or $_.FriendlyName -like "*${targetCertName}*"
# } | Select-Object Subject, FriendlyName, Thumbprint
Get-ChildItem -Path $targetPath | Where-Object {
    $_.Subject -eq ${targetCertName}
} | Select-Object Subject, FriendlyName, Thumbprint


