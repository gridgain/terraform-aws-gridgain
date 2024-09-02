locals {
  asg_name        = "${var.name}-nodes-asg"
  asg_description = "${var.fullname} nodes ASG"
  ami_id          = var.ami_id
  tags            = var.tags
}

module "gridgain-nodes-asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = local.asg_name

  min_size                  = var.nodes_count
  max_size                  = var.nodes_count
  desired_capacity          = var.nodes_count
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = local.private_subnets

  # Launch template
  launch_template_name        = local.asg_name
  launch_template_description = local.asg_description
  update_default_version      = true

  image_id          = local.ami_id
  instance_type     = var.instance_type
  ebs_optimized     = true
  enable_monitoring = true

  # IAM role & instance profile
  create_iam_instance_profile = true
  iam_role_name               = "example-asg"
  iam_role_path               = "/ec2/"
  iam_role_description        = "IAM role example"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = var.root_volume_size
        volume_type           = "gp2"
      }
    }
  ]

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = [aws_security_group.this.id]
    }
  ]

  tag_specifications = [
    {
      resource_type = "instance"
      tags          = { WhatAmI = "Instance" }
    },
    {
      resource_type = "volume"
      tags          = { WhatAmI = "Volume" }
    }
  ]

  tags = local.tags
}
