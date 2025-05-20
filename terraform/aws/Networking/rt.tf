# #Tabla de rutas de dev
# resource "aws_route_table" "ll-test-RT-front" {
#   vpc_id = aws_vpc.ll-test-VPC-front.id
#   tags = {
#     Name = "ll-test-RT-front"
#   }
#   route {
#     cidr_block                = aws_vpc.ll-h-vpc-hub-000.cidr_block
#     vpc_peering_connection_id = aws_vpc_peering_connection.ll-test-peering-hub_Dev-front.id
#   }

# }
# resource "aws_route_table_association" "ll-test-RT_assoc-front" {
#   subnet_id      = aws_subnet.ll-test-p_subnet-front.id
#   route_table_id = aws_route_table.ll-test-RT-front.id
# }

# #####TABLA DE RUTAS HUB
resource "aws_route_table" "ll-hub-rt-public-front" {
  vpc_id = aws_vpc.ll-hub-vpc-front.id
  tags   = { Name = "ll-hub-rt-public-front" } # Primera tabla de rutas pública 
  route {
    cidr_block                = aws_vpc.ll-pro-VPC-front.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.ll-pro-peering-hub_to_Pro-front.id
  }
  route {
    cidr_block                = aws_vpc.ll-test-VPC-front.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.ll-test-peering-hub_to_Dev-front.id
  }
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ll-hub-igw-front.id
  }
}


resource "aws_route_table_association" "ll-hub-rt-asso-public" {
  subnet_id      = aws_subnet.ll-hub-subnet-router-front.id
  route_table_id = aws_route_table.ll-hub-rt-public-front.id
}

# #Tabla de rutas de pro
# resource "aws_route_table" "ll-pro-RT-front" {
#   vpc_id = aws_vpc.ll-pro-VPC-front.id
#   tags = {
#     Name = "ll-pro-RT-front"
#   }
#   route {
#     cidr_block                = aws_vpc.ll-h-vpc-hub-000.cidr_block
#     vpc_peering_connection_id = aws_vpc_peering_connection.ll-pro-peering-hub_Pro-front.id
#   }

# }
# resource "aws_route_table_association" "ll-pro-RT_assoc-front" {
#   subnet_id      = aws_subnet.ll-pro-p_subnet-front.id
#   route_table_id = aws_route_table.ll-pro-RT-front.id
# }
