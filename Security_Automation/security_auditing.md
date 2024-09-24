# Documentation for Open Ports Security Auditing Script

## Overview
This PowerShell script audits open ports on a Windows system by comparing current open ports with a previously recorded state. If any changes are detected, it sends an alert via email. This helps in maintaining awareness of network security and identifying unauthorised changes.

## Script Details

### Define File Paths
- **Purpose**: To specify the file paths for storing previous and current open ports.
- **Variables**:
  - **`$previousFilePath`**: Path to the file that contains the previous open ports (`"C:\Path\To\PreviousOpenPorts.txt"`).
  - **`$currentFilePath`**: Path to the file that will store the current open ports (`"C:\Path\To\CurrentOpenPorts.txt"`).

### Retrieve Current Open Ports
- **Purpose**: To obtain the list of currently open TCP ports on the system.
- **Actions**:
  - Retrieves current open ports using `Get-NetTCPConnection` and formats the output:
    ```powershell
    $currentOpenPorts = Get-NetTCPConnection | Select-Object LocalPort, State | Sort-Object LocalPort
    $currentOpenPortsFormatted = $currentOpenPorts | Out-String
    ```

### Check for Previous File
- **Purpose**: To determine if a file with previously recorded open ports exists and compare it with the current state.
- **Actions**:
  - If the previous file exists, it reads the contents:
    ```powershell
    if (Test-Path $previousFilePath) {
        $previousOpenPorts = Get-Content $previousFilePath
    ```

  - Compares the current open ports with the previous open ports:
    ```powershell
    if ($currentOpenPortsFormatted -ne $previousOpenPorts) {
        # Send alert if values have changed
    ```

  - If changes are detected, it sends an alert via email:
    ```powershell
    $subject = "Open Ports Changed Alert"
    $body = "The open ports have changed. Please check the current open ports."
    Send-MailMessage -To "admin@example.com" -From "alert@example.com" -Subject $subject -Body $body -SmtpServer "smtp.example.com"
    ```

### Save Current Open Ports to File
- **Purpose**: To store the current open ports for future comparison.
- **Actions**:
  - Outputs the current open ports to the specified file:
    ```powershell
    $currentOpenPortsFormatted | Out-File $currentFilePath -Encoding UTF8
    ```

### Manage Previous File
- **Purpose**: To maintain the state of open ports for the next execution of the script.
- **Actions**:
  - Deletes the previous file if it exists:
    ```powershell
    if (Test-Path $previousFilePath) {
        Remove-Item $previousFilePath
    ```

  - Renames the current file to the previous file name for the next run:
    ```powershell
    Rename-Item -Path $currentFilePath -NewName $previousFilePath
    ```

## How to Run
1. **Prerequisites**:
   - Ensure you have administrative privileges to execute the script.
   - Open PowerShell as an administrator.

2. **Execution**:
   - Save the script as `OpenPortsAudit.ps1`.
   - Run the script in PowerShell:
     ```powershell
     .\OpenPortsAudit.ps1
     ```

## Customisation
- **Email Settings**: Modify the email addresses and SMTP server in the `Send-MailMessage` command to match your organisation's configuration.
- **File Paths**: Change the paths in `$previousFilePath` and `$currentFilePath` as needed to fit your directory structure.

## Notes
- It is advisable to test this script in a controlled environment to ensure it operates as expected before deploying it in production.
- Regular execution of this script can help in monitoring network changes and enhancing security posture.

## License
This script is provided under the MIT License. See the root LICENSE file for details.
