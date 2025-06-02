#!/bin/bash
set -e

# Habilitar el reenvío de paquetes IP de forma persistente
echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/99-zerotier-forward.conf
sysctl --system

# Configurar NAT para enrutar tráfico saliente a través de eth0
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Permitir tráfico entre interfaces (ZeroTier y eth0)
# iptables -A FORWARD -i zerotier-one -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o zerotier-one -j ACCEPT

# Instalar ZeroTier
curl -s https://install.zerotier.com | bash

# Habilitar y arrancar ZeroTier
systemctl enable zerotier-one
systemctl start zerotier-one

# Esperar a que el demonio esté listo
while ! zerotier-cli info &>/dev/null; do
  sleep 1
done

# Unirse a la red de ZeroTier
zerotier-cli join 233ccaac27f86b0f

# Ver estado
zerotier-cli info

# Cambiar permisos de clave
chmod 400 "my-key-asir.pem"