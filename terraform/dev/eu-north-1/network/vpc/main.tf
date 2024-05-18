module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  name                          = var.vpc_name
  cidr                          = var.cidr
  azs                           = var.azs
  private_subnets               = var.private_subnets
  intra_subnets                 = var.intra_subnets
  public_subnets                = var.public_subnets
  enable_nat_gateway            = true
  single_nat_gateway            = true
  one_nat_gateway_per_az        = false
  enable_dns_hostnames          = true
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false
  map_public_ip_on_launch       = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}
