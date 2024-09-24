# Documentation for Nmap Scan Result Export Script

## Overview
This PowerShell script performs a scan using Nmap on a specified target and exports the results of open ports to a CSV file with a timestamp.

## Script Details

### Variables
- **`$target`**: The command to run Nmap scan on the specified target. *(Default: `"nmap -sS scanme.nmap.org"`)*  
- **`$timestamp`**: A timestamp string formatted as `yyyyMMdd_HHmmss`, used to create a unique filename for the output.  
- **`$outputFile`**: The path where the Nmap scan results will be saved in CSV format. *(Default: `"C:\some\path\nmap_scan_results_$timestamp.csv"`)*  

### Functionality
1. **Run Nmap Scan**:
   - Executes the Nmap command stored in `$target` and captures the output in the variable `$nmapResult` using `Invoke-Expression`.

2. **Parse and Format Results**:
   - Splits the output into lines and filters for lines containing the word "open".
   - Parses each relevant line into fields, creating a custom object with:
     - **Port**: The port number.
     - **State**: The state of the port (e.g., open, closed).
     - **Service**: The service running on the port.

3. **Save to CSV**:
   - Exports the parsed results to a CSV file at the location specified by `$outputFile`, omitting type information.

## How to Run
1. **Prerequisites**:
   - Ensure Nmap is installed on your system.
   - Ensure PowerShell is available for executing the script.
   
2. **Edit Parameters**:
   - Modify the `$target` variable to specify target and scan type.
   - Change the `$outputFile` path to a valid location on your system where you have write permissions.

3. **Execute the Script**:
   - Run the script in a PowerShell environment. For example, save it as `NmapScanExport.ps1` and execute:
     ```powershell
     .\NmapScanExport.ps1
     ```

## Customisation
- **Scan Type**: Modify the Nmap command in the `$target` variable to change the type of scan or add additional flags.
- **Output Path**: Adjust the `$outputFile` variable to save the CSV file in a different location or with a different naming convention.

## Notes
- Ensure that the target host is reachable and that you have permission to scan it.
- Be mindful of network policies and regulations regarding port scanning.

## License
This script is provided under the MIT License. See the root LICENSE file for details.
