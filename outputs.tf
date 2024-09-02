output "vpc_id" {
  description = "ID of a VPC used for GridGain nodes"
  value       = local.vpc_id
}

output "private_subnet_ids" {
  description = "List of private subent IDs"
  value       = local.private_subnets
}

output "public_subnet_ids" {
  description = "List of public subent IDs"
  value       = local.public_subnets
}

output "domains" {
  description = "List of aws-provided domains for GridGain nodes"
  value       = []
}

output "private_ips" {
  description = "List of private IPs of GridGain nodes"
  value       = []
}

output "public_ips" {
  description = "List of public IPs of GridGain nodes"
  value       = []
}

output "s3_bucket" {
  description = "Name of S3 bucket used for snapshots"
  value       = local.s3_bucket
}

output "kms_key_alias" {
  description = "KMS key alias used for snapshot encryption"
  value       = ""
}
