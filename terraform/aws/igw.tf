resource "aws_internet_gateway" "ll-hub-igw-front" {
  vpc_id = aws_vpc.ll-hub-vpc-front.id
  tags   = { Name = "ll-hub-igw-front" } # Gateway de Internet
}


