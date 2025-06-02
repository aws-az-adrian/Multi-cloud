#!/bin/bash
set -e

# Instalar ZeroTier
curl -s https://install.zerotier.com | bash

# Habilitar y arrancar el servicio de ZeroTier
systemctl enable zerotier-one
systemctl start zerotier-one

# Esperar a que el demonio esté listo
while ! zerotier-cli info &>/dev/null; do
  sleep 1
done

# Unirse a la red de ZeroTier
zerotier-cli join 233ccaac27f86b0f

# Verificar estado
zerotier-cli info