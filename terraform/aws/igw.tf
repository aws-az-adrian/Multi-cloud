resource "aws_internet_gateway" "asir-igw-2" {
  vpc_id = aws_vpc.vpc-aws.id 
  tags   = { Name = "asir-igw-2" } # Gateway de Internet
}


