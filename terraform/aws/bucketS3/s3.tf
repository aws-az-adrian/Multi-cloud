resource "aws_s3_bucket" "asir-bucket-2" {
  bucket = "asir-bucket-2"
  acl    = "private"
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "asir-bucket-2"
  }

}