#!/bin/bash
# Habilitar el reenvío de paquetes IP
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

# Configurar NAT para enrutar tráfico saliente a través de eth0
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

chmod 400 "my-key-asir.pem"
