terraform {
  required_version = "1.4.6"
  backend "s3" {
    bucket  = "theprojectname-tfstates-dev"
    encrypt = true
    key     = "dev/eu-north-1/containers/k8s/argocd-apps/terraform.tfstate"
    region  = "eu-north-1"
    profile = "ardent"
  }
}

provider "aws" {
  region  = var.region
  profile = "theprojectname"
}

provider "helm" {
  kubernetes {
    config_path = var.config_path
  }
}
