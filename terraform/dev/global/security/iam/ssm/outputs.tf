output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = module.iam_assumable_role.iam_role_arn
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = module.iam_assumable_role.iam_role_name
}

output "iam_policy_arn" {
  description = "ARN of IAM policy"
  value       = module.iam_policy.arn
}

output "iam_instance_profile_id" {
  description = "Instance profile ID"
  value       = module.iam_assumable_role.iam_instance_profile_id
}

