#!/usr/bin/env python3

import json

# Leer el archivo JSON de Terraform
with open('../terraform_output.json') as f:
    tf_data = json.load(f)

# Obtener las IPs
ip_public = tf_data["ip_public_server_2"]["value"]
ip_private = tf_data["ip_server_2"]["value"]

# Crear inventario Ansible
inventory = {
    "all": {
        "hosts": [ip_public]
    },
    "ldap_server": {
        "hosts": [ip_public]
    },
    "_meta": {
        "hostvars": {
            ip_public: {
                "ansible_host": ip_public,
                "private_ip": ip_private
            }
        }
    }
}

# Imprimir inventario en formato JSON
print(json.dumps(inventory, indent=2))