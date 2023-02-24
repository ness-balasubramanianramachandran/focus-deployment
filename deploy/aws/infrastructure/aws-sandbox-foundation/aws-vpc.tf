module "aws_vpc_egress" {

  create_vpc = var.create_vpc_egress
  source     = "terraform-aws-modules/vpc/aws"
  version    = "v3.2.0"

  name = "${local.name_prefix}-egress-vpc"
  cidr = var.vpc_cidr_egress
  azs  = data.aws_availability_zones.available.names

  # Private Subnets
  private_subnets     = var.enable_private_subnets_egress ? var.private_subnets_cidr_egress : []
  private_subnet_tags = var.enable_private_subnets_egress ? local.private_subnet_tags_egress : {}

  # Public Subnets
  public_subnets     = var.enable_public_subnets_egress ? var.public_subnets_cidr_egress : []
  public_subnet_tags = var.enable_public_subnets_egress ? local.public_subnet_tags_egress : {}

  enable_nat_gateway = var.enable_nat_gateway_egress ? var.enable_nat_gateway_egress : false
  single_nat_gateway = var.single_nat_gateway_egress ? var.single_nat_gateway_egress : false
  create_igw         = var.enable_public_subnets_egress && var.create_igw_egress ? var.create_igw_egress : false

  enable_vpn_gateway              = false
  create_egress_only_igw          = false
  create_database_subnet_group    = false
  create_elasticache_subnet_group = false
  create_redshift_subnet_group    = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  # Enabling Custom Domain name servers
  //  enable_dhcp_options              = true
  //  dhcp_options_domain_name         = "service.consul"
  //  dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = false
  create_flow_log_cloudwatch_log_group = false
  create_flow_log_cloudwatch_iam_role  = false
  flow_log_max_aggregation_interval    = 60

  manage_default_security_group = true
  manage_default_route_table = true

  default_security_group_name = "${local.name_prefix}-egress-vpc-default-sg"
  default_security_group_ingress = [
    {
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = var.vpc_cidr_egress
    },
    {
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = var.vpc_cidr
    },
    {
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = var.vpc_cidr_routable
    }
  ]
  default_security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"
  }]

  tags = local.default_tags

}

module "aws_vpc_non_routable" {

  create_vpc = var.create_vpc
  source     = "terraform-aws-modules/vpc/aws"
  version    = "v3.2.0"

  name = "${local.name_prefix}-nr-vpc"
  cidr = var.vpc_cidr
  azs  = data.aws_availability_zones.available.names

  # Private Subnets
  private_subnets     = var.enable_private_subnets ? var.private_subnets_cidr : []
  private_subnet_tags = var.enable_private_subnets ? local.private_subnet_tags : {}

  # Public Subnets
  public_subnets     = var.enable_public_subnets ? var.public_subnets_cidr : []
  public_subnet_tags = var.enable_public_subnets ? local.public_subnet_tags : {}

  enable_nat_gateway = var.enable_nat_gateway ? var.enable_nat_gateway : false
  single_nat_gateway = var.single_nat_gateway ? var.single_nat_gateway : false
  create_igw         = var.enable_public_subnets && var.create_igw ? var.create_igw : false

  enable_vpn_gateway              = false
  create_egress_only_igw          = false
  create_database_subnet_group    = false
  create_elasticache_subnet_group = false
  create_redshift_subnet_group    = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  # Enabling Custom Domain name servers
  //  enable_dhcp_options              = true
  //  dhcp_options_domain_name         = "service.consul"
  //  dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = false
  create_flow_log_cloudwatch_log_group = false
  create_flow_log_cloudwatch_iam_role  = false
  flow_log_max_aggregation_interval    = 60

  manage_default_security_group = true
  manage_default_route_table = true

  default_security_group_name = "${local.name_prefix}-nr-vpc-default-sg"
  default_security_group_ingress = [
    {
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = var.vpc_cidr
  }]
  default_security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"
  }]

  tags = local.default_tags

}

module "aws_vpc_routable" {

  create_vpc = var.create_vpc_routable
  source     = "terraform-aws-modules/vpc/aws"
  version    = "v3.2.0"

  name = "${local.name_prefix}-routable-vpc"
  cidr = var.vpc_cidr_routable
  azs  = data.aws_availability_zones.available.names

