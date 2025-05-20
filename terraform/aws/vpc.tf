# VPC Dev con CIDR 192.168.2.0/24
resource "aws_vpc" "ll-test-VPC-front" {
  cidr_block           = "192.168.2.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "ll-test-VPC-front"
  }
}
