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

