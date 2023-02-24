resource "aws_security_group" "super_bastion" {
  name        = "${local.name_prefix}-super-bastion-sg"
  description = "Security group for the super-bastion instance"
  vpc_id      = module.aws_vpc_egress.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-super-bastion-sg"})

}

resource "aws_security_group_rule" "super_bastion_ingress_RDP" {
  description              = "Allow RDP"
  type                     = "ingress"
  from_port                = 3389
  to_port                  = 3389
  protocol                 = "TCP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = "${var.inbound_cidrs}"
}

// open domain controller inbound ports for routable VPC: https://docs.microsoft.com/en-us/troubleshoot/windows-server/identity/config-firewall-for-ad-domains-and-trusts

resource "aws_security_group_rule" "super_bastion_ingress_w32time" {
  description              = "W32Time"
  type                     = "ingress"
  from_port                = 123
  to_port                  = 123
  protocol                 = "UDP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_rpcmapper" {
  description              = "RPC Endpoint Mapper"
  type                     = "ingress"
  from_port                = 135
  to_port                  = 135
  protocol                 = "TCP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_kerberos_pwd" {
  description              = "Kerberos password change/TCP"
  type                     = "ingress"
  from_port                = 464
  to_port                  = 464
  protocol                 = "TCP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_kerberos_pwd_udp" {
  description              = "Kerberos password change/UDP"
  type                     = "ingress"
  from_port                = 464
  to_port                  = 464
  protocol                 = "UDP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_rpc" {
  description              = "RPC for LSA, SAM, NetLogon"
  type                     = "ingress"
  from_port                = 49152
  to_port                  = 65535
  protocol                 = "TCP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_ldap" {
  description              = "LDAP/TCP"
  type                     = "ingress"
  from_port                = 389
  to_port                  = 389
  protocol                 = "TCP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_ldap_udp" {
  description              = "LDAP/UDP"
  type                     = "ingress"
  from_port                = 389
  to_port                  = 389
  protocol                 = "UDP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_ldapgc" {
  description              = "LDAP GC"
  type                     = "ingress"
  from_port                = 3268
  to_port                  = 3268
  protocol                 = "TCP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_dns" {
  description              = "DNS/TCP"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "TCP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_dns_udp" {
  description              = "DNS/UDP"
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "UDP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_kerberos" {
  description              = "Kerberos/TCP"
  type                     = "ingress"
  from_port                = 88
  to_port                  = 88
  protocol                 = "TCP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_kerberos_udp" {
  description              = "Kerberos/UDP"
  type                     = "ingress"
  from_port                = 88
  to_port                  = 88
  protocol                 = "UDP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

resource "aws_security_group_rule" "super_bastion_ingress_smb" {
  description              = "SMB"
  type                     = "ingress"
  from_port                = 445
  to_port                  = 445
  protocol                 = "TCP"
  security_group_id        = aws_security_group.super_bastion.id
  cidr_blocks = tolist([var.vpc_cidr_routable])
}

// end of domain controller inbound ports///////////////////////////////////////////////////

resource "aws_key_pair" "super_bastion_key" {
  key_name   = "super-bastion-key"
  public_key = file("${path.module}/public_keys/${var.super_bastion_public_key}")
}

resource "aws_instance" "windows_super_bastion" {
  ami           = var.windows_super_bastion_ami
  instance_type = var.windows_super_bastion_instance_type
  key_name      = aws_key_pair.super_bastion_key.key_name
  //user_data_base64 = local.userdata_base64
  vpc_security_group_ids = ["${aws_security_group.super_bastion.id}"]
  subnet_id = module.aws_vpc_egress.public_subnets[0]
 
  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-super-bastion"})
}

resource "aws_eip_association" "windows_bastion_eip" {
  instance_id   = aws_instance.windows_super_bastion.id
  allocation_id = data.terraform_remote_state.bastion_static_ips.outputs.windows-bastion-eip-id
}

// create and assign DHCP option set for the routable VPC

resource "aws_vpc_dhcp_options" "sandbox-dc" {
  domain_name          = var.sandbox_domain
  domain_name_servers  = [data.aws_instances.super-bastion.private_ips[0]]
  
  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-sandbox-dc"})
}

resource "aws_vpc_dhcp_options_association" "sandbox-dc" {
  vpc_id          = module.aws_vpc_routable.vpc_id
  dhcp_options_id = aws_vpc_dhcp_options.sandbox-dc.id
}

