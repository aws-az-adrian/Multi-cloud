# Instancias EC2 Frontend y Backend en Dev
resource "aws_instance" "asir-server-2" {
  ami                    = data.aws_ami.ubuntu_24.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet-aws.id
  # key_name               = data.aws_key_pair.my-key-final.key_name
  vpc_security_group_ids = [aws_security_group.asir-sg-2.id] 
  tags = {
    Name = "asir-server-2"
  }
}

# Instancias EC2 Frontend y Backend en Dev
resource "aws_instance" "asir-cliente-2" {
  ami                    = data.aws_ami.amazon_linux2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet-aws.id
  # key_name               = ".../ll-test" PENDIENTE
  vpc_security_group_ids = [aws_security_group.asir-sg-2.id]
  tags = {
    Name = "asir-cliente-2"
  }
}

