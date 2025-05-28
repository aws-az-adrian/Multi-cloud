# VPC Dev con CIDR 192.168.2.0/24
resource "aws_vpc" "vpc-aws" {
  cidr_block           = "192.168.1.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc-aws"
  }
}