  # Private Subnets
  private_subnets     = var.enable_private_subnets_routable ? var.private_subnets_cidr_routable : []
  private_subnet_tags = var.enable_private_subnets_routable ? local.private_subnet_tags_routable : {}

  # Public Subnets
  public_subnets     = var.enable_public_subnets_routable ? var.public_subnets_cidr_routable : []
  public_subnet_tags = var.enable_public_subnets_routable ? local.public_subnet_tags_routable : {}

  enable_nat_gateway = var.enable_nat_gateway_routable ? var.enable_nat_gateway_routable : false
  single_nat_gateway = var.single_nat_gateway_routable ? var.single_nat_gateway_routable : false
  create_igw         = var.enable_public_subnets_routable && var.create_igw_routable ? var.create_igw_routable : false

  enable_vpn_gateway              = false
  create_egress_only_igw          = false
  create_database_subnet_group    = false
  create_elasticache_subnet_group = false
  create_redshift_subnet_group    = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  # Enabling Custom Domain name servers
  //  enable_dhcp_options              = true
  //  dhcp_options_domain_name         = "service.consul"
  //  dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = false
  create_flow_log_cloudwatch_log_group = false
  create_flow_log_cloudwatch_iam_role  = false
  flow_log_max_aggregation_interval    = 60

  manage_default_security_group = true
  manage_default_route_table = true

  default_security_group_name = "${local.name_prefix}-routable-vpc-default-sg"
  default_security_group_ingress = [
    {
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = var.vpc_cidr_routable
  }]
  default_security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"
  }]

  tags = local.default_tags

}

resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id   = module.aws_vpc_non_routable.vpc_id
  vpc_id        = module.aws_vpc_routable.vpc_id
  auto_accept   = true

  accepter {  
    # If enabled, the DNS hostname of an instance in the accepter VPC 
    # resolves to its private IP address when queried from instances in the requester VPC.
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    # If enabled, the DNS hostname of an instance in the requester VPC 
    # resolves to its private IP address when queried from instances in the accepter VPC.  
    allow_remote_vpc_dns_resolution = true
  }
  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-vpc-peering"})
}

resource "aws_route" "non-routable-to-routable" {
  route_table_id            = "${module.aws_vpc_non_routable.private_route_table_ids[0]}"
  destination_cidr_block    = "${module.aws_vpc_routable.vpc_cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peering.id}"
  depends_on                = [module.aws_vpc_non_routable,module.aws_vpc_routable,aws_vpc_peering_connection.vpc_peering]
}

resource "aws_route" "routable-to-non-routable" {
  route_table_id            = "${module.aws_vpc_routable.private_route_table_ids[0]}"
  destination_cidr_block    = "${module.aws_vpc_non_routable.vpc_cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peering.id}"
  depends_on                = [module.aws_vpc_non_routable,module.aws_vpc_routable,aws_vpc_peering_connection.vpc_peering]
}

resource "aws_route" "non-routable-to-egress" {
  route_table_id            = "${module.aws_vpc_non_routable.private_route_table_ids[0]}"
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = "${aws_ec2_transit_gateway.aws_tgw.id}"
  depends_on                = [module.aws_vpc_non_routable, aws_ec2_transit_gateway_vpc_attachment.non-routable-vpc]
}

resource "aws_route" "routable-to-egress" {
  route_table_id            = "${module.aws_vpc_routable.private_route_table_ids[0]}"
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = "${aws_ec2_transit_gateway.aws_tgw.id}"
  depends_on                = [module.aws_vpc_routable, aws_ec2_transit_gateway_vpc_attachment.routable-vpc]
}

resource "aws_route" "egress-to-routable" {
  route_table_id            = "${module.aws_vpc_egress.public_route_table_ids[0]}"
  destination_cidr_block    = "${module.aws_vpc_routable.vpc_cidr_block}"
  gateway_id = "${aws_ec2_transit_gateway.aws_tgw.id}"
  depends_on                = [module.aws_vpc_routable, aws_ec2_transit_gateway_vpc_attachment.egress-vpc]
}

resource "aws_route" "egress-to-non-routable" {
  route_table_id            = "${module.aws_vpc_egress.public_route_table_ids[0]}"
  destination_cidr_block    = "${module.aws_vpc_non_routable.vpc_cidr_block}"
  gateway_id = "${aws_ec2_transit_gateway.aws_tgw.id}"
  depends_on                = [module.aws_vpc_routable, aws_ec2_transit_gateway_vpc_attachment.egress-vpc]
}