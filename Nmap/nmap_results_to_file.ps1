# Define variables
$target = "nmap -sS scanme.nmap.org"
$timestamp = (Get-Date).ToString("yyyyMMdd_HHmmss") 
$outputFile = "C:\some\path\nmap_scan_results_$timestamp.csv"

# Run nmap and capture the output
$nmapResult = Invoke-Expression $target

# Parse and format the results
$parsedResults = $nmapResult -split "`n" | Where-Object { $_ -match "open" } | ForEach-Object {
    $fields = $_ -split "\s+"  
    [PSCustomObject]@{
        Port    = $fields[0]
        State   = $fields[1]
        Service = $fields[2]
    }
}

# Save formatted results to CSV
$parsedResults | Export-Csv -Path $outputFile -NoTypeInformation
