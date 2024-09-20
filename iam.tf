data "aws_partition" "current" {}

data "aws_iam_policy_document" "assume-role" {
  statement {
    sid     = "EC2AssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

resource "aws_iam_role" "this" {
  name = "${var.name}-iam-role"

  assume_role_policy = data.aws_iam_policy_document.assume-role.json

  tags = merge(local.tags, {
    Name = "${var.name}-iam-role"
  })
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${local.s3_bucket}",
      "arn:aws:s3:::${local.s3_bucket}/*",
    ]
  }

  statement {
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyPair",
    ]
    resources = [
      local.kms_key_arn,
    ]
  }
}

resource "aws_iam_policy" "this" {
  name        = "${var.name}-s3-kms-iam-policy"
  description = "IAM Policy providing access to S3 and KMS for ${var.fullname}"
  policy      = data.aws_iam_policy_document.this.json

  tags = merge(local.tags, {
    Name        = "${var.name}-s3-kms-iam-policy",
    Description = "IAM Policy providing access to S3 and KMS for ${var.fullname}"
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_role_policy_attachment" "ssm" {
  count      = var.ssm_enable ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  count      = var.cloudwatch_logs_enable ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.name}-iam-profile"
  role = aws_iam_role.this.name

  tags = merge(local.tags, {
    Name        = "${var.name}-iam-profile",
    Description = "IAM InstanceProfile for ${var.fullname}"
  })

  lifecycle {
    create_before_destroy = true
  }
}
