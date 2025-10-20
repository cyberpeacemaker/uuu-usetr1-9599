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
                   

    Start-Sleep -Seconds $interval
}