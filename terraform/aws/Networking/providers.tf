# Configuración del proveedor de AWS (región por defecto us-east-1)
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags #Sirve para definir tags en todos los recursos, sin necesidad de ser llamados por ellos.
  }
}


# Datos de AMI de Amazon Linux 2 (última versión disponible) para lanzar instancias EC2
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"] # AMIs propiedad de Amazon
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Patrón para Amazon Linux 2
  }
}

