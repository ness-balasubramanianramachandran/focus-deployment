/*** FIS default Tags ***/
variable "buc" {
  description = "The Business Unit Code associated with the group responsible for the deployed asset."
  default     = "4010.523420.0000..0000.0000.0000"
}

variable "support_group" {
  description = "The name of the group responsible for the deployed asset."
  default     = "Ambit Operations"
}

variable "app_group_email" {
  description = "The email address for the operations team responsible for the deployed asset."
  default     = "Ambit.Ops.Support@fisglobal.com"
}

variable "environment_type" {
  description = "The tier of environment for the application -- this is separate from the service level defined at the subscription level."
  default     = "Dev"
}

variable "customer_crmid" {
  description = "The end customer of the system and the CRM ID of the end customer of the system."
  default     = ""
}

variable "org" {
  type        = string
  description = "your organization name, e.g. arp"
  default     = "arp"
}

variable "terraform_version" {
  type        = string
  default     = "Terraform"
  description = "Terraform Version"
}

variable "zone" {
  type        = string
  description = "e.g. 'sandbox', 'sdl', 'production'"
}

variable "application" {
  type        = string
  description = "Application name"
  default     = "focus"
}


/*** VPC variables ***/

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = false
}

variable "enable_public_subnets" {
  description = "Enable public subnets for EKS Cluster"
  type        = bool
  default     = false
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for public subnets"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Create single NAT gateway for all private subnets"
  type        = bool
  default     = true
}

variable "create_igw" {
  description = "Create internet gateway in public subnets"
  type        = bool
  default     = false
}

variable "enable_private_subnets" {
  description = "Enable private subnets for EKS Cluster"
  type        = bool
  default     = true
}

variable "vpc_cidr" {
  type        = string
  default     = ""
  description = "VPC CIDR"
}

variable "public_subnets_cidr" {
  description = "list of Public subnets for the Worker nodes"
  default     = []
}

variable "private_subnets_cidr" {
  description = "list of Private subnets for the Worker nodes"
  default     = []
}

/*** Routable VPC variables ***/

variable "create_vpc_routable" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = false
}

variable "enable_public_subnets_routable" {
  description = "Enable public subnets for EKS Cluster"
  type        = bool
  default     = false
}

variable "enable_nat_gateway_routable" {
  description = "Enable NAT Gateway for public subnets"
  type        = bool
  default     = false
}

variable "single_nat_gateway_routable" {
  description = "Create single NAT gateway for all private subnets"
  type        = bool
  default     = true
}

variable "create_igw_routable" {
  description = "Create internet gateway in public subnets"
  type        = bool
  default     = false
}

variable "enable_private_subnets_routable" {
  description = "Enable private subnets for EKS Cluster"
  type        = bool
  default     = true
}

variable "vpc_cidr_routable" {
  type        = string
  default     = ""
  description = "VPC CIDR"
}

variable "public_subnets_cidr_routable" {
  description = "list of Public subnets for the Worker nodes"
  default     = []
}

variable "private_subnets_cidr_routable" {
  description = "list of Private subnets for the Worker nodes"
  default     = []
}

/*** Egress VPC variables ***/

variable "create_vpc_egress" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = false
}

variable "enable_public_subnets_egress" {
  description = "Enable public subnets for EKS Cluster"
  type        = bool
  default     = false
}

variable "enable_nat_gateway_egress" {
  description = "Enable NAT Gateway for public subnets"
  type        = bool
  default     = false
}

variable "single_nat_gateway_egress" {
  description = "Create single NAT gateway for all private subnets"
  type        = bool
  default     = true
}

variable "create_igw_egress" {
  description = "Create internet gateway in public subnets"
  type        = bool
  default     = false
}

variable "enable_private_subnets_egress" {
  description = "Enable private subnets for EKS Cluster"
  type        = bool
  default     = true
}

variable "vpc_cidr_egress" {
  type        = string
  default     = ""
  description = "VPC CIDR"
}

variable "public_subnets_cidr_egress" {
  description = "list of Public subnets for the Worker nodes"
  default     = []
}

variable "private_subnets_cidr_egress" {
  description = "list of Private subnets for the Worker nodes"
  default     = []
}

variable "inbound_cidrs" {
  description = "allow inbound access to super-bastion and devops_tools hosts from these CIDR blocks"
  default = []
}

/*** super-bastion variables ***/
variable "windows_super_bastion_ami" {
  description = "AMI for the Windows super-bastion"
  default = ""
}
variable "windows_super_bastion_instance_type" {
  description = "Instance type of the Windows super-bastion"
  default = ""
}

variable "super_bastion_public_key" {
  description = "Name of the file with the super-bastion public key, e.g. 'sb_win_super_bastion_rsa.pub'"
  default = ""
}

variable "sandbox_domain" {
  description = "Windows domain in sandbox environment (reflecting the 'fisdev.local' in SDL)"
  default = "sandbox.local"
}

/*** devops_tools variables ***/
variable "devops_tools_ami" {
  description = "AMI for the devops_tools linux instance"
  default = ""
}
variable "devops_tools_instance_type" {
  description = "Instance type of the devops_tools instance"
  default = ""
}

variable "devops_tools_public_key" {
  description = "Name of the file with the devops_tools public key, e.g. 'sb_devops_tools_rsa.pub'"
  default = ""
}

/*** harness_delegate variables ***/
variable "harness_delegate_ami" {
  description = "AMI for the harness_delegate linux instance"
  default = ""
}
variable "harness_delegate_instance_type" {
  description = "Instance type of the harness_delegate instance"
  default = ""
}
variable "harness_delegate_public_key" {
  description = "Name of the file with the harness_delegate public key, e.g. 'sb_harness_delegate_rsa.pub'"
  default = ""
}