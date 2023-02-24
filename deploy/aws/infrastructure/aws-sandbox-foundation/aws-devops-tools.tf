//create SG
resource "aws_security_group" "devops_tools" {
  name        = "${local.name_prefix}-devops-tools-sg"
  description = "Security group for the devops_tools instance"
  vpc_id      = module.aws_vpc_egress.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-devops-tools-sg"})

}

resource "aws_security_group_rule" "ingress_ssh_from_world" {
  description              = "Allow ssh"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "TCP"
  security_group_id        = aws_security_group.devops_tools.id
  cidr_blocks = "${var.inbound_cidrs}"
}

resource "aws_security_group_rule" "ingress_ssh_from_harness_delegate" {
  description              = "Allow ssh"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "TCP"
  security_group_id        = aws_security_group.devops_tools.id
  source_security_group_id = aws_security_group.harness_delegate.id
}

//create key pair
resource "aws_key_pair" "devops_tools_key" {
  key_name   = "devops-tools-key"
  public_key = file("${path.module}/public_keys/${var.devops_tools_public_key}")
}

// create linux ec2 instance
resource "aws_instance" "devops_tools" {
  ami           = var.devops_tools_ami
  instance_type = var.devops_tools_instance_type
  key_name      = aws_key_pair.devops_tools_key.key_name
  vpc_security_group_ids = ["${aws_security_group.devops_tools.id}"]
  subnet_id = module.aws_vpc_egress.public_subnets[1]
 
  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-devops-tools"})
}

resource "aws_eip_association" "linux_bastion_eip" {
  instance_id   = aws_instance.devops_tools.id
  allocation_id = data.terraform_remote_state.bastion_static_ips.outputs.linux-bastion-eip-id
}