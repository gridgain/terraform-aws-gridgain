locals {
  az_count = 2
  ami_id   = var.ami_id
  tags     = var.tags

  ssm_endpoints = ["ssm", "ssmmessages", "ec2messages"]
}

data "aws_region" "this" {}

resource "aws_key_pair" "this" {
  count      = var.ssh_public_key != "" ? 1 : 0
  key_name   = "${var.name}-ssh-key"
  public_key = var.ssh_public_key
}

resource "aws_instance" "this" {
  count = var.nodes_count

  ami           = local.ami_id
  instance_type = var.instance_type
  # user_data   = var.user_data

  availability_zone      = var.zones[count.index % local.az_count]
  subnet_id              = local.subnets[count.index % local.az_count]
  vpc_security_group_ids = [aws_security_group.this.id]

  key_name             = var.ssh_public_key != "" ? aws_key_pair.this[0].key_name : null
  monitoring           = true
  iam_instance_profile = aws_iam_instance_profile.this.name

  associate_public_ip_address = var.public_access_enable

  root_block_device {
    encrypted   = true
    kms_key_id  = local.kms_key_arn
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    throughput  = var.root_volume_throughput
    iops        = var.root_volume_iops

    delete_on_termination = var.root_volume_delete_on_termination
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
  }

  tags = merge({
    "Name" = "${var.name}-node-${count.index}",
  }, local.tags)
  volume_tags = merge({
    "Name" = "${var.name}-volume-${count.index}",
  }, local.tags)
}

resource "aws_vpc_endpoint" "this" {
  for_each = toset([
    for service in local.ssm_endpoints : service
    if var.ssm_enable
  ])

  vpc_id     = local.vpc_id
  subnet_ids = local.subnets

  security_group_ids = [
    aws_security_group.ssm[0].id,
  ]

  service_name      = "com.amazonaws.${data.aws_region.this.name}.${each.value}"
  vpc_endpoint_type = "Interface"

  private_dns_enabled = true

  tags = merge(var.tags, { Name = "${each.value} SSM Endpoint" })
}

resource "aws_security_group" "ssm" {
  count       = var.ssm_enable ? 1 : 0
  name_prefix = "ssm-vpc-endpoints-"
  description = "VPC endpoint security group"
  vpc_id      = local.vpc_id

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "sg_ingress_endpoints" {
  count             = var.ssm_enable ? 1 : 0
  description       = "ingress-tcp-443-from-subnets"
  security_group_id = aws_security_group.ssm[0].id
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = [var.vpc_cidr]
}

resource "aws_security_group_rule" "sg_egress" {
  count             = var.ssm_enable ? 1 : 0
  description       = "egress-tcp-443"
  security_group_id = aws_security_group.ssm[0].id
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}
