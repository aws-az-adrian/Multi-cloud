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
ip_public_server = tf_data["ip_public_server_2"]["value"]
ip_private_server = tf_data["ip_server_2"]["value"]
ip_public_client = tf_data["ip_public_client_2"]["value"]
ip_private_client = tf_data["ip_client_2"]["value"]
ssh_key_path = "../terraform/aws/keys/my-key-asir.pem"

# Crear inventario Ansible
inventory = {
    "all": {
        "hosts": [ip_public_server, ip_public_client],
    },
    "ldap_server": {
        "hosts": [ip_public_server]
    },
    "ldap_clients": {
        "hosts": [ip_public_client]
    },
    "_meta": {
        "hostvars": {
            ip_public_server: {
                "ansible_host": ip_public_server,
                "private_ip": ip_private_server,
                "ansible_user": "ubuntu",
                "ansible_ssh_private_key_file": ssh_key_path
            },
            ip_public_client: {
                "ansible_host": ip_public_client,
                "private_ip": ip_private_client,
                "ansible_user": "ec2-user",
                "ansible_ssh_private_key_file": ssh_key_path,
                "ansible_python_interpreter": "/usr/bin/python3"  # usa Python 3.7 primero
}
        }
    }
}

# Imprimir inventario en formato JSON
print(json.dumps(inventory, indent=2))