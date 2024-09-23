# Define file paths
$previousFilePath = "C:\Path\To\PreviousOpenPorts.txt"
$currentFilePath = "C:\Path\To\CurrentOpenPorts.txt"

# Retrieve current open ports
$currentOpenPorts = Get-NetTCPConnection | Select-Object LocalPort, State | Sort-Object LocalPort
$currentOpenPortsFormatted = $currentOpenPorts | Out-String

# Check if previous file exists
if (Test-Path $previousFilePath) {
    # Read previous open ports
    $previousOpenPorts = Get-Content $previousFilePath

    # Compare current and previous open ports
    if ($currentOpenPortsFormatted -ne $previousOpenPorts) {
        # Send alert if values have changed
        $subject = "Open Ports Changed Alert"
        $body = "The open ports have changed. Please check the current open ports."
        Send-MailMessage -To "admin@example.com" -From "alert@example.com" -Subject $subject -Body $body -SmtpServer "smtp.example.com"
    }
}

# Save current open ports to file
$currentOpenPortsFormatted | Out-File $currentFilePath -Encoding UTF8

# Delete the previous file if it exists
if (Test-Path $previousFilePath) {
    Remove-Item $previousFilePath
}

# Rename the current file to previous for next run
Rename-Item -Path $currentFilePath -NewName $previousFilePath
