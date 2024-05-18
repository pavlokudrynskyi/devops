provider "aws" {
  region  = var.region
  profile = "theprojectname"
  default_tags {
    tags = {
      Environment = "Production"
      Owner       = "Terraform"
      Purpose     = "AWS Managed Kubernetes Cluster"
    }
  }
}

terraform {
  required_version = "1.7.3"


  backend "s3" {
    bucket  = "theprojectname-tfstates-dev"
    key     = "dev/eu-north-1/containers/eks/terraform.tfstate"
    encrypt = true
    profile = "theprojectname"
    region  = "eu-north-1"
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}
