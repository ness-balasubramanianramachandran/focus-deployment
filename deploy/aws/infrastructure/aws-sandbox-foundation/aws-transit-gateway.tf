resource "aws_ec2_transit_gateway" "aws_tgw" {
  description = "Transit gateway that connects non-routable and routable VPCs to the egress VPC (reflecting the SDL setup in Sandbox)"
  auto_accept_shared_attachments = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-tgw"})
  
}

resource "aws_ec2_transit_gateway_vpc_attachment" "egress-vpc" {
  subnet_ids         = "${module.aws_vpc_egress.private_subnets}"
  transit_gateway_id = aws_ec2_transit_gateway.aws_tgw.id
  vpc_id             = module.aws_vpc_egress.vpc_id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-egress-vpc"})
}

resource "aws_ec2_transit_gateway_vpc_attachment" "routable-vpc" {
  subnet_ids         = "${module.aws_vpc_routable.private_subnets}"
  transit_gateway_id = aws_ec2_transit_gateway.aws_tgw.id
  vpc_id             = module.aws_vpc_routable.vpc_id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-routable-vpc"})
}

resource "aws_ec2_transit_gateway_vpc_attachment" "non-routable-vpc" {
  subnet_ids         = "${module.aws_vpc_non_routable.private_subnets}"
  transit_gateway_id = aws_ec2_transit_gateway.aws_tgw.id
  vpc_id             = module.aws_vpc_non_routable.vpc_id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-non-routable-vpc"})
}

resource "aws_ec2_transit_gateway_route_table" "inbound" {
  transit_gateway_id = aws_ec2_transit_gateway.aws_tgw.id
  
  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-inbound"})
}

resource "aws_ec2_transit_gateway_route" "inbound-routable" {
  destination_cidr_block         = "${module.aws_vpc_routable.vpc_cidr_block}"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.routable-vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inbound.id
}

//without this route there is no internet connectivity from non-routable subnet (e.g.: can't do 'yum install...')
resource "aws_ec2_transit_gateway_route" "inbound-non-routable" {
  destination_cidr_block         = "${module.aws_vpc_non_routable.vpc_cidr_block}"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.non-routable-vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inbound.id
}

resource "aws_ec2_transit_gateway_route_table" "outbound" {
  transit_gateway_id = aws_ec2_transit_gateway.aws_tgw.id
  
  tags = merge(local.default_tags,{"Name" = "${local.name_prefix}-outbound"})
}

resource "aws_ec2_transit_gateway_route" "outbound-internet" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.egress-vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.outbound.id
}

//resource "aws_ec2_transit_gateway_route" "blackhole192" {
//  destination_cidr_block         = "192.168.0.0/16"
//  blackhole = true
//  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.outbound.id
//}
//
//resource "aws_ec2_transit_gateway_route" "blackhole172" {
//  destination_cidr_block         = "172.16.0.0/12"
//  blackhole = true
//  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.outbound.id
//}
//
//resource "aws_ec2_transit_gateway_route" "blackhole10" {
//  destination_cidr_block         = "10.0.0.0/8"
//  blackhole = true
//  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.outbound.id
//}

resource "aws_ec2_transit_gateway_route_table_association" "routable" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.routable-vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.outbound.id
}

resource "aws_ec2_transit_gateway_route_table_association" "non-routable" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.non-routable-vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.outbound.id
}

resource "aws_ec2_transit_gateway_route_table_association" "egress" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.egress-vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.inbound.id
}