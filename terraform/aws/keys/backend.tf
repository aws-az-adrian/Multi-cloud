resource "aws_s3_object" "upload_key_pem" {
  bucket = "asir-bucket-2"
  key    = "keys/my-key-asir.pem" # Ruta dentro del bucket
  source = "${path.module}/my-key-asir.pem" # Ruta local al archivo
  etag   = filemd5("${path.module}/my-key-asir.pem") # Ayuda a detectar cambios
  content_type = "application/x-pem-file"
  acl    = "private"
}

terraform {
  backend "s3" {
    bucket         = "asir-bucket-2"
    key            = "keys/terraform.tfstate"     # Para el módulo de red
    region         = "us-east-1"
    encrypt        = true
  }
}