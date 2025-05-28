terraform {
  backend "s3" {
    bucket         = "asir-bucket-2"
    key            = "s3/terraform.tfstate"     # Para el módulo de red
    region         = "us-east-1"
    encrypt        = true
  }
}