# Documentation for Firewall Rule Configuration Script

## Overview
This PowerShell script configures Windows Firewall rules to allow traffic from a specific IP address while blocking all other incoming traffic on the specified port. This enhances security by restricting access to sensitive services.

## Script Details

### Define Allowed IP Address and Port
- **Purpose**: To set the parameters for the IP address and port that will be used in the firewall rules.
- **Variables**:
  - **`$allowedIP`**: The specific IP address allowed to connect (default: `"192.168.1.100"`). Modify as needed.
  - **`$allowedPort`**: The port number (default: `22`). Modify as needed.

### Allow Traffic from Specified IP
- **Purpose**: To create a firewall rule that permits inbound traffic from the allowed IP on the specified port.
- **Actions**:
  - Creates a new firewall rule using the `New-NetFirewallRule` cmdlet:
    ```powershell
    New-NetFirewallRule -DisplayName "Allow SSH Traffic from Specific IP" `
        -Direction Inbound `
        -Action Allow `
        -RemoteAddress $allowedIP `
        -LocalPort $allowedPort `
        -Protocol TCP `
        -Profile Domain,Private,Public `  # Apply to all profiles
        -Enabled True
    ```

### Block All Other Incoming Traffic
- **Purpose**: To create a rule that blocks all other incoming traffic on the specified port.
- **Actions**:
  - Creates another firewall rule to block all other traffic:
    ```powershell
    New-NetFirewallRule -DisplayName "Block All Other Incoming SSH Traffic" `
        -Direction Inbound `
        -Action Block `
        -LocalPort $allowedPort `
        -Protocol TCP `
        -Profile Domain,Private,Public `  # Apply to all profiles
        -Enabled True
    ```

### Output Message
- **Purpose**: To provide feedback confirming that the rules have been created.
- **Output**:
  ```powershell
  Write-Output "Firewall rules created: Allowed traffic from $allowedIP on port $allowedPort and blocked all other incoming traffic on that port for all profiles."
  ```

## How to Run
1. **Prerequisites**:
   - Ensure you have administrative privileges to execute the script.
   - Open PowerShell as an administrator.

2. **Execution**:
   - Save the script as `ConfigureFirewallRules.ps1`.
   - Run the script in PowerShell:
     ```powershell
     .\ConfigureFirewallRules.ps1
     ```

## Customisation
- **Display Name**: Change the value of the `DisplayName` when creating the rule to describe the rule's purpose.
- **Allowed IP Address**: Change the value of `$allowedIP` to allow traffic from a different IP address as needed.
- **Allowed Port**: Modify the `$allowedPort` variable if you wish to configure a different port or another service.

## Notes
- Ensure that you test the firewall rules in a safe environment to confirm that they work as expected.
- Regularly review firewall rules to adapt to changing network environments and security needs.

## License
This script is provided under the MIT License. See the root LICENSE file for details.
