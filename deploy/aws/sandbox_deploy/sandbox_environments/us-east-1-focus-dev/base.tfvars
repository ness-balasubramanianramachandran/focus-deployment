#---------------------------------------------------------#
# EKS CLUSTER CORE VARIABLES
#---------------------------------------------------------#
#Following fields used in tagging resources and building the name of the cluster
#---------------------------------------------------------#

/*** FIS default tags **/
buc               = "4012.523420.9820..0000.0000.3117"
support_group     = "Ambit Risk EMEA"
app_group_email   = "AmbitRisk.EMEA.Help@fisglobal.com"
environment_type  = "Dev"
customer_crmid    = "FIS 6015"
org               = "ambit"
application       = "focus"
zone              = "sandbox"
terraform_version = "Terraform v1.0.11"

/*** EC2 tags     ***/
expiration_date     = "Never"
solution_central_id = "15589"
sla                 = "99.5"
maintenance_window  = "[*/*/*/*/0]"
tier                = "System"
on_hours            = "Always"

#---------------------------------------------------------#
# VPC and PRIVATE SUBNET DETAILS for EKS Cluster
#---------------------------------------------------------#

create_vpc_endpoints = true

# !!!Environment specific!!! (sandbox vs sdl):

# Non-routable VPC
vpc_id             = "vpc-0bef7af200baf10d7"
private_subnet_ids = ["subnet-0d95247b0aaf48c6d", "subnet-07de57b747a5aec6f"]
//public_subnet_ids = []
route_table_ids = ["rtb-0df282ff8e39a0b8c"]

# Routable VPC
routable_vpc_id = "vpc-0cab117675dc6b926"
//routable_public_subnet_ids = []
routable_private_subnet_ids = ["subnet-0b556ded283aa5435", "subnet-09b68715b257e0f1a"]
routable_route_table_ids    = ["rtb-0574275cd68491d4a"]

peering_connection_id = "pcx-0c4dabf325a1daac0"

#---------------------------------------------------------#
# DNS
#---------------------------------------------------------#

fis_domain_name    = "sandbox.local"
fis_dns_server_ips = ["10.3.12.155"] //IP addresss of super-bastion (domain controller and dns server)

eks_domain = "svc.cluster.local"

#---------------------------------------------------------#
# BASTION
#---------------------------------------------------------#

bastion_rdp_cidrs             = ["10.3.0.0/18"]    //in Sandbox env the Egress VPC is playing the role of FIS connected network in SDL env
ad_cidrs                      = ["10.3.12.155/32"] // super-bastion in egress VPC (domain controller)
windows_bastion_ami           = "ami-019c495c29e709719"
windows_bastion_instance_type = "t3.medium"
bastion_public_key            = "sb_win_bastion_rsa.pub"

DC_HOST       = "super-bastion.sandbox.local"
DC_FULLOUPATH = "OU=AMBIT_FOCUS,OU=AWS_NorthVirginia,OU=AWS,DC=sandbox,DC=local"
DC_DOMAIN     = "SANDBOX.LOCAL"
USER          = "administrator"
PASSWORD      = "superbastion1234!"

#---------------------------------------------------------#

#---------------------------------------------------------#
# EKS CONTROL PLANE VARIABLES
# API server endpoint access options
#   Endpoint public access: true    - Your cluster API server is accessible from the internet. You can, optionally, limit the CIDR blocks that can access the public endpoint.
#   Endpoint private access: true   - Kubernetes API requests within your cluster's VPC (such as node to control plane communication) use the private VPC endpoint.
#---------------------------------------------------------#
create_eks                      = true
kubernetes_version              = "1.21"
cluster_endpoint_private_access = true
cluster_endpoint_public_access  = true

# Limit the source CIDRs for public endpoint:
cluster_endpoint_public_access_cidrs = [
  "0.0.0.0/0"
]

# RoleARN of devOps role 
devops_rolearn = "arn:aws:iam::575315357174:role/AWSReservedSSO_AdministratorAccess_843eaa222c566147"

# Enable IAM Roles for Service Accounts (IRSA) on the EKS cluster
enable_irsa = true

# Windows support (enable_windows_support = true) doesn't work if IAM resources are managed by the module,
# due to this issue: https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1456
# Whether to let the module manage worker IAM resources. If set to false, iam_instance_profile_name must be specified for workers."
manage_worker_iam_resources = false

# Create security group rules to allow communication between pods on workers and pods in managed node groups.
# Set this to true if you have AWS-Managed node groups and Self-Managed worker groups.
# See https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1089
worker_create_cluster_primary_security_group_rules = true


# EKS cluster logs
cluster_enabled_log_types    = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
cluster_log_retention_period = 7

