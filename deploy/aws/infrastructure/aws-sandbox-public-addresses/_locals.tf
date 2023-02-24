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


}
