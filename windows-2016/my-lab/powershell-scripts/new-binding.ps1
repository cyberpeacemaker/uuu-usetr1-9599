# Define variables
$siteName = "Default Web Site"
$ip = "*"
$port = 443
$targetCertPath = "Cert:\LocalMachine\My"
$targetCertName = "CN=131.107.0.10"

# Create the HTTPS binding
New-WebBinding -Name $siteName -IP $ip -Port $port -Protocol https 

# Assign the certificate to the binding
$bindingPath = "IIS:\SslBindings\0.0.0.0!443!"

# TODO: Optimazation?
$certThumbprint = (Get-ChildItem -Path $targetCertPath | Where-Object {
    $_.Subject -eq $targetCertName
} | Select-Object -First 1).Thumbprint
Get-Item "Cert:\LocalMachine\My\$certThumbprint" | New-Item $bindingPath

# TODO: Hostname mandatory?
# $hostname = "localhost"
# New-WebBinding -Name $siteName -IP $ip -Port $port -Protocol https -HostHeader $hostname
# $bindingPath = "IIS:\SslBindings\0.0.0.0!443!$hostname"