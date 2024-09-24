# Documentation for PCAP Security Analysis Script

## Overview
This PowerShell script analyses PCAP files in a specified directory for security threats. It focuses on detecting unauthorised SSH access attempts, unusual DNS queries, and potential SQL injection attempts in HTTP requests. The results are summarised and saved to an output file.

## Script Details

### Define the Directory Containing PCAP Files
- **Purpose**: To specify the directory where PCAP files are located and define the output file path for analysis results.
- **Variables**:
  - **`$PCAPDir`**: Path to the directory containing the PCAP files (`"C:\path\to\pcap\files"`).
  - **`$OutputFile`**: Path to the output summary file (`"C:\path\to\output\security_analysis_summary.txt"`).

### Clear the Output File
- **Purpose**: To ensure that the output file is empty before starting the analysis.
- **Actions**:
  - Clears the content of the output file, suppressing errors if the file does not exist:
    ```powershell
    Clear-Content $OutputFile -ErrorAction SilentlyContinue
    ```

### Get All PCAP Files in the Directory
- **Purpose**: To retrieve a list of all PCAP files for analysis.
- **Actions**:
  - Uses `Get-ChildItem` to find files with a `.pcap` extension:
    ```powershell
    $pcapFiles = Get-ChildItem -Path $PCAPDir -Filter *.pcap
    ```

### Loop Through Each PCAP File
- **Purpose**: To analyse each PCAP file for specific security threats.
- **Actions**:
  - For each file, it performs the following checks:

  #### 1. Unauthorised SSH Access Attempts
  - **Command**: Uses `tshark` to count failed SSH authentication attempts:
    ```powershell
    $sshAttempts = tshark -r $file.FullName -Y "ssh.auth.failed" | Measure-Object | Select-Object -ExpandProperty Count
    Add-Content $OutputFile "Unauthorised SSH access attempts: $sshAttempts"
    ```

  #### 2. Unusual DNS Queries
  - **Command**: Analyses DNS queries to identify those with more than a given number of occurrences (default is 10):
    ```powershell
    $dnsQueries = tshark -r $file.FullName -T fields -e dns.qry.name | Group-Object | Where-Object { $_.Count -gt 10 }
    Add-Content $OutputFile "Unusual DNS queries (more than 10 occurrences):"
    foreach ($query in $dnsQueries) {
        Add-Content $OutputFile "$($query.Count) - $($query.Name)"
    }
    ```

  #### 3. Potential SQL Injection Attempts
  - **Command**: Checks HTTP requests for patterns indicative of SQL injection:
    ```powershell
    $suspiciousHttpRequests = tshark -r $file.FullName -Y "http.request" -T fields -e http.request.uri | Where-Object { $_ -match "(union.*select|;|--|%27|%3D|%22)" }
    Add-Content $OutputFile "Potential SQL injection attempts in HTTP requests:"
    foreach ($request in $suspiciousHttpRequests) {
        Add-Content $OutputFile $request
    }
    ```

  - Adds a separator for clarity:
    ```powershell
    Add-Content $OutputFile "----------------------------------------"
    ```

### Completion Message
- **Purpose**: To inform the user that the analysis is complete.
- **Action**:
  - Outputs a completion message to the console:
    ```powershell
    Write-Host "Security analysis complete. Results saved to $OutputFile."
    ```

## How to Run
1. **Prerequisites**:
   - Ensure that `tshark` (part of Wireshark) is installed and accessible in your system's PATH.
   - Prepare a directory with PCAP files for analysis.

2. **Execution**:
   - Save the script as `PCAPSecurityAnalysis.ps1`.
   - Run the script in PowerShell:
     ```powershell
     .\PCAPSecurityAnalysis.ps1
     ```

## Customisation
- **Directory Paths**: Update the `$PCAPDir` and `$OutputFile` variables to specify the correct locations on your system.
- **Detection Criteria**: Modify the detection patterns in the SSH, DNS, and HTTP checks based on specific security needs or additional threat models.

## Notes
- It is recommended to test the script with sample PCAP files to verify its functionality before deploying it in a production environment.
- Regularly analyse PCAP files to maintain a proactive security posture.

## License
This script is provided under the MIT License. See the root LICENSE file for details.
