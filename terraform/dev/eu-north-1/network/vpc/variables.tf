variable "region" {
  default     = "eu-north-1"
  description = "Default Region"
}

variable "vpc_name" {
  default     = "development-vpc"
  description = "Name of VPC"
}

variable "cluster_name" {
  default     = "dev-cluster"
  description = "EKS Cluster name"
}

variable "cidr" {
  default     = "10.1.0.0/16"
  description = "The CIDR block of the VPC"
}

variable "azs" {
  default     = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
  description = "Availability Zones"
}

variable "public_subnets" {
  default     = ["10.1.0.0/20", "10.1.16.0/20", "10.1.32.0/20"]
  description = "Public subnet ranges"
}

variable "private_subnets" {
  default     = ["10.1.48.0/20", "10.1.64.0/20", "10.1.80.0/20", "10.1.144.0/20"]
  description = "Private subnet ranges"
}

variable "intra_subnets" {
  default     = ["10.1.96.0/20", "10.1.112.0/20", "10.1.128.0/20"]
  description = "Intra subnet ranges"
}

