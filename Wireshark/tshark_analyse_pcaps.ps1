# Define the directory containing PCAP files
$PCAPDir = "C:\path\to\pcap\files"
$OutputFile = "C:\path\to\output\security_analysis_summary.txt"

# Clear the output file
Clear-Content $OutputFile -ErrorAction SilentlyContinue

# Get all PCAP files in the directory
$pcapFiles = Get-ChildItem -Path $PCAPDir -Filter *.pcap

# Loop through each PCAP file
foreach ($file in $pcapFiles) {
    Write-Host "Analyzing $file"

    # Check for unauthorized SSH access attempts
    $sshAttempts = tshark -r $file.FullName -Y "ssh.auth.failed" | Measure-Object | Select-Object -ExpandProperty Count
    Add-Content $OutputFile "Unauthorized SSH access attempts: $sshAttempts"

    # Check for unusual DNS queries
    $dnsQueries = tshark -r $file.FullName -T fields -e dns.qry.name | Group-Object | Where-Object { $_.Count -gt 10 }
    Add-Content $OutputFile "Unusual DNS queries (more than 10 occurrences):"
    foreach ($query in $dnsQueries) {
        Add-Content $OutputFile "$($query.Count) - $($query.Name)"
    }

    # Check for SQL injection
    $suspiciousHttpRequests = tshark -r $file.FullName -Y "http.request" -T fields -e http.request.uri | Where-Object { $_ -match "(union.*select|;|--|%27|%3D|%22)" }
    Add-Content $OutputFile "Potential SQL injection attempts in HTTP requests:"
    foreach ($request in $suspiciousHttpRequests) {
        Add-Content $OutputFile $request
    }

    Add-Content $OutputFile "----------------------------------------"
}

Write-Host "Security analysis complete. Results saved to $OutputFile."
