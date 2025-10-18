while ($true) {
    Clear-Host
    Write-Host "Getting VM at index 4 at $(Get-Date -Format 'HH:mm:ss')"
    
    try {
        $vm = Get-VM | Select-Object -Index 4
        if ($vm) {
            $vm | Format-Table
        } else {
            Write-Warning "No VM found at index 4."
        }
    } catch {
        Write-Error "Error retrieving VM: $_"
    }

    Start-Sleep -Seconds 2
}
