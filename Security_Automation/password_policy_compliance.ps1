# Define desired password policy rules 
$desiredPolicy = @{
    "MinimumPasswordLength" = 12
    "PasswordComplexity" = $true
    "PasswordExpirationDays" = 90  #90 days
}

# Function to check and enforce password policy compliance
function Ensure-PasswordPolicyCompliance {
    param (
        [hashtable]$policy
    )

    # Retrieve current password policy settings and create temp file with policy settings
    $currentPolicy = secedit /export /areas SECURITYPOLICY /cfg "$env:TEMP\secpol.cfg"
    $currentSettings = Get-Content "$env:TEMP\secpol.cfg" | Select-String -Pattern 'MinimumPasswordLength|PasswordComplexity|MaxPwdAge'

    # Check minimum password length
    if ($currentSettings -match 'MinimumPasswordLength\s*=\s*(\d+)') {
        $currentMinLength = [int]$matches[1]
        if ($currentMinLength -lt $policy["MinimumPasswordLength"]) {
            Write-Output "Setting Minimum Password Length to $($policy["MinimumPasswordLength"])"
            secedit /set /cfg "$env:TEMP\secpol.cfg" /areas SECURITYPOLICY /value "MinimumPasswordLength=$($policy["MinimumPasswordLength"])"
        } else {
            Write-Output "Minimum Password Length is compliant."
        }
    }

    # Check password complexity
    if ($currentSettings -match 'PasswordComplexity\s*=\s*(\d+)') {
        $currentComplexity = [int]$matches[1]
        if ($currentComplexity -ne ($policy["PasswordComplexity"] ? 1 : 0)) {
            Write-Output "Setting Password Complexity to $($policy["PasswordComplexity"])"
            secedit /set /cfg "$env:TEMP\secpol.cfg" /areas SECURITYPOLICY /value "PasswordComplexity=$($policy["PasswordComplexity"] ? 1 : 0)"
        } else {
            Write-Output "Password Complexity is compliant."
        }
    }

    # Check password expiration
    if ($currentSettings -match 'MaxPwdAge\s*=\s*(\d+)') {
        $currentExpirationDays = [int]$matches[1]
        if ($currentExpirationDays -ne $policy["PasswordExpirationDays"]) {
            Write-Output "Setting Password Expiration to $($policy["PasswordExpirationDays"]) days"
            secedit /set /cfg "$env:TEMP\secpol.cfg" /areas SECURITYPOLICY /value "MaxPwdAge=$($policy["PasswordExpirationDays"])"
        } else {
            Write-Output "Password Expiration is compliant."
        }
    }

    # Apply the new settings
    secedit /configure /db secedit.sdb /cfg "$env:TEMP\secpol.cfg" /areas SECURITYPOLICY
    Remove-Item "$env:TEMP\secpol.cfg"  # Clean up temporary file
}

# Execute the compliance check
Ensure-PasswordPolicyCompliance -policy $desiredPolicy

Write-Output "Password policy compliance check completed."
