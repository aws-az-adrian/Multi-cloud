output "ec2_ip" {
 description = "IP pública de la EC2 router"
 value       = aws_instance.ll-test-ec2-front.public_ip
}

output "flow_log_id" {
  description = "ID del Flow Log de la VPC"
  value       = aws_flow_log.ll-test-flowlogs-back.id
}
