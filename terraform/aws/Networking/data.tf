data "terraform_remote_state" "hub" {
  backend = "local"
  config = {
    path = "../VPC-Hub/terraform.tfstate"
  }
}