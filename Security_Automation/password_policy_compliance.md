# Documentation for Password Policy Compliance Script

## Overview
This PowerShell script checks and enforces a desired password policy on a Windows system. It ensures that the password policy meets specified standards for length, complexity, and expiration, enhancing overall security.

## Script Details

### Define Desired Password Policy Rules
- **Purpose**: To set the parameters for the desired password policy.
- **Variables**:
  - **`$desiredPolicy`**: A hashtable containing the desired password policy settings:
    - **MinimumPasswordLength**: Minimum length for passwords (default: `12`).
    - **PasswordComplexity**: Whether password complexity is enforced (default: `true`).
    - **PasswordExpirationDays**: Number of days before a password expires (default: `90`).

### Function: Ensure-PasswordPolicyCompliance
- **Purpose**: To check the current password policy settings and enforce compliance with the desired policy.
- **Parameters**:
  - **`[hashtable]$policy`**: The desired policy settings passed to the function.

#### Steps Performed by the Function:
1. **Retrieve Current Password Policy**:
   - Exports the current security policy to a temporary configuration file:
     ```powershell
     $currentPolicy = secedit /export /areas SECURITYPOLICY /cfg "$env:TEMP\secpol.cfg"
     ```

2. **Check Minimum Password Length**:
   - Compares the current minimum password length against the desired policy:
     ```powershell
     if ($currentSettings -match 'MinimumPasswordLength\s*=\s*(\d+)') {
         # ... comparison and update logic
     }
     ```

3. **Check Password Complexity**:
   - Checks if password complexity is set according to the desired policy:
     ```powershell
     if ($currentSettings -match 'PasswordComplexity\s*=\s*(\d+)') {
         # ... comparison and update logic
     }
     ```

4. **Check Password Expiration**:
   - Verifies the password expiration policy:
     ```powershell
     if ($currentSettings -match 'MaxPwdAge\s*=\s*(\d+)') {
         # ... comparison and update logic
     }
     ```

5. **Apply New Settings**:
   - Applies the updated security settings:
     ```powershell
     secedit /configure /db secedit.sdb /cfg "$env:TEMP\secpol.cfg" /areas SECURITYPOLICY
     ```

6. **Cleanup**:
   - Removes the temporary configuration file after processing:
     ```powershell
     Remove-Item "$env:TEMP\secpol.cfg"
     ```

### Execute the Compliance Check
- The function is called to enforce the desired password policy:
```powershell
Ensure-PasswordPolicyCompliance -policy $desiredPolicy
```

- A message is output to indicate completion:
```powershell
Write-Output "Password policy compliance check completed."
```

## How to Run
1. **Prerequisites**:
   - Ensure you have administrative privileges to execute the script.
   - Open PowerShell as an administrator.

2. **Execution**:
   - Save the script as `PasswordPolicyCompliance.ps1`.
   - Run the script in PowerShell:
     ```powershell
     .\PasswordPolicyCompliance.ps1
     ```

## Customisation
- **Password Policy Rules**: Modify the values in the `$desiredPolicy` hashtable to reflect your organisation's specific requirements for password policies.
- **Minimum Length, Complexity, and Expiration**: Adjust the parameters based on security needs and compliance requirements.

## Notes
- It is recommended to test this script in a non-production environment before deploying it widely.
- Regularly review and update password policies as part of your organisation's security practices.

## License
This script is provided under the MIT License. See the root LICENSE file for details.
