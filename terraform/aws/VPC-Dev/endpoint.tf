# Endpoint de DynamoDB para Dev
resource "aws_vpc_endpoint" "ll-test-Endpoint_dynamodb-back" {
  vpc_id            = data.terraform_remote_state.Networking.outputs.vpc_id_dev
  service_name      = "com.amazonaws.us-east-1.dynamodb"
  vpc_endpoint_type = "Gateway" 
  route_table_ids   = [aws_route_table.ll-test-RT-front.id]
  tags = {
    Name = "ll-test-Endpoint_dynamodb-backend"
  }
}

# Endpoint de CloudWatch Logs para Dev
resource "aws_vpc_endpoint" "ll-test-Endpoint-cloudWatch-backend" {
  vpc_id            = data.terraform_remote_state.Networking.outputs.vpc_id_dev
  service_name      = "com.amazonaws.us-east-1.logs"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [data.terraform_remote_state.Networking.outputs.subnet_id_dev]
  security_group_ids = [data.terraform_remote_state.Networking.outputs.sg-dev-id]
  private_dns_enabled = true
  tags = {
    Name = "ll-test-Endpoint-cloudWatch-backend"
  }
}
