data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "theprojectname-tfstates-dev"
    key     = "dev/eu-north-1/networking/vpc/terraform.tfstate"
    region  = "eu-north-1"
    profile = "theprojectname"
  }
}

data "terraform_remote_state" "ssm" {
  backend = "s3"
  config = {
    bucket  = "theprojectname-tfstates-dev"
    key     = "dev/global/security/iam/ssm/terraform.tfstate"
    region  = "eu-north-1"
    profile = "theprojectname"
  }
}