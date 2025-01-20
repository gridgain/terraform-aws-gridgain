# Terraform for GridGain on AWS

This module provisions GridGain cluster on AWS using [GridGain Community Edition AMI](https://aws.amazon.com/marketplace/pp?sku=2c02ofzai3wyfom4z7c8uwemx).

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.65.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI to be used in deployment, if empty, should default to latest | `string` | n/a | yes |
| <a name="input_cloudwatch_logs_enable"></a> [cloudwatch\_logs\_enable](#input\_cloudwatch\_logs\_enable) | Enable sending logs to Cloudwatch Logs | `bool` | `false` | no |
| <a name="input_fullname"></a> [fullname](#input\_fullname) | Full name to be used in description of all resources | `string` | `"GridGain Cluster"` | no |
| <a name="input_gridgain_config"></a> [gridgain\_config](#input\_gridgain\_config) | GridGain config xml | `string` | `""` | no |
| <a name="input_gridgain_jetty_config"></a> [gridgain\_jetty\_config](#input\_gridgain\_jetty\_config) | GridGain Jetty config xml | `string` | `""` | no |
| <a name="input_gridgain_license"></a> [gridgain\_license](#input\_gridgain\_license) | GridGain license xml | `string` | `""` | no |
| <a name="input_gridgain_ssl_cert"></a> [gridgain\_ssl\_cert](#input\_gridgain\_ssl\_cert) | GridGain SSL certificate | `string` | `""` | no |
| <a name="input_gridgain_ssl_key"></a> [gridgain\_ssl\_key](#input\_gridgain\_ssl\_key) | GridGain SSL key | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to be used for GridGain nodes | `string` | `"t3.medium"` | no |
| <a name="input_keystore_password"></a> [keystore\_password](#input\_keystore\_password) | SSL Keystore password | `string` | `""` | no |
| <a name="input_kms_key_alias"></a> [kms\_key\_alias](#input\_kms\_key\_alias) | KMS Key alias to be used with S3 bucket for encryption. If empty, module will create a new one | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix to be used for all resources | `string` | `"gridgain"` | no |
| <a name="input_nodes_count"></a> [nodes\_count](#input\_nodes\_count) | Number of nodes | `number` | `2` | no |
| <a name="input_ports"></a> [ports](#input\_ports) | List of ports to be allowed in securitygroup | `list(string)` | <pre>[<br>  "22",<br>  "8080",<br>  "10800",<br>  "10900",<br>  "11211",<br>  "47100",<br>  "47500",<br>  "49112"<br>]</pre> | no |
| <a name="input_public_access_enable"></a> [public\_access\_enable](#input\_public\_access\_enable) | Whether cluster should be publicly accessible or not | `bool` | `false` | no |
| <a name="input_public_allowlist"></a> [public\_allowlist](#input\_public\_allowlist) | List of CIDRs to be allowed in securitygroup for public access | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_root_volume_delete_on_termination"></a> [root\_volume\_delete\_on\_termination](#input\_root\_volume\_delete\_on\_termination) | Whether the volume should be destroyed on GridGain nodes termination | `bool` | `true` | no |
| <a name="input_root_volume_iops"></a> [root\_volume\_iops](#input\_root\_volume\_iops) | Amount of provisioned IOPS for root volume | `number` | `null` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Size of root volume in GB for GridGain nodes | `number` | `128` | no |
| <a name="input_root_volume_throughput"></a> [root\_volume\_throughput](#input\_root\_volume\_throughput) | Root volume throughput in MB/s | `number` | `null` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | Type of root volume for GridGain nodes | `string` | `"gp3"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | Name of s3 bucket to use. If empty, module will create a new one | `string` | `""` | no |
| <a name="input_s3_enable"></a> [s3\_enable](#input\_s3\_enable) | Whether to enable S3 bucket for snapshots | `bool` | `false` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key used to connect to instances. If empty, none will be provisioned | `string` | `""` | no |
| <a name="input_ssl_enable"></a> [ssl\_enable](#input\_ssl\_enable) | Whether SSL should be enabled | `bool` | `false` | no |
| <a name="input_ssm_enable"></a> [ssm\_enable](#input\_ssm\_enable) | Enable secure session manager | `bool` | `true` | no |
| <a name="input_subnet_cidrs"></a> [subnet\_cidrs](#input\_subnet\_cidrs) | List of CIDRs for private subnets | `list(string)` | <pre>[<br>  "10.0.0.0/19",<br>  "10.0.32.0/19"<br>]</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of private subnet IDs to be used for deployment. If empty, module should provision new subnets | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to assign to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to be deployed into. If empty, module should provision new VPC | `string` | `""` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | List of availability zones to create VPC in | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami"></a> [ami](#output\_ami) | AMI ID that was used to create the instances |
| <a name="output_availability_zone"></a> [availability\_zone](#output\_availability\_zone) | The availability zone of the created instances |
| <a name="output_iam_instance_profile_arn"></a> [iam\_instance\_profile\_arn](#output\_iam\_instance\_profile\_arn) | ARN assigned by AWS to the instance profile |
| <a name="output_iam_instance_profile_id"></a> [iam\_instance\_profile\_id](#output\_iam\_instance\_profile\_id) | Instance profile's ID |
| <a name="output_iam_instance_profile_unique"></a> [iam\_instance\_profile\_unique](#output\_iam\_instance\_profile\_unique) | Stable and unique string identifying the IAM instance profile |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The name of the IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_instance_ids"></a> [instance\_ids](#output\_instance\_ids) | List of EC2 instance IDs |
| <a name="output_instance_state"></a> [instance\_state](#output\_instance\_state) | List of instance states |
| <a name="output_ipv6_addresses"></a> [ipv6\_addresses](#output\_ipv6\_addresses) | List of IPv6 addresses assigned to the instances, if applicable |
| <a name="output_isntance_arns"></a> [isntance\_arns](#output\_isntance\_arns) | List of ARNs assigned to the instances |
| <a name="output_kms_key_alias"></a> [kms\_key\_alias](#output\_kms\_key\_alias) | KMS key alias used for snapshot encryption |
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | ARN of the load balancer |
| <a name="output_lb_dns"></a> [lb\_dns](#output\_lb\_dns) | DNS name of the load balancer |
| <a name="output_primary_network_interface_ids"></a> [primary\_network\_interface\_ids](#output\_primary\_network\_interface\_ids) | List of primary network interface IDs |
| <a name="output_private_dns"></a> [private\_dns](#output\_private\_dns) | List of private DNS names assigned to the instances |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | List of private IP addresses assigned to the instances |
| <a name="output_public_dns"></a> [public\_dns](#output\_public\_dns) | List of public DNS names assigned to the instances |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | List of public IP addresses assigned to the instances |
| <a name="output_s3_bucket"></a> [s3\_bucket](#output\_s3\_bucket) | Name of S3 bucket used for snapshots |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group used for GridGain nodes |
| <a name="output_ssm_connect_commands"></a> [ssm\_connect\_commands](#output\_ssm\_connect\_commands) | The AWS CLI command to connect to the instance using Session Manager |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | List of private subent IDs |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resources, including those inherited from the provider default\_tags configuration block |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of a VPC used for GridGain nodes |
<!-- END_TF_DOCS -->
