resource "aws_security_group" "ll-pro-sg-front" {
  name        = "ll-pro-sg-front"
  description = "Security Group de instancias app (frontend/backend) en pro2"
  vpc_id      = aws_vpc.ll-pro-VPC-front.id
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
    # description = "Permitir tráfico interno entre instancias del mismo SG"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
    # description = "Permitir acceso HTTP desde redes on-premises"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
    # description = "Permitir acceso SSH desde redes on-premises"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # description = "Permitir todo el tráfico de salida"
  }
  tags = {
    Name = "ll-pro-sg-front"
  }
}

####DEV
resource "aws_security_group" "ll-test-sg-front" {
  name        = "ll-test-sg-front"
  description = "Security Group de instancias app (frontend/backend) en pro2"
  vpc_id      = aws_vpc.ll-test-VPC-front.id
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
    # description = "Permitir tráfico interno entre instancias del mismo SG"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
    # description = "Permitir acceso HTTP desde redes on-premises"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
    # description = "Permitir acceso SSH desde redes on-premises"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # description = "Permitir todo el tráfico de salida"
  }
  tags = {
    Name = "ll-test-sg-front"
  }
}
resource "aws_security_group" "ll-hub-sg-router-front" {
  name        = "ll-hub-sg-router-fron"
  description = "Allow all for router"
  vpc_id      = aws_vpc.ll-hub-vpc-front.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.2.0/24", "192.168.1.0/24", "192.168.3.0/24"] # subredes de dev/pro
    # description = "Permitir tráfico desde las subredes de Dev y pro" 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

