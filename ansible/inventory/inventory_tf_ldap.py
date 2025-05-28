#!/usr/bin/env python3

import json
import os

# Obtener la ruta del script actual
script_dir = os.path.dirname(os.path.abspath(__file__))
terraform_output_path = os.path.abspath(os.path.join(script_dir, '..', 'terraform_output.json'))


# Leer el archivo JSON de Terraform
with open(terraform_output_path) as f:
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