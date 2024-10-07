output "vpc_id" {
  description = "ID of a VPC used for GridGain nodes"
  value       = local.vpc_id
}

output "subnet_ids" {
  description = "List of private subent IDs"
  value       = local.subnets
}

output "private_domains" {
  description = "List of aws-provided private domains for GridGain nodes"
  value       = aws_instance.this.*.private_dns
}

output "public_domains" {
  description = "List of aws-provided public domains for GridGain nodes"
  value       = aws_instance.this.*.public_dns
}

output "private_ips" {
  description = "List of private IPs of GridGain nodes"
  value       = local.private_ips
}

output "public_ips" {
  description = "List of public IPs of GridGain nodes"
  value       = local.public_ips
}

output "s3_bucket" {
  description = "Name of S3 bucket used for snapshots"
  value       = local.s3_bucket
}

output "kms_key_alias" {
  description = "KMS key alias used for snapshot encryption"
  value       = ""
}
