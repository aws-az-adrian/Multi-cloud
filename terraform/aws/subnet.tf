
# Subred privada en VPC dev
<<<<<<< HEAD
resource "aws_subnet" "subnet-aws-server" {
  vpc_id                  = aws_vpc.vpc-aws.id
  cidr_block              = "192.168.1.0/26"
=======
resource "aws_subnet" "subnet-aws" {
  vpc_id                  = aws_vpc.vpc-aws.id
  cidr_block              = "192.168.1.0/24"
>>>>>>> ee28cd86c9a36fe0fe3c53d5140d59a8183b2820
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-aws"
  }
}
<<<<<<< HEAD


# Subred privada en VPC dev
resource "aws_subnet" "subnet-aws-client" {
  vpc_id                  = aws_vpc.vpc-aws.id
  cidr_block              = "192.168.1.64/26"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "subnet-aws"
  }
}
=======
>>>>>>> ee28cd86c9a36fe0fe3c53d5140d59a8183b2820
