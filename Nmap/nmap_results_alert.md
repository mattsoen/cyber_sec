# Documentation for Nmap Scan Alert Script

## Overview
This PowerShell script performs a network scan using Nmap on a specified target and sends an email alert if port 80 is found to be open.

## Script Details

### Variables
- **`$target`**: The target hostname or IP address to scan. *(Default: `"scanme.nmap.org"`)*  
- **`$smtpServer`**: The SMTP server used to send the email alert. *(Default: `"smtp.example.com"`)*  
- **`$from`**: The email address from which the alert will be sent. *(Default: `"alert@example.com"`)*  
- **`$to`**: The recipient's email address for the alert. *(Default: `"admin@example.com"`)*  
- **`$subject`**: The subject line of the email alert. *(Default: `"Nmap Scan Alert"`)*  
- **`$body`**: The body of the email alert (initialised as an empty string).

### Functionality
1. **Run Nmap Scan**:
   - Executes the command `nmap` on the specified target and captures the output in the variable `$nmapResult`.

2. **Check Port Status**:
   - Analyses the scan results to check if port 80 is open using a regex match:
     ```powershell
     if ($nmapResult -match "80/tcp\s+open")
     ```

3. **Send Email Alert**:
   - If port 80 is open, constructs the email body and sends an alert using the `Send-MailMessage` cmdlet.

### Email Parameters
- **SMTP Server**: Set to the specified `$smtpServer`.
- **From Address**: The sender's email address defined by `$from`.
- **To Address**: The recipient's email address defined by `$to`.
- **Subject**: The subject defined by `$subject`.
- **Body**: Includes a message indicating that port 80 is open and appends the Nmap scan results.

## How to Run
1. **Prerequisites**:
   - Ensure Nmap is installed on your system.
   - Ensure PowerShell is available for executing the script.
   - Ensure you have access to the specified SMTP server for sending emails.
   
2. **Edit Parameters**:
   - Modify the variables at the beginning of the script to set your desired target, SMTP server, sender, and recipient details.

3. **Execute the Script**:
   - Run the script in a PowerShell environment. For example, save it as `NmapScanAlert.ps1` and execute:
     ```powershell
     .\NmapScanAlert.ps1
     ```

## Customisation
- **Target Host**: Change the `$target` variable to scan a different host or IP.
- **Email Settings**: Update the SMTP server, from/to email addresses, and subject as needed.
- **Port Check**: Modify the port number in the regex match to check other ports as necessary.

## Notes
- Ensure that the target host is reachable and that you have permission to scan it.
- Be aware of network policies and regulations regarding port scanning.

## License
This script is provided under the MIT License. See the root LICENSE file for details.
