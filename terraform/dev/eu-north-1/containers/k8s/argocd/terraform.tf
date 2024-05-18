terraform {
  required_version = "1.4.6"
  backend "s3" {
    bucket  = "theprojectname-tfstates-dev"
    encrypt = true
    key     = "dev/eu-north-1/containers/k8s/argocd/terraform.tfstate"
    region  = "eu-north-1"
    profile = "theprojectname"
  }
}

provider "helm" {
  kubernetes {
    config_path = var.config_path
  }
}

provider "aws" {
  region  = "eu-north-1"
  profile = "theprojectname"
}
