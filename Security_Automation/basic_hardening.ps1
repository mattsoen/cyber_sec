# Disable unnecessary services
Write-Output "Disabling unnecessary services..."
Get-Service -Name "Telnet" | Stop-Service -Force
Set-Service -Name "Telnet" -StartupType Disabled

# Configure Windows Defender
Write-Output "Configuring Windows Defender..."
Set-MpPreference -DisableRealtimeMonitoring $false
Set-MpPreference -DisableBehaviorMonitoring $false
Set-MpPreference -DisableScriptScanning $false

# Configure firewall rules
Write-Output "Configuring Windows Firewall..."
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# Apply security settings
Write-Output "Applying security settings..."
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 1
