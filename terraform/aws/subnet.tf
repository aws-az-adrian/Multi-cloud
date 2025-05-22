
# Subred privada en VPC dev
resource "aws_subnet" "subnet-aws" {
  vpc_id                  = aws_vpc.vpc-aws.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "subnet-aws"
  }
}
