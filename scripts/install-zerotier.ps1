# === 1. Instalar Active Directory Domain Services ===
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

$DomainName = "asir2.com"
$SafeModePassword = ConvertTo-SecureString "Mosquito123." -AsPlainText -Force

Install-ADDSForest `
    -DomainName $DomainName `
    -SafeModeAdministratorPassword $SafeModePassword `
    -InstallDns `
    -Force

# IMPORTANTE: El servidor se reiniciará automáticamente después de promoverse a DC.
# Por eso todo lo que va después de esto puede no ejecutarse a menos que hagas un segundo script post-reinicio.
# Alternativa: usar Scheduled Task o separar en dos scripts (antes y después del reinicio).

# === 2. Instalar y unir a ZeroTier ===
# IMPORTANTE: este bloque solo funcionará si se ejecuta después del reinicio

$ztInstaller = "https://download.zerotier.com/RELEASES/1.12.2/dist/ZeroTier%20One.msi"
$networkID = "233ccaac27f86b0f"  # Sustituye por el tuyo

$ztPath = "C:\ZeroTierOne.msi"

Invoke-WebRequest -Uri $ztInstaller -OutFile $ztPath
Start-Process msiexec.exe -Wait -ArgumentList '/i', $ztPath, '/quiet'
Start-Sleep -Seconds 10

# Unirse a la red ZeroTier
& "$env:ProgramFiles\ZeroTier\One\zerotier-cli.bat" join $networkID
Start-Sleep -Seconds 10
& "$env:ProgramFiles\ZeroTier\One\zerotier-cli.bat" listnetworks

# Asegurar que el servicio de ZeroTier esté en automático
Set-Service -Name "ZeroTierOneService" -StartupType Automatic
Start-Service -Name "ZeroTierOneService"