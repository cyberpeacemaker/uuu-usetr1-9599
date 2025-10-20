# TODO: goodStatus determination based on different method.
# Define VM groups
$initialVMs = @("20741B-LON-DC1")
$midVMs = @("20741B-NA-RTR", "20741B-EU-RTR")
$finalVMs = @(
    "20741B-LON-CL1", "20741B-LON-CL2", "20741B-INET1",
    "20741B-SYD-SVR1", "20741B-TOR-SVR1", 
    "20741B-LON-SVR1", "20741B-LON-SVR2"
)

function Log {
    param(
        [Parameter(Mandatory=$true)][string]$Message,
        [ConsoleColor]$Color = 'White'
    )
    $ts = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Write-Host "[$ts] $Message" -ForegroundColor $Color
}

Log "Beginning reset process. Restoring all VMs to checkpoint 'Starting Image'..." Cyan
Log "Restore will run non-interactively (-Confirm:$false)." Yellow

# Restore all VMs to a known state
# TODO: Exclude no checkpoint VMs if any
# Restore each VM with progress and logging
function Restore-VMsToCheckpoint {
    param(
        [Parameter(Mandatory=$true)][object[]]$VMs,
        [string]$CheckpointName = 'Starting Image'
    )

    $total = $VMs.Count
    if ($total -eq 0) { return $true }

    $i = 0
    $failed = @()

    foreach ($vm in $VMs) {
        $i++
        # Accept either VM objects or VM name strings
        if ($vm -is [string]) {
            $name = $vm
        } elseif ($vm -is [PSObject] -and $vm.PSObject.Properties['Name']) {
            $name = $vm.Name
        } else {
            $name = $vm.ToString()
        }

        $percent = if ($total -gt 0) { [int](($i / $total) * 100) } else { 100 }
        Write-Progress -Activity "Restoring VMs" -Status "Restoring $name ($i/$total)" -PercentComplete $percent

        Log "Restoring VM '$name' to checkpoint '$CheckpointName'..." Cyan
        try {
            Restore-VMCheckpoint -VMName $name -Name $CheckpointName -Confirm:$false -ErrorAction Stop
            Log "Restored '$name'." Green
        } catch {
            Log "Failed to restore '$name': $($_.Exception.Message)" Red
            $failed += $name
        }
    }

    if ($failed.Count -gt 0) {
        Write-Warning "Restore failed for: $($failed -join ', ')"
        return $false
    }

    return $true
}

# Invoke the new function for all VMs
$restoreSuccess = Restore-VMsToCheckpoint -VMs $vms -CheckpointName "Starting Image"
Write-Progress -Activity "Restoring VMs" -Completed

# Function to wait for heartbeat
function Wait-ForHeartbeat {
    param (
        [string[]]$VMNames,
        [int]$TimeoutSeconds = 120
    )
    
    $startTime = Get-Date
    $goodStatus = '狀況良好'  # Use localized term or switch to English if possible
    $heartbeatServiceName = '活動訊號'

    do {
        Start-Sleep -Seconds 2
        Write-Output "Waiting for VM(s): $($VMNames -join ', ')..."

        $statuses = @{}
        foreach ($vm in $VMNames) {
            $heartbeat = (Get-VMIntegrationService -VMName $vm | Where-Object Name -like $heartbeatServiceName).PrimaryStatusDescription
            $statuses[$vm] = $heartbeat
        }
        $allGood = $statuses.Values -notcontains ($statuses.Values | Where-Object { $_ -ne $goodStatus })
    } while (-not $allGood -and ((Get-Date) - $startTime).TotalSeconds -lt $TimeoutSeconds)
    # Determine final result after polling loop
    if ($allGood) {
        Write-Host "Success: All VM(s) are reporting healthy heartbeat: $($VMNames -join ', ')" -ForegroundColor Green        
        return $true
    }

    # Not all good -> timed out. Print per-VM status for troubleshooting and return $false.
    Write-Warning "Timeout reached while waiting for VM(s): $($VMNames -join ', ') (waited $TimeoutSeconds seconds)"
    foreach ($kvp in $statuses.GetEnumerator()) {
        $vm = $kvp.Key
        $status = $kvp.Value
        if (-not $status) { $status = '<no heartbeat service found>' }
        Write-Host "`t$vm : $status"
    }
    return $false
}

# Start and wait for initial VMs
$initialVMs | ForEach-Object { Start-VM -VMName $_ -Confirm:$false }
if (-not (Wait-ForHeartbeat -VMNames $VMNames)) {
    Write-Error "Aborting script due to heartbeat failure for: $($VMNames -join ', ')"
    exit 1
}

# Start and wait for mid VMs
$midVMs | ForEach-Object { Start-VM -VMName $_ -Confirm:$false }
if (-not (Wait-ForHeartbeat -VMNames $midVMs)) {
    Write-Error "Aborting script due to heartbeat failure for: $($VMNames -join ', ')"
    exit 1
}

# Start the remaining VMs
$finalVMs | ForEach-Object { Start-VM -VMName $_ -Confirm:$false }