data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    profile = "theprojectname"
    bucket  = "theprojectname-tfstates-dev"
    encrypt = true
    key     = "dev/eu-north-1/networking/vpc/terraform.tfstate"
    region  = "eu-north-1"
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    profile = "theprojectname"
    bucket  = "theprojectname-tfstates-dev"
    encrypt = true
    key     = "dev/eu-north-1/containers/eks/terraform.tfstate"
    region  = "eu-north-1"
  }
}


data "tls_certificate" "cluster" {
  url = module.eks.cluster_oidc_issuer_url
}

data "terraform_remote_state" "ssm" {
  backend = "s3"
  config = {
    profile = "theprojectname"
    bucket  = "theprojectname-tfstates-dev"
    encrypt = true
    key     = "dev/global/security/iam/ssm/terraform.tfstate"
    region  = "eu-north-1"
  }
}

data "aws_caller_identity" "current" {}
data "aws_default_tags" "default" {}

data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

