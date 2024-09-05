locals {
  az_count = 2
  ami_id   = var.ami_id
  tags     = var.tags
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
