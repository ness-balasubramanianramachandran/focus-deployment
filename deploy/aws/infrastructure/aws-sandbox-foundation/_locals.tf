locals {
  /*----------------------------------------------------------------*/
  //NAMING AND DEFAULT TAGS
  /*----------------------------------------------------------------*/

  name_prefix = join("-", [var.environment_type, var.org, var.application])

  default_tags = tomap({
    /* FIS default tags*/
    "BUC"             = var.buc
    "SupportGroup"    = var.support_group
    "AppGroupEmail"   = var.app_group_email
    "EnvironmentType" = var.environment_type
    "CustomerCRMID"   = var.customer_crmid
    /* ARP additional default tags*/
    "CreatedBy" = var.terraform_version
    "Zone"      = var.zone
  })

  /*----------------------------------------------------------------*/
  // RESOURCE SPECIFIC
  /*----------------------------------------------------------------*/
  
  # Removing tags to make Sandbox VPC identical to SDL VPC for testing
   
  #private_subnet_tags = tomap({ "kubernetes.io/role/internal-elb" = "1" })
  #public_subnet_tags  = tomap({ "kubernetes.io/role/elb" = "1" })
  private_subnet_tags = {}
  public_subnet_tags  = {}
  private_subnet_tags_routable = {}
  public_subnet_tags_routable = {}
  private_subnet_tags_egress = {}
  public_subnet_tags_egress = {}


  harness_userdata_params = {
    # ToDo: provide accountSecret as variable and update Harness-delegate scripts with the supplied value...
    #accountSecret: "26608f857377c69df04ef2f085fe894a"
  }
  harness_userdata_base64 = base64encode(
    templatefile("${path.module}/templates/userdata-harness-delegate.tpl", local.harness_userdata_params)
  )
}