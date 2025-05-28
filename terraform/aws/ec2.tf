# Instancias EC2 Ubuntu server 24.04
resource "aws_instance" "asir-server-2" {
  ami                    = "ami-084568db4383264d4"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet-aws-server.id
  associate_public_ip_address = true
  key_name               = "my-key-asir"
  user_data = file("user_data.sh")
  vpc_security_group_ids = [aws_security_group.asir-sg-server-2.id] 
  tags = {
    Name = "asir-server-2"
  }
  provisioner "file" {
    source      = "keys/my-key-asir.pem"
    destination = "/home/ubuntu/my-key-asir.pem"
        
      connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("keys/my-key-asir.pem")  # Tu clave para conectarte a Ubuntu
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/my-key-asir.pem"
    ]
            
      connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("keys/my-key-asir.pem")  # Tu clave para conectarte a Ubuntu
      host        = self.public_ip
    }


  }
}

# Instancias EC2 Cliente
resource "aws_instance" "asir-cliente-2" {
  ami                    = data.aws_ami.amazon_linux2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet-aws-client.id
  key_name               = "my-key-asir"
  vpc_security_group_ids = [aws_security_group.asir-sg-client-2.id]
  tags = {
    Name = "asir-cliente-2"
  }
}

