/*** tags **/

buc               = "4012.523420.9820..0000.0000.3117"
support_group     = "Ambit Risk EMEA"
app_group_email   = "AmbitRisk.EMEA.Help@fisglobal.com"
environment_type  = "dev"
customer_crmid    = "FIS 6015"
org               = "ambit"
application       = "focus"
zone              = "sandbox"
terraform_version = "Terraform v1.0.7"

/*** Non-routable VPC ***/

create_vpc = true

enable_public_subnets  = false
enable_private_subnets = true

enable_nat_gateway = false


create_igw = false

vpc_cidr             = "10.1.0.0/18"
private_subnets_cidr = ["10.1.0.0/22", "10.1.4.0/22"]
public_subnets_cidr  = []

/*** Routable VPC ***/

create_vpc_routable = true

enable_public_subnets_routable  = false
enable_private_subnets_routable = true

enable_nat_gateway_routable = false

create_igw_routable = false

vpc_cidr_routable             = "10.2.0.0/18"
private_subnets_cidr_routable = ["10.2.0.0/22", "10.2.4.0/22"]
public_subnets_cidr_routable  = []

/*** Egress VPC ***/

create_vpc_egress = true

enable_public_subnets_egress  = true
enable_private_subnets_egress = true

enable_nat_gateway_egress = true

create_igw_egress = true

vpc_cidr_egress             = "10.3.0.0/18"
private_subnets_cidr_egress = ["10.3.0.0/22", "10.3.4.0/22"]
public_subnets_cidr_egress  = ["10.3.12.0/22", "10.3.16.0/22"]


// CIDR blocks that are allowed to login to super-bastion and devops_tools instances in Egress VPC
inbound_cidrs = [
  // You can't RDP to Sandbox bastions from FIS VPN (it is forbiden).
  // If you have issues finding the right CIDR to allow, temporarily set full access (0.0.0.0/0) and check the source address of your client
  // in windows logs of the bastion host: C:\Windows\System32\winevt\Logs\Microsoft-Windows-TerminalServices-RemoteConnectionManager%4Operational
  // Look for the event with title: "Remote Desktop Services: User authentication succeeded"
  //"0.0.0.0/0",
  "87.116.128.0/18",  //SBB Serbia
  "213.253.119.0/24", //FIS BG
  "178.222.6.0/23",   //MTS Serbia
  "79.101.0.0/16",    //MTS Serbia
  "178.223.0.0/16",   //MTS Serbia
  "109.245.0.0/16",   //Yetel
  "31.223.0.0/16",    //MTL RS 
  "208.127.0.0/16",   //Global Protect
  "130.41.0.0/16",
  "134.238.0.0/16",
  "137.83.192.0/18",
  "139.180.248.0/24",
  "165.1.128.0/17",
  "66.159.192.0/19",
  "13.32.0.0/16",
  "34.96.0.0/16"
]

/*** super-bastion - windows that we are able to RDP into and which hosts a domain controller***/
windows_super_bastion_ami           = "ami-041a8c1bc9e7f4545" //custom AMI with Domain Controller and 'sandbox.local' domain
windows_super_bastion_instance_type = "t3.medium"
super_bastion_public_key            = "sb_win_super_bastion_rsa.pub"

sandbox_domain = "sandbox.local"

/*** devops_tools - Linux with Ansible, Packer, Vault...***/
devops_tools_ami           = "ami-04505e74c0741db8d" //custom AMI: Ubuntu Server 20.04 LTS with Ansible, Packer, Vault and Jenkins
devops_tools_instance_type = "t3.large"
devops_tools_public_key    = "sb_devops_tools_rsa.pub"

/*** harness_delegate ***/
harness_delegate_ami           = "ami-021f290be33dcd058" //arp-harness-delegate-v1 custom AMI (harness delegate shell scripts in /var/tmp/harness_delegate, TF and Ansible)
harness_delegate_instance_type = "t3.large"
harness_delegate_public_key    = "sb_harness_delegate_rsa.pub"