# EKS managed addons (these are managed by AWS, other addons need to be deployed by helm charts)
enable_eks_addon_vpc_cni = true
eks_addon_vpc_cni_config = {
  addon_name               = "vpc-cni"
  addon_version            = "v1.10.1-eksbuild.1"
  service_account          = "aws-node"
  resolve_conflicts        = "OVERWRITE"
  namespace                = "kube-system"
  additional_iam_policies  = []
  service_account_role_arn = ""
  tags                     = {}
}

enable_eks_addon_coredns = true
# Optional config
eks_addon_coredns_config = {
  addon_name               = "coredns"
  addon_version            = "v1.8.4-eksbuild.1"
  service_account          = "coredns"
  resolve_conflicts        = "OVERWRITE"
  namespace                = "kube-system"
  service_account_role_arn = ""
  additional_iam_policies  = []
  tags                     = {}
}

enable_eks_addon_kube_proxy = true
eks_addon_kube_proxy_config = {
  addon_name               = "kube-proxy"
  addon_version            = "v1.21.2-eksbuild.2"
  service_account          = "kube-proxy"
  resolve_conflicts        = "OVERWRITE"
  namespace                = "kube-system"
  additional_iam_policies  = []
  service_account_role_arn = ""
  tags                     = {}
}

enable_eks_addon_aws_ebs_csi_driver = true
eks_addon_aws_ebs_csi_driver_config = {
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.4.0-eksbuild.preview"
  service_account          = "ebs-csi-controller-sa"
  resolve_conflicts        = "OVERWRITE"
  namespace                = "kube-system"
  additional_iam_policies  = []
  service_account_role_arn = ""
  tags                     = {}
}

#------------------------------------------------#

#---------------------------------------------------------#
# EKS WORKER NODE GROUPS
# Define Node groups as map of maps object as shown below. Each node group creates the following
#    1. New node group
#    2. IAM role and policies for Node group
#    3. Security Group for Node group (Optional)
#    4. Launch Templates for Node group   (Optional)
#---------------------------------------------------------#
managed_node_groups = {
  #---------------------------------------------------------#
  # ON-DEMAND Worker Group - Worker Group - 1
  #---------------------------------------------------------#
  mg_4 = {
    # 1> Node Group configuration - Part1
    node_group_name        = "managed-ondemand" # Max 40 characters for node group name
    create_launch_template = true               # false will use the default launch template
    launch_template_os     = "amazonlinux2eks"  # amazonlinux2eks or bottlerocket
    public_ip              = false              # Use this to enable public IP for EC2 instances; only for public subnets used in launch templates ;
    pre_userdata           = <<-EOT
            yum install -y amazon-ssm-agent
            systemctl enable amazon-ssm-agent && systemctl start amazon-ssm-agent"
        EOT
    # 2> Node Group scaling configuration
    desired_size    = 2
    max_size        = 2
    min_size        = 2
    max_unavailable = 1 # or percentage = 20

    # 3> Node Group compute configuration
    ami_type       = "AL2_x86_64"  # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
    capacity_type  = "ON_DEMAND"   # ON_DEMAND or SPOT
    instance_types = ["m4.xlarge"] # List of instances used only for SPOT type
    disk_size      = 50

    # 4> Node Group network configuration
    # Define your private/public subnets list with comma seprated subnet_ids  = ['subnet1','subnet2','subnet3']
    #subnet_ids  = ["subnet-02f59e0d36f885beb", "subnet-01e1e455bd491bd9c"] # private_subnet_ids used instead at module level: aws-eks-managed-node-groups and aws-eks-self-managed-node-groups

    k8s_taints = []

    k8s_labels = {
      Environment = "preprod"
      Zone        = "dev"
      WorkerType  = "ON_DEMAND"
    }
    additional_tags = {
      ExtraTag    = "m5x-on-demand"
      Name        = "m5x-on-demand"
      subnet_type = "private"
    }

    create_worker_security_group = false

  }
} # END OF MANAGED NODE GROUPS

#---------------------------------------------------------#
# EKS SELF MANAGED WORKER NODE GROUPS
#---------------------------------------------------------#

#enable_windows_support = true
#self_managed_node_groups = {
#  #---------------------------------------------------------#
#  # ON-DEMAND Self Managed Windows Worker Node Group
#  #---------------------------------------------------------#
#  windows_od = {
#    node_group_name        = "windows-ondemand"
#    create_launch_template = true
#    launch_template_os     = "windows" # amazonlinux2eks  or bottlerocket or windows
#
#    # custom_ami_id   = "ami-xxxxxxxxxxxxxxxx" # Bring your own custom AMI. Default Windows AMI is the latest EKS Optimized Windows Server 2019 English Core AMI.
#    public_ip = false # Enable only for public subnets
#
#    # Define your private/public subnets list with comma seprated subnet_ids  = ['subnet1','subnet2','subnet3']
#    # subnet_ids  = ["subnet-02f59e0d36f885beb", "subnet-01e1e455bd491bd9c"] # private_subnet_ids used instead at module level: aws-eks-managed-node-groups and aws-eks-self-managed-node-groups
#
#    disk_size     = 50
#    instance_type = "m5n.large"
#
#    desired_size    = 2
#    max_size        = 2
#    min_size        = 2
#    max_unavailable = 1 # or percentage = 20
#
#    k8s_labels = {
#      Environment = "preprod"
#      Zone        = "dev"
#      WorkerType  = "WINDOWS_ON_DEMAND"
#    }
#
#    additional_tags = {
#      ExtraTag = "windows-on-demand"
#      Name     = "windows-on-demand"
#
#    }
#
#    create_worker_security_group = false # Creates a dedicated sec group for this Node Group
#  }
#} # END OF SELF MANAGED NODE GROUPS


