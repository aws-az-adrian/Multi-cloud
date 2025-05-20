# Peering entre VPC Hub y VPC dev
resource "aws_vpc_peering_connection" "ll-test-peering-hub_to_Dev-front" {
  vpc_id      = aws_vpc.ll-hub-vpc-front.id
  peer_vpc_id = aws_vpc.ll-test-VPC-front.id
  auto_accept = true
  tags = {
    Name = "ll-test-peering-hub_to_Dev-front"
  }
}
