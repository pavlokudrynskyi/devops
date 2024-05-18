variable "region" {
  description = "Default Region"
  default     = "eu-north-1"
}

variable "environment" {
  description = "Environment name"
  default     = "dev"
}

variable "k8s_version" {
  description = "k8s cluster version"
  default     = "1.26"
  type        = string
}

variable "cluster_name" {
  description = "k8s cluster name"
  default     = "dev-cluster"
}

variable "node_groups" {
  description = "EKS node groups parameters"
  default = {
    general        = { desired_size = 1, max_size = 6, min_size = 1, capacity_type = "ON_DEMAND", disk_size = 50, disk_type = "gp3", instance_types = ["t3.large", "t3.xlarge"] }
  }
}

variable "ami_id" {
  description = "AMI id of the EKS Node Group"
  type        = string
  default     = "ami-06a4eab4c272bacdc"
}

variable "vpc_cni_version" {
  description = "VPC CNI EKS Addon version"
  type        = string
  default     = "v1.17.1-eksbuild.1"
}

variable "cluster_service_ipv4_cidr" {
  default = "10.69.0.0/19"
}

variable "ingress_cidr_blocks" {
  description = "Ingress cidr blocks"
  default     = ["10.1.0.0/16"]
}

variable "iam_tags" {
  description = "Specific tags for IAM resources"
  default = {
    Service      = "IAM"
    ServiceGroup = "Security"
  }
}
variable "eks_tags" {
  description = "Specific tags for EKS resources"
  default = {
    Service      = "EKS"
    ServiceGroup = "Containers"
  }
}
variable "sg_tags" {
  description = "Specific tags for SG resources"
  default = {
    Service      = "VPC"
    ServiceGroup = "Security"
  }
}
