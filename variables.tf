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

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  description = "List of 2 CIDRs for private subnets. Only 2 are supported"
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19"]
}

variable "public_subnet_cidrs" {
  description = "List of 2 CIDRs for public subnets. Only 2 are supported"
  type        = list(string)
  default     = ["10.0.144.0/20", "10.0.128.0/20"]
}

variable "zones" {
  description = "List of 2 availability zones to create VPC in. Only 2 are supported"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
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

variable "root_volume_type" {
  description = "Type of root volume for GridGain nodes"
  type        = string
  default     = "gp2"
}

variable "root_volume_throughput" {
  description = "Root volume throughput in MB/s"
  type = number
  default = null
}

variable "root_volume_iops" {
  description = "Amount of provisioned IOPS for root volume"
  type = number
  default = null
}

variable "root_volume_delete_on_termination" {
  description = "Whether the volume should be destroyed on GridGain nodes termination"
  type = bool
  default = true
}

variable "nodes_count" {
  description = "Number of nodes"
  type        = number
  default     = 2
}

variable "ami_id" {
  description = "AMI to be used in deployment, if empty, should default to latest"
  type        = string
  # default     = ""
}

# variable "gridgain_version" {
#   description = "GridGain version to use when searching for AMI"
#   type        = string
#   default     = "8.9.9"
# }

variable "ssh_public_key" {
  description = "SSH public key used to connect to instances. If empty, none will be provisioned"
  type        = string
  default     = ""
}

variable "enable_ssm" {
  description = "Enable secure session manager"
  type        = bool
  default     = true
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
