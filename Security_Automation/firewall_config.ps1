# Define the allowed IP address and port
$allowedIP = "192.168.1.100"  # Replace with IP address
$allowedPort = 22             # Port

# Create a rule to allow traffic from the specified IP on port for all profiles
New-NetFirewallRule -DisplayName "Allow SSH Traffic from Specific IP" `
    -Direction Inbound `
    -Action Allow `
    -RemoteAddress $allowedIP `
    -LocalPort $allowedPort `
    -Protocol TCP `
    -Profile Domain,Private,Public `  # Apply to all profiles
    -Enabled True

# Create a rule to block all other incoming traffic on port for all profiles
New-NetFirewallRule -DisplayName "Block All Other Incoming SSH Traffic" `
    -Direction Inbound `
    -Action Block `
    -LocalPort $allowedPort `
    -Protocol TCP `
    -Profile Domain,Private,Public `  # Apply to all profiles
    -Enabled True

# Output message
Write-Output "Firewall rules created: Allowed traffic from $allowedIP on port $allowedPort and blocked all other incoming traffic on that port for all profiles."
