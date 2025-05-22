# Instancias EC2 Frontend y Backend en Dev
resource "aws_instance" "ll-test-ec2-front" {
  ami                    = data.aws_ami.ubuntu_24.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet-aws.id
  key_name               = data.aws_key_pair.my-key-final.key_name
  vpc_security_group_ids = [data.terraform_remote_state.Networking.outputs.sg-dev-id]
  tags = {
    Name = "ll-test-ec2-front"
  }
}

