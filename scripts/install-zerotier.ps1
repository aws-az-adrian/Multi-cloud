#ps1_sysnative
# Instalar y unir a ZeroTier (se ejecuta como custom_data al iniciar VM)

$ErrorActionPreference = "Stop"

# === Variables ===
$ztInstaller = "https://download.zerotier.com/RELEASES/1.12.2/dist/ZeroTier%20One.msi"
$ztPath = "C:\ZeroTierOne.msi"
$networkID = "233ccaac27f86b0f"  # Sustituye por tu ID real
$cliPath = "$env:ProgramData\ZeroTier\One\zerotier-one_x64.exe"

# === Descargar instalador ===
try {
    Invoke-WebRequest -Uri $ztInstaller -OutFile $ztPath -UseBasicParsing
} catch {
    Write-Output "ERROR: No se pudo descargar ZeroTier MSI"
    exit 1
}

# === Instalar ZeroTier en modo silencioso ===
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$ztPath`" /quiet"

Start-Sleep -Seconds 15

# === Esperar a que ZeroTier esté completamente instalado ===
$maxTries = 10
$try = 0
while (!(Test-Path $cliPath) -and ($try -lt $maxTries)) {
    Start-Sleep -Seconds 5
    $try++
}

if (!(Test-Path $cliPath)) {
    Write-Output "ERROR: El binario de ZeroTier no se encontró en $cliPath"
    exit 1
}

# === Unirse a la red ZeroTier ===
& $cliPath -q join $networkID
Start-Sleep -Seconds 10

# === Verificar y configurar servicio ===
Set-Service -Name "ZeroTierOneService" -StartupType Automatic
Start-Service -Name "ZeroTierOneService"