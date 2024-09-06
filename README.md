# Terraform for GridGain on AWS

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.65.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI to be used in deployment, if empty, should default to latest | `string` | n/a | yes |
| <a name="input_fullname"></a> [fullname](#input\_fullname) | Full name to be used in description of all resources | `string` | `"GridGain Cluster"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to be used for GridGain nodes | `string` | `"t3.micro"` | no |
| <a name="input_kms_key_alias"></a> [kms\_key\_alias](#input\_kms\_key\_alias) | KMS Key alias to be used with S3 bucket for encryption. If empty, module will create a new one | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix to be used for all resources | `string` | `"gridgain"` | no |
| <a name="input_nodes_count"></a> [nodes\_count](#input\_nodes\_count) | Number of nodes | `number` | `2` | no |
| <a name="input_ports"></a> [ports](#input\_ports) | List of ports to be allowed in securitygroup | `list(string)` | <pre>[<br>  "22",<br>  "8080",<br>  "10800",<br>  "10900",<br>  "11211",<br>  "47100",<br>  "47500",<br>  "49112"<br>]</pre> | no |
| <a name="input_public_access_enable"></a> [public\_access\_enable](#input\_public\_access\_enable) | Whether cluster should be publicly accessible or not | `bool` | `false` | no |
| <a name="input_public_allowlist"></a> [public\_allowlist](#input\_public\_allowlist) | List of CIDRs to be allowed in securitygroup for public access | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_root_volume_delete_on_termination"></a> [root\_volume\_delete\_on\_termination](#input\_root\_volume\_delete\_on\_termination) | Whether the volume should be destroyed on GridGain nodes termination | `bool` | `true` | no |
| <a name="input_root_volume_iops"></a> [root\_volume\_iops](#input\_root\_volume\_iops) | Amount of provisioned IOPS for root volume | `number` | `null` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Size of root volume in GB for GridGain nodes | `number` | `50` | no |
| <a name="input_root_volume_throughput"></a> [root\_volume\_throughput](#input\_root\_volume\_throughput) | Root volume throughput in MB/s | `number` | `null` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | Type of root volume for GridGain nodes | `string` | `"gp2"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | Name of s3 bucket to use. If empty, module will create a new one | `string` | `""` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key used to connect to instances. If empty, none will be provisioned | `string` | `""` | no |
| <a name="input_ssm_enable"></a> [ssm\_enable](#input\_ssm\_enable) | Enable secure session manager | `bool` | `true` | no |
| <a name="input_subnet_cidrs"></a> [subnet\_cidrs](#input\_subnet\_cidrs) | List of 2 CIDRs for private subnets. Only 2 are supported | `list(string)` | <pre>[<br>  "10.0.0.0/19",<br>  "10.0.32.0/19"<br>]</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of private subnet IDs to be used for deployment. If empty, module should provision new subnets | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to assign to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to be deployed into. If empty, module should provision new VPC | `string` | `""` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | List of 2 availability zones to create VPC in. Only 2 are supported | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_alias"></a> [kms\_key\_alias](#output\_kms\_key\_alias) | KMS key alias used for snapshot encryption |
| <a name="output_private_domains"></a> [private\_domains](#output\_private\_domains) | List of aws-provided private domains for GridGain nodes |
| <a name="output_private_ips"></a> [private\_ips](#output\_private\_ips) | List of private IPs of GridGain nodes |
| <a name="output_public_domains"></a> [public\_domains](#output\_public\_domains) | List of aws-provided public domains for GridGain nodes |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | List of public IPs of GridGain nodes |
| <a name="output_s3_bucket"></a> [s3\_bucket](#output\_s3\_bucket) | Name of S3 bucket used for snapshots |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | List of private subent IDs |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of a VPC used for GridGain nodes |
<!-- END_TF_DOCS -->