#-------EKS ADDONS----------------------

#---------------------------------------
# ENABLE EXTERNAL-DNS
#---------------------------------------

external_dns_controller_enable = true
# Optional ExternalDNS helm chart
external_dns_helm_chart = {
  name       = "external-dns"
  chart      = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  version    = "1.9.0"
  namespace  = "kube-system"
  #values     = [templatefile("${path.module}/k8s_addons/external-dns-values.yaml", {})]
}
#---------------------------------------
# TRAEFIK INGRESS CONTROLLER HELM ADDON
#---------------------------------------
#  traefik_ingress_controller_enable = false
#
#  # Optional Map value
#  traefik_helm_chart = {
#    name       = "traefik"                         # (Required) Release name.
#    repository = "https://helm.traefik.io/traefik" # (Optional) Repository URL where to locate the requested chart.
#    chart      = "traefik"                         # (Required) Chart name to be installed.
#    version    = "10.0.0"                          # (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed.
#    namespace  = "kube-system"                     # (Optional) The namespace to install the release into. Defaults to default
#    timeout    = "1200"                            # (Optional)
#    lint       = "true"                            # (Optional)
#    # (Optional) Example to show how to override values using SET
#    set = [{
#      name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
#      value = "nlb"
#    }]
#    # (Optional) Example to show how to pass metrics-server-values.yaml
#    values = [templatefile("${path.module}/k8s_addons/traefik-values.yaml", {
#      operating_system = "linux"
#    })]
#  }
#
#  #---------------------------------------
#  # METRICS SERVER HELM ADDON
#  #---------------------------------------
#  metrics_server_enable = false
#
#  # Optional Map value
#  metrics_server_helm_chart = {
#    name       = "metrics-server"                                    # (Required) Release name.
#    repository = "https://kubernetes-sigs.github.io/metrics-server/" # (Optional) Repository URL where to locate the requested chart.
#    chart      = "metrics-server"                                    # (Required) Chart name to be installed.
#    version    = "3.5.0"                                             # (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed.
#    namespace  = "kube-system"                                       # (Optional) The namespace to install the release into. Defaults to default
#    timeout    = "1200"                                              # (Optional)
#    lint       = "true"                                              # (Optional)
#
#    # (Optional) Example to show how to pass metrics-server-values.yaml
#    values = [templatefile("${path.module}/k8s_addons/metrics-server-values.yaml", {
#      operating_system = "linux"
#    })]
#  }
#
#  #---------------------------------------
#  # CLUSTER AUTOSCALER HELM ADDON
#  #---------------------------------------
#  cluster_autoscaler_enable = false
#
#  # Optional Map value
#  cluster_autoscaler_helm_chart = {
#    name       = "cluster-autoscaler"                      # (Required) Release name.
#    repository = "https://kubernetes.github.io/autoscaler" # (Optional) Repository URL where to locate the requested chart.
#    chart      = "cluster-autoscaler"                      # (Required) Chart name to be installed.
#    version    = "9.10.7"                                  # (Optional) Specify the exact chart version to install. If this is not specified, the latest version is installed.
#    namespace  = "kube-system"                             # (Optional) The namespace to install the release into. Defaults to default
#    timeout    = "1200"                                    # (Optional)
#    lint       = "true"                                    # (Optional)
#
#    # (Optional) Example to show how to pass metrics-server-values.yaml
#    values = [templatefile("${path.module}/k8s_addons/cluster-autoscaler-vaues.yaml", {
#      operating_system = "linux"
#    })]
#  }
#
#  #---------------------------------------
#  # ENABLE NGINX
#  #---------------------------------------
#
#  nginx_ingress_controller_enable = false
#  # Optional nginx_helm_chart
#  nginx_helm_chart = {
#    name       = "ingress-nginx"
#    chart      = "ingress-nginx"
#    repository = "https://kubernetes.github.io/ingress-nginx"
#    version    = "3.33.0"
#    namespace  = "kube-system"
#    values     = [templatefile("${path.module}/k8s_addons/nginx-values.yaml", {})]
#  }
#
