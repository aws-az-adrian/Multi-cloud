#--------------------------------------------------
#--------DEV------
#--------------------------------------------------
output "peering_id_dev" {
  description = "ID del peering de Dev"
  value       = aws_vpc_peering_connection.ll-test-peering-hub_to_Dev-front.id

}
output "vpc_id_dev_cidr_block" {
  description = "ID de la VPC Dev"
  value       = aws_vpc.ll-test-VPC-front.cidr_block
}
output "vpc_id_dev" {
  description = "ID de la VPC de Dev"
  value       = aws_vpc.ll-test-VPC-front.id

}


output "subnet_id_dev" {
  description = "ID de la subred de Dev"
  value       = aws_subnet.ll-test-subnet-front.id

}

output "sg-dev-id" {
  value = aws_security_group.ll-test-sg-front.id
  description = "ID del Security Group de Dev"
  
}

#--------------------------------------------------
#--------HUB------
#--------------------------------------------------
output "vpc_id_hub" {
  description = "ID de la VPC hub"
  value       = aws_vpc.ll-hub-vpc-front.id
}

output "public_subnet_id_hub" {
  description = "ID de la subred pública"
  value       = aws_subnet.ll-hub-subnet-router-front.id
}
output "vpc_id_hub_cidr_block" {
  description = "ID de la VPC hub"
  value       = aws_vpc.ll-hub-vpc-front.cidr_block
}
output "igw_id" {
  description = "id del Internet Gateway"
  value = aws_internet_gateway.ll-hub-igw-front.id
}

output "rt_id_hub" {
  description = "ID de la tabla de rutas del hub"
  value       = aws_route_table.ll-hub-rt-public-front.id
  
}

output "sg-hub-id" {
  value = aws_security_group.ll-hub-sg-router-front.id
  description = "ID del Security Group del hub"
  
}
#--------------------------------------------------
#--------pro------
#--------------------------------------------------
output "peering_id_pro" {
  description = "ID del peering de pro"
  value       = aws_vpc_peering_connection.ll-pro-peering-hub_to_Pro-front.id
}

output "vpc_id_pro_cidr_block" {
  description = "ID de la VPC Dev"
  value       = aws_vpc.ll-pro-VPC-front.cidr_block
}
output "vpc_id_pro" {
  description = "ID de la VPC de pro"
  value       = aws_vpc.ll-pro-VPC-front.id

}
output "subnet_id_pro" {
  description = "ID de la subred de Dev"
  value       = aws_subnet.ll-pro-subnet-front.id
}

output "sg-pro-id" {
  value = aws_security_group.ll-pro-sg-front.id
  description = "ID del Security Group de pro"
}