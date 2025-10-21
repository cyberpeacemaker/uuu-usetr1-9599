# Verifying Readiness for a DirectAccess Deployment

param (
    [string]$targetInterface = "London_Network"
)
$targetPath = "C:\Logs\network_info.txt"

# Collect network info
$ipInfo = Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias $targetInterface | Select-Object IPAddress, PrefixLength
$gatewayInfo = Get-NetRoute -DestinationPrefix "0.0.0.0/0" -InterfaceAlias $targetInterface | Select-Object -First 1 -ExpandProperty NextHop
$dnsInfo = (Get-DnsClientServerAddress -InterfaceAlias $targetInterface -AddressFamily IPv4).ServerAddresses

# Ensure folder exists
$folder = Split-Path $targetPath
if (-not (Test-Path $folder)) {
    New-Item -ItemType Directory -Path $folder -Force
}
# Function to convert PrefixLength to SubnetMask
function Convert-CIDRToSubnetMask {
    param ([int]$prefixLength)
    $mask = [math]::Pow(2, 32) - [math]::Pow(2, 32 - $prefixLength)
    $bytes = [BitConverter]::GetBytes([UInt32]$mask)
    [IPAddress] ($bytes[0..3] -join '.')
}
# Output to file
[PSCustomObject]@{
    Host           = $env:COMPUTERNAME
    InterfaceAlias = $targetInterface
    IPAddress      = $ipInfo.IPAddress
    # SubnetMask   = ($ipInfo.PrefixLength | ForEach-Object {[IPAddress]((0xffffffff << (32 - $_)) -band 0xffffffff)})
    # SubnetMask   = Convert-CIDRToSubnetMask -prefixLength $ipInfo.PrefixLength
    # TODO: Fix SubnetMask conversion
    CICD           = $ipInfo.PrefixLength
    DefaultGateway = $gatewayInfo
    DNSServers     = $dnsInfo -join ", "
} | Out-File -FilePath $targetPath -Encoding UTF8

Write-Host "Network configuration for interface '$targetInterface' has been saved to '$targetPath'."

