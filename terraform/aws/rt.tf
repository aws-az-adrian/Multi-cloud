# resource "aws_route_table" "ll-test-RT-front" {
#   vpc_id = data.terraform_remote_state.Networking.outputs.vpc_id_dev
#   tags = {
#     Name = "ll-test-RT-front"
#   }
#   route {
#     cidr_block                = data.terraform_remote_state.Networking.outputs.vpc_id_hub_cidr_block
#     vpc_peering_connection_id = data.terraform_remote_state.Networking.outputs.peering_id_dev
#   }

# }
# resource "aws_route_table_association" "ll-test-RT_assoc-front" {
#   subnet_id      = data.terraform_remote_state.Networking.outputs.subnet_id_dev
#   route_table_id = aws_route_table.ll-test-RT-front.id
# }

####FALTA POR REALIZAR TABLA DE RUTAS