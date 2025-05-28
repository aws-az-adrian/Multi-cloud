
# Subred privada en VPC dev
resource "aws_subnet" "subnet-aws-server" {
  vpc_id                  = aws_vpc.vpc-aws.id
  cidr_block              = "192.168.1.0/26"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-aws"
  }
}


# Subred privada en VPC dev
resource "aws_subnet" "subnet-aws-client" {
  vpc_id                  = aws_vpc.vpc-aws.id
  cidr_block              = "192.168.1.64/26"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "subnet-aws"
  }
}
