#!/usr/bin/env python3

import json

# Leer el archivo JSON de Terraform
with open('../terraform_output.json') as f:
    tf_data = json.load(f)

# Obtener las IPs
ips = [
    tf_data["ip_public_server_2"]["value"],
    tf_data["ip_server_2"]["value"]
]

# Crear inventario Ansible
inventory = {
    "all": {
        "hosts": ips
    },
    "_meta": {
        "hostvars": {
            ip: {
                "ansible_host": ip
            } for ip in ips
        }
    }
}

# Imprimir inventario en formato JSON
print(json.dumps(inventory, indent=2))