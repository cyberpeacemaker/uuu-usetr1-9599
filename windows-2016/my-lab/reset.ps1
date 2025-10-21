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

# Restore each VM with progress and logging
$vms = Get-VM
$total = $vms.Count
$i = 0

foreach ($vm in $vms) {
    $i++
    $name = $vm.Name
    $percent = [int](($i / $total) * 100)
    Write-Progress -Activity "Restoring VMs" -Status "Restoring $name ($i/$total)" -PercentComplete $percent

    Log "Restoring VM '$name' to checkpoint 'Starting Image'..." Cyan
    try {
        # Use -VMName per-VM to allow individual error handling
        Restore-VMCheckpoint -VMName $name -Name "Starting Image" -Confirm:$false -ErrorAction Stop
        Log "Restored '$name'." Green
    } catch {
        Log "Failed to restore '$name': $($_.Exception.Message)" Red
    }
}

Write-Progress -Activity "Restoring VMs" -Completed

# Start VMs in the required order with logging and error handling
Log "Starting VMs..." Cyan

try {
    Log "Starting 20741B-LON-DC1..." Cyan
    Start-VM -VMName '20741B-LON-DC1' -Confirm:$false -ErrorAction Stop
    Log "Started 20741B-LON-DC1." Green
} catch {
    Log "Failed to start 20741B-LON-DC1: $($_.Exception.Message)" Red
}

# Pause 60 seconds in 2-second intervals with progress and logging
$totalSeconds = 60
$interval = 2
$iterations = [int]($totalSeconds / $interval)

Log "Pausing $totalSeconds seconds in $interval-second intervals..." Yellow

for ($i = 1; $i -le $iterations; $i++) {
    $elapsed = $i * $interval
    if ($elapsed -gt $totalSeconds) { $elapsed = $totalSeconds }
    $remaining = $totalSeconds - $elapsed
    $percent = [int](($elapsed / $totalSeconds) * 100)

    Write-Progress -Activity "Waiting between VM starts" `
                   -Status "Elapsed: ${elapsed}s / ${totalSeconds}s — Remaining: ${remaining}s" `
                   -PercentComplete $percent

    Start-Sleep -Seconds $interval
}

Write-Progress -Activity "Waiting between VM starts" -Completed
Log "Pause complete ($totalSeconds seconds)." Green
foreach ($name in @('20741B-NA-RTR','20741B-EU-RTR')) {
    try {
        Log "Starting $name..." Cyan
        Start-VM -VMName $name -Confirm:$false -ErrorAction Stop
        Log "Started $name." Green
    } catch {
        Log "Failed to start ${name}: $($_.Exception.Message)" Red
    }
}

# Pause 30 seconds in 2-second intervals with progress and logging
$totalSeconds = 30
$interval = 2
$iterations = [int]($totalSeconds / $interval)

Log "Pausing $totalSeconds seconds in $interval-second intervals..." Yellow

for ($j = 1; $j -le $iterations; $j++) {
    $elapsed = $j * $interval
    if ($elapsed -gt $totalSeconds) { $elapsed = $totalSeconds }
    $remaining = $totalSeconds - $elapsed
    $percent = [int](($elapsed / $totalSeconds) * 100)

    Write-Progress -Activity "Waiting before next batch" `
                   -Status "Elapsed: ${elapsed}s / ${totalSeconds}s — Remaining: ${remaining}s" `
                   -PercentComplete $percent

    Start-Sleep -Seconds $interval
}

Write-Progress -Activity "Waiting before next batch" -Completed
Log "Pause complete ($totalSeconds seconds)." Green

foreach ($name in @(
    '20741B-LON-CL1',
    '20741B-LON-CL2',
    '20741B-INET1',
    '20741B-SYD-SVR1',
    '20741B-TOR-SVR1',
    '20741B-LON-SVR1',
    '20741B-LON-SVR2'
)) {
    try {
        Log "Starting $name..." Cyan
        Start-VM -VMName $name -Confirm:$false -ErrorAction Stop
        Log "Started $name." Green
    } catch {
        Log "Failed to start ${name}: $($_.Exception.Message)" Red
    }
}

Log "All start commands issued. Verify VM states if needed." Yellow
Log "Reset process complete." Cyan