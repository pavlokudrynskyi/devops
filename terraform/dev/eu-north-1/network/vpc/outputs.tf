output "azs" {
  value       = module.vpc.azs
  description = "A list of availability zones specified as argument to this module"
}

output "igw_arn" {
  value       = module.vpc.igw_arn
  description = "The ARN of the Internet Gateway"
}

output "igw_id" {
  value       = module.vpc.igw_id
  description = "The ID of the Internet Gateway"
}

output "intra_subnets" {
  value       = module.vpc.intra_subnets
  description = "List of IDs of intra subnets"
}

output "intra_subnet_arns" {
  value       = module.vpc.intra_subnet_arns
  description = "List of ARNs of intra subnets"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "List of IDs of private subnets"
}

output "private_subnets_cidr_blocks" {
  value       = slice(module.vpc.private_subnets_cidr_blocks, 0, 3)
  description = "List of CIDRs of private subnets"
}

output "k8s_subnets_cidr_blocks" {
  value       = slice(module.vpc.private_subnets_cidr_blocks, 0, 3)
  description = "List of CIDRs of kubernetes subnets"
}

output "private_subnet_arns" {
  value       = module.vpc.private_subnet_arns
  description = "List of ARNs of private subnets"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "List of IDs of public subnets"
}

output "public_subnet_arns" {
  value       = module.vpc.public_subnet_arns
  description = "List of ARNs of public subnets"
}

output "private_route_tables_ids" {
  value       = module.vpc.private_route_table_ids
  description = "Route tables IDs for private subnets"
}

output "vpc_arn" {
  value       = module.vpc.vpc_arn
  description = "The ARN of the VPC"
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "The CIDR block of the VPC"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}
