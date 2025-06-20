resource "aws_route_table" "asir-rt-public-2" {
  vpc_id = aws_vpc.vpc-aws.id
  tags = {
    Name = "asir-rt-2"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.asir-igw-2.id
  }

}
resource "aws_route_table_association" "ll-test-RT_assoc-front" {
  subnet_id      = aws_subnet.subnet-aws.id
  route_table_id = aws_route_table.asir-rt-public-2.id
}
