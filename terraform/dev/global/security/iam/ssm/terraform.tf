terraform {
  required_version = "1.7.3"

  backend "s3" {
    bucket  = "theprojectname-tfstates-dev"
    key     = "dev/global/security/iam/ssm/terraform.tfstate"
    encrypt = true
    region  = "eu-north-1"
    profile = "theprojectname"
  }
}

provider "aws" {
  region  = var.region
  profile = "theprojectname"
  default_tags {
    tags = {
      Application  = "SSM"
      Environment  = "Development"
      Purpose      = "For running Session manager on AWS EC2"
      Service      = "IAM"
      ServiceGroup = "Security"
      Owner        = "Terraform"
    }
  }
}
