provider "aws" {
  region  = var.region
  profile = "theprojectname"
  default_tags {
    tags = {
      Environment  = "Development"
      Purpose      = "Development ECR for eu-north-1 region"
      Service      = "ECR"
      ServiceGroup = "Containers"
      Owner        = "Terraform"
    }
  }
}

terraform {
  required_version = ">= 1.7.3"

  backend "s3" {
    bucket  = "theprojectname-tfstates-dev"
    encrypt = true
    key     = "dev/eu-north-1/containers/ecr/terraform.tfstate"
    region  = "eu-north-1"
    profile = "theprojectname"
  }
}
