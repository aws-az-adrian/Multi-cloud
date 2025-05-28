resource "aws_security_group" "asir-sg-server-2"  {
  name        = "asir-sg-server-2"
  description = "Security Group de instancias app (frontend/backend) en pro2"
  vpc_id      = aws_vpc.vpc-aws.id
<<<<<<< HEAD
=======

>>>>>>> ee28cd86c9a36fe0fe3c53d5140d59a8183b2820
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
<<<<<<< HEAD
    # description = "Permitir tráfico interno entre instancias del mismo SG"
  }
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # O tu IP concreta para mayor seguridad
  }
=======
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

>>>>>>> ee28cd86c9a36fe0fe3c53d5140d59a8183b2820
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24", "192.168.0.0/24", "192.168.2.0/24"]
<<<<<<< HEAD
    # description = "Permitir acceso HTTP desde redes on-premises"
  }
=======
  }

>>>>>>> ee28cd86c9a36fe0fe3c53d5140d59a8183b2820
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
<<<<<<< HEAD
    # description = "Permitir acceso SSH desde redes on-premises"
  }
=======
  }

ingress {
  from_port   = 389
  to_port     = 389
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # O mejor, la red interna o IP del cliente
}

>>>>>>> ee28cd86c9a36fe0fe3c53d5140d59a8183b2820
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
<<<<<<< HEAD
    # description = "Permitir todo el tráfico de salida"
  }
=======
  }

>>>>>>> ee28cd86c9a36fe0fe3c53d5140d59a8183b2820
  tags = {
    Name = "asir-sg-server-2"
  }
}

###CREAR OTRO EXPRESAMENTE PARA EL CLIENTE

resource "aws_security_group" "asir-sg-client-2" {
  name        = "asir-sg-client-2"
  description = "Security Group de instancias app (frontend/backend) en pro2"
  vpc_id      = aws_vpc.vpc-aws.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
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
<<<<<<< HEAD
    cidr_blocks = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
=======
    cidr_blocks = ["0.0.0.0/0"]
>>>>>>> ee28cd86c9a36fe0fe3c53d5140d59a8183b2820
    # description = "Permitir acceso SSH desde redes on-premises"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # description = "Permitir todo el tráfico de salida"
  }
<<<<<<< HEAD
=======
  ingress {
  from_port   = 389
  to_port     = 389
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # O mejor, la red interna o IP del cliente
}
>>>>>>> ee28cd86c9a36fe0fe3c53d5140d59a8183b2820
  tags = {
    Name = "asir-sg-client-2"
  }
}