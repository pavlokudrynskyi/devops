terraform {
  required_version = "1.7.3"

  backend "s3" {
    bucket  = "theprojectname-tfstates-dev"
    encrypt = true
    key     = "dev/eu-north-1/s3/terraform.tfstate"
    region  = "eu-north-1"
    profile = "theprojectname"
  }
}


provider "aws" {
  region  = var.region
  profile = "theprojectname"
}

