data "terraform_remote_state" "hub" {
  backend = "local"
  config = {
    path = "../VPC-Hub/terraform.tfstate"
  }
}

data "terraform_remote_state" "Networking" {
  backend = "local"
  config = {
    path = "../Networking/terraform.tfstate"
  }
}

data "aws_key_pair" "my-key-final" {
  key_name = "my-key-final"
}