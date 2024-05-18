variable "region" {
  default     = "eu-north-1"
  description = "Default Region"
}

variable "tags" {
  description = "A map of tags to add to VPN"
  default = {
    Name         = "pritunl-production"
    Environment  = "Development"
    Purpose      = "EC2 for VPN access"
    Service      = "EC2"
    ServiceGroup = "Compute"
    Owner        = "Terraform"
  }
}

variable "ami_id" {
  description = "Amazon AMI ID - Ubuntu 20.04"
  default     = "ami-08ae6c1080efa7824"
}