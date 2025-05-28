output "ip_server_2" {
  value = aws_instance.asir-server-2.private_ip
}

output "ip_public_server_2" {
  value = aws_instance.asir-server-2.public_ip
}

output "ip_client_2" {
  value = aws_instance.asir-cliente-2.private_ip
}
output "ip_public_client_2" {
  value = aws_instance.asir-cliente-2.public_ip
}