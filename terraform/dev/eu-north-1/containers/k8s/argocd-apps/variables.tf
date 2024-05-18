variable "region" {
  description = "AWS Region for placing all resources"
  default     = "eu-north-1"
}

variable "config_path" {
  description = "Kubernetes config path (Path should be absolute)"
  default     = "~/.kube/config"
}
