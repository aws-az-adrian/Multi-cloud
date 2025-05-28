terraform {
  backend "s3" {
    bucket         = "asir-bucket-2"
    key            = "aws/terraform.tfstate"     # Para el módulo de red
    region         = "us-east-1"
    encrypt        = true
  }
}