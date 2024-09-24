# Documentation for Windows Security Hardening Script

## Overview
This PowerShell script performs security hardening on a Windows system by disabling unnecessary services, configuring Windows Defender, managing firewall rules, and applying essential security settings. 

## Script Details

### Disable Unnecessary Services
- **Purpose**: To enhance security by disabling services that are not needed, thus reducing potential attack vectors.
- **Actions**:
  - Stops the Telnet service if it is running:
    ```powershell
    Get-Service -Name "Telnet" | Stop-Service -Force
    ```
  - Disables the Telnet service from starting at boot:
    ```powershell
    Set-Service -Name "Telnet" -StartupType Disabled
    ```

### Configure Windows Defender
- **Purpose**: To ensure Windows Defender is fully operational, providing real-time protection against threats.
- **Actions**:
  - Enables real-time monitoring:
    ```powershell
    Set-MpPreference -DisableRealtimeMonitoring $false
    ```
  - Enables behavior monitoring:
    ```powershell
    Set-MpPreference -DisableBehaviorMonitoring $false
    ```
  - Enables script scanning:
    ```powershell
    Set-MpPreference -DisableScriptScanning $false
    ```

### Configure Firewall Rules
- **Purpose**: To ensure that the Windows Firewall is active across all profiles, providing a barrier against unauthorised access.
- **Actions**:
  - Enables Windows Firewall for Domain, Public, and Private profiles:
    ```powershell
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
    ```

### Apply Security Settings
- **Purpose**: To enforce security features in the Windows operating system.
- **Actions**:
  - Ensures User Account Control (UAC) is enabled:
    ```powershell
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 1
    ```

## How to Run
1. **Prerequisites**:
   - Ensure you have administrative privileges to execute the script.
   - Open PowerShell as an administrator.

2. **Execution**:
   - Save the script as `WindowsSecurityHardening.ps1`.
   - Run the script in PowerShell:
     ```powershell
     .\WindowsSecurityHardening.ps1
     ```

## Customisation
- **Services**: Modify the service names in the script to disable other unnecessary services based on your environment.
- **Defender Settings**: Adjust the Windows Defender settings if specific features need to be enabled or disabled based on organisational policy.
- **Firewall Profiles**: You can specify different firewall profiles or custom rules as needed.

## Notes
- It is recommended to test this script in a non-production environment first to ensure that it does not disrupt necessary services.
- Regularly review and update security configurations as part of your security management practices.

## License
This script is provided under the MIT License. See the root LICENSE file for details.
