output "bucket_arn" {
  value       = module.infrastructure.s3_bucket_arn
  description = "Bucket ARN"
}

output "bucket_name" {
  value       = module.infrastructure.s3_bucket_id
  description = "Bucket name"
}