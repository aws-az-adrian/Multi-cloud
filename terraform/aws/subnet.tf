
# Subred privada en VPC dev
resource "aws_subnet" "ll-test-subnet-front" {
  vpc_id                  = aws_vpc.ll-test-VPC-front.id
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "ll-test-p_subnet-front"
  }
}
