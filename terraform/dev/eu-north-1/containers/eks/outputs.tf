output "cloudwatch_log_group_arn" {
  value       = module.eks.cloudwatch_log_group_arn
  description = "Arn of cloudwatch log group created"
}

output "cloudwatch_log_group_name" {
  value       = module.eks.cloudwatch_log_group_name
  description = "Name of cloudwatch log group created"
}

output "cluster_arn" {
  value       = module.eks.cluster_arn
  description = "The Amazon Resource Name (ARN) of the cluster"
}

output "cluster_certificate_authority_data" {
  value       = module.eks.cluster_certificate_authority_data
  description = "Nested attribute containing certificate-authority-data for your cluster"
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint for your EKS Kubernetes API."
}

output "cluster_iam_role_arn" {
  value       = module.eks.cluster_iam_role_arn
  description = "IAM role ARN of the EKS cluster"
}

output "cluster_iam_role_name" {
  value       = module.eks.cluster_iam_role_name
  description = "IAM role name of the EKS cluster"
}

output "cluster_id" {
  value       = module.eks.cluster_id
  description = "The name/id of the EKS cluster"
}

output "cluster_oidc_issuer_url" {
  value       = module.eks.cluster_oidc_issuer_url
  description = "The URL on the EKS cluster OIDC Issuer"
}

output "cluster_primary_security_group_id" {
  value       = module.eks.cluster_primary_security_group_id
  description = "The cluster primary security group ID created by the EKS cluster on 1.14 or later"
}

output "cluster_security_group_id" {
  value       = module.eks.cluster_security_group_id
  description = "Security group ID attached to the EKS cluster"
}

output "node_groups" {
  value       = module.eks.eks_managed_node_groups
  description = "Outputs from EKS node groups"
}

output "oidc_provider_arn" {
  value       = module.eks.oidc_provider_arn
  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
}

output "alb_controller_iam_role_arn" {
  value       = aws_iam_role.alb-controller.arn
  description = "IAM role arn for alb controller"
}
