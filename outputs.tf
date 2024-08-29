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
  value       = ""
}

output "kms_key_alias" {
  description = "KMS key alias used for snapshot encryption"
  value       = ""
}
