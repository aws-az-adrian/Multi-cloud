#!/bin/bash

# Ruta al archivo JSON de Terraform
TF_OUTPUT_JSON="terraform_output.json"

# Ruta al archivo de variables del cliente LDAP
LDAP_CLIENT_VARS="playbooks/vars/ldap-client.yml"

# Extraer la IP pública del servidor LDAP desde el JSON
IP_LDAP=$(jq -r '.ip_public_server_2.value' "$TF_OUTPUT_JSON")

# Verificar que se extrajo correctamente
if [[ -z "$IP_LDAP" || "$IP_LDAP" == "null" ]]; then
  echo "❌ No se pudo obtener la IP pública del servidor LDAP."
  exit 1
fi

# Actualizar la línea en ldap-client.yml
sed -i "s|^ldap_server_ip:.*|ldap_server_ip: \"$IP_LDAP\"|" "$LDAP_CLIENT_VARS"

echo "✅ IP LDAP actualizada en $LDAP_CLIENT_VARS: $IP_LDAP"