// IAM instance profile 
data "aws_iam_policy_document" "harness_delegate_assume_role_policy" {
  statement {
    sid = "HarnessDelegateAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

#data "aws_iam_policy_document" "bastion-s3-access" {
#  statement {
#    sid       = "ListBucket"
#    effect    = "Allow"
#    resources = ["arn:aws:s3:::${aws_s3_bucket.upload.id}"]
#
#    actions = [
#      "s3:ListBucket"
#    ]
#  }
#
#  statement {
#    sid       = "ReadWriteObjects"
#    effect    = "Allow"
#    resources = ["arn:aws:s3:::${aws_s3_bucket.upload.id}/*"]
#
#    actions = [
#        "s3:PutObject",
#        "s3:GetObject",
#        "s3:DeleteObject"
#    ]
#  }
#}

resource "aws_iam_role" "harness_delegate" {
  name               = "${local.name_prefix}-harness-role"
  assume_role_policy = data.aws_iam_policy_document.harness_delegate_assume_role_policy.json
  //path                  = var.path
  force_detach_policies = true
  tags                  = local.default_tags
}

resource "aws_iam_instance_profile" "harness_delegate_instance_profile" {
  name = "${local.name_prefix}-harness-profile"
  role = aws_iam_role.harness_delegate.name

  tags = local.default_tags

  lifecycle {
    create_before_destroy = true
  }
}

#resource "aws_iam_policy" "bastion_s3_access" {
#  name        = "${local.name_prefix}-bastion-s3"
#  description = "IAM policy for bastion instance access to S3"
#  //path        = var.path
#  policy      = data.aws_iam_policy_document.bastion-s3-access.json
#}

resource "aws_iam_role_policy_attachment" "ec2-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.harness_delegate.name
}

resource "aws_iam_role_policy_attachment" "s3-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.harness_delegate.name
}

//Security group

resource "aws_security_group" "harness_delegate" {
  name        = "${local.name_prefix}-harness-sg"
  description = "Security group for the Harness delegate instance"
  vpc_id      = module.aws_vpc_egress.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, { "Name" = "${local.name_prefix}-harness" })

}

resource "aws_security_group_rule" "harness_delegate_ssh" {
  description       = "Allow SSH"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  security_group_id = aws_security_group.harness_delegate.id
  cidr_blocks       = [module.aws_vpc_egress.vpc_cidr_block]
}

//create key pair
resource "aws_key_pair" "harness_delegate_key" {
  key_name   = "harness-delegate-key"
  public_key = file("${path.module}/public_keys/${var.harness_delegate_public_key}")
}

// create linux ec2 instance
#resource "aws_instance" "harness_delegate" {
#  ami           = var.harness_delegate_ami
#  instance_type = var.harness_delegate_instance_type
#  key_name      = aws_key_pair.harness_delegate_key.key_name
#  user_data_base64 = local.harness_userdata_base64
#  vpc_security_group_ids = ["${aws_security_group.harness_delegate.id}"]
#  subnet_id = module.aws_vpc_egress.private_subnets[0]
#  iam_instance_profile = aws_iam_instance_profile.harness_delegate_instance_profile.name
# 
#  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-harness-delegate"})
#}
