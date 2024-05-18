output "ec2_arn" {
  value       = module.pritunl.arn
  description = "The ARN of the instance"
}

output "ec2_id" {
  value       = module.pritunl.id
  description = "The ID of the instance"
}

output "ec2_public_ip" {
  value       = module.pritunl.public_ip
  description = "The public IP address assigned to the instance"
}

output "ec2_private_ip" {
  value       = module.pritunl.private_ip
  description = "The private IP address assigned to the instance"
}
