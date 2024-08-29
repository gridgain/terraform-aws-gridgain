variable "vpc_id" {
  description = "VPC ID to be deployed into. If empty, module should provision new VPC"
  type        = string
  default     = ""
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to be used for deployment. If empty, module should provision new subnets"
  type        = list(string)
  default     = []
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to be used for deployment. If empty and public access enabled, module should provision new subnets"
  type        = list(string)
  default     = []
}

variable "public_access_enable" {
  description = "Whether cluster should be publicly accessible or not"
  type        = bool
  default     = false
}

variable "public_allowlist" {
  description = "List of CIDRs to be allowed in securitygroup for public access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ports" {
  description = "List of ports to be allowed in securitygroup"
  type        = list(string)
  default     = ["22", "8080", "10800", "10900", "11211", "47100", "47500", "49112"]
}

variable "s3_bucket" {
  description = "Name of s3 bucket to use. If empty, module will create a new one"
  type        = string
  default     = ""
}

variable "kms_key_alias" {
  description = "KMS Key alias to be used with S3 bucket for encryption. If empty, module will create a new one"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Instance type to be used for GridGain nodes"
  type        = string
  default     = "t3.micro"
}

variable "root_volume_size" {
  description = "Size of root volume in GB for GridGain nodes"
  type        = number
  default     = 50
}

variable "nodes_count" {
  description = "Number of nodes"
  type        = number
  default     = 2
}

variable "ami_id" {
  description = "AMI to be provisioned, if empty, should default to latest"
  type        = string
  default     = ""
}

variable "gridgain_version" {
  description = "GridGain version to use when searching for AMI"
  type        = string
  default     = "8.9.9"
}

variable "fullname" {
  description = "Full name to be used in description of all resources"
  type        = string
  default     = "GridGain Cluster"
}

variable "name" {
  description = "Name prefix to be used for all resources"
  type        = string
  default     = "gridgain"
}

variable "tags" {
  description = "A map of additional tags to assign to resources"
  type        = map(string)
  default     = {}
}
