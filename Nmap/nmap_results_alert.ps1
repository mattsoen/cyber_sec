# Define variables
$target = "scanme.nmap.org"
$smtpServer = "smtp.example.com"
$from = "alert@example.com"
$to = "admin@example.com"
$subject = "Nmap Scan Alert"
$body = ""

# Run nmap and capture the output
$nmapResult = nmap $target

# Check if port 80 is open
if ($nmapResult -match "80/tcp\s+open") {
    $body = "Port 80 is open on $target. Scan results: `n$nmapResult"
    
    # Send email alert
    Send-MailMessage -SmtpServer $smtpServer -From $from -To $to -Subject $subject -Body $body
}
