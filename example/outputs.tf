output "private_domains" {
  description = "private_domains"
  value       = module.ec2_instance.private_domains
}

output "public_domains" {
  description = "public_domains"
  value       = module.ec2_instance.public_domains
}

output "private_ips" {
  description = "private_ips"
  value       = module.ec2_instance.private_ips
}

output "public_ips" {
  description = "public_ips"
  value       = module.ec2_instance.public_ips
}
