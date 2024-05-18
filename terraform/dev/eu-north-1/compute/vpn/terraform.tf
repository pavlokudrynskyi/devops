provider "aws" {
  region  = var.region
  profile = "theprojectname"
}

terraform {
  required_version = "1.7.3"

  backend "s3" {
    bucket  = "theprojectname-tfstates-dev"
    encrypt = true
    key     = "dev/eu-north-1/compute/vpn/terraform.tfstate"
    region  = "eu-north-1"
    profile = "theprojectname"
  }
}
