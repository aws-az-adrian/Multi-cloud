# # install-zerotier.ps1
# $networkID = "YOUR_ZEROTIER_NETWORK_ID"  # Cambia por tu ID real

# Invoke-WebRequest -Uri "https://download.zerotier.com/RELEASES/1.12.2/dist/ZeroTier%20One.msi" -OutFile "C:\ZeroTierOne.msi"
# Start-Process msiexec.exe -Wait -ArgumentList '/i', 'C:\ZeroTierOne.msi', '/quiet'
# Start-Sleep -Seconds 10

# zerotier-cli join $networkID

# Start-Sleep -Seconds 10
# zerotier-cli listnetworks

# Set-Service -Name "ZeroTierOneService" -StartupType Automatic
# Start-Service -Name "ZeroTierOneService"