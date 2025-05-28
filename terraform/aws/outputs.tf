output "ip_server_2" {
  value = aws_instance.asir-server-2.private_ip
}

output "ip_public_server_2" {
  value = aws_instance.asir-server-2.public_ip
<<<<<<< HEAD
=======
}

output "ip_client_2" {
  value = aws_instance.asir-cliente-2.private_ip
}
output "ip_public_client_2" {
  value = aws_instance.asir-cliente-2.public_ip
>>>>>>> ee28cd86c9a36fe0fe3c53d5140d59a8183b2820
}