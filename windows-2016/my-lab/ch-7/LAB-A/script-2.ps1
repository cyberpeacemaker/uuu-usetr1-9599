# Verify the network configuration on EU-RTR

$targetAdapters = @("London_Network", "Internet")

# Stop the Routing and Remote Access service
Stop-Service -Name RemoteAccess -Force
Get-Service -Name RemoteAccess

# List all network adapters and allow user to select one to restart
$adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -or $_.Status -eq 'Disabled' }

do {
    Write-Host "`nAvailable Network Adapters:`n"
    for ($i = 0; $i -lt $adapters.Count; $i++) {
        Write-Host "$($i + 1). $($adapters[$i].Name) - Status: $($adapters[$i].Status)"
    }
    Write-Host "0. Exit"
    $selection = Read-Host "`nEnter the number of the adapter you want to restart (or 0 to exit)"

    if ($selection -eq '0') {
        Write-Host "Exiting."
        break
    }
    if ($selection -match '^\d+$' -and [int]$selection -ge 1 -and [int]$selection -le $adapters.Count) {
        $index = [int]$selection - 1
        $adapterToRestart = $adapters[$index]
        $adapterName = $adapterToRestart.Name

        Write-Host "`nRestarting adapter: $adapterName..."
        Disable-NetAdapter -Name $adapterName -Confirm:$false

        Write-Host "Waiting for adapter to be disabled..."
        do {
            Start-Sleep -Seconds 1
            $currentStatus = (Get-NetAdapter -Name $adapterName).Status
        } while ($currentStatus -ne 'Disabled')

        Write-Host "Adapter is now disabled."

        Enable-NetAdapter -Name $adapterName -Confirm:$false
        Write-Host "Adapter restarted successfully."
    } else {
        Write-Host "Invalid selection. Please try again."
    }

} while ($true)


# Check the status of the target adapters
foreach ($adapterName in $targetAdapters) {
    $adapter = Get-NetAdapter -Name $adapterName -ErrorAction SilentlyContinue
    if ($adapter) {
        Write-Host "Adapter: $adapterName - Status: $($adapter.Status)"
        $ipConfig = Get-NetIPConfiguration -InterfaceAlias $adapterName
        Write-Host "  IPv4 Address: $($ipConfig.IPv4Address.IPAddress)"
        Write-Host "  IPv6 Address: $($ipConfig.IPv6Address.IPAddress)"
        Write-Host "  Default Gateway: $($ipConfig.IPv4DefaultGateway.NextHop)"
    } else {
        Write-Host "Adapter: $adapterName not found."
    }
}
# London_Network adapter should have:
#   IPv4 Address: 172.16.0.1
# Internet adapter should have:
#   IPv4 Address: 131.107.0.10