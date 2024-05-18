variable "region" {
  description = "Region for placing all resources"
  default     = "eu-north-1"
}

variable "tags" {
  type        = map
  description = "Tags for resources"
  default = {
    Name         = "terraform-infrastructure"
    Environment  = "Development"
    Purpose      = "Infrastructure State"
    Service      = "S3" 
    ServiceGroup = "Storage"
    Owner        = "Terraform"
  }
}