# Core infrastructure in AWS sandbox account

## Introduction

AWS sandbox account is available for us to use almost without any restrictions (we have access to the account admin role). This comes with the price of complete isolation from any FIS tools or services (Bit Bucket, TFE, AD etc.).

To gain as much as possible from this AWS account our intention is to use it not only as technology playground, but also as a space where we can execute the same TF configuration used in SDL or production environments. This makes our infrastructure code development consistent accross different environments since we are using a single TF configuration (single BB repo) with environment specific parameters. This way we can improve our TF code by experimenting and troubleshooting in the Sandbox, while all the progress would still be reflected in SDL and production environments as well.

For this to work, we need to establish a core infrastructure in the Sandbox (networking, domain controller, windows domain etc.) to make the foundation layer similar to the one we have in SDL. Only then we are able to use a single TF configuration to build identical application infrastructure in Sandbox and in SDL.

This distinction between "core infrastructure" and "application infrastructure" is not so much based in technology as it is in FIS organization structure and ownership of different infrastructure elements. 

Core infrastructure elements are:
* basic cloud networking: one non-routable VPC peered with one routable VPC; private subnets; DHCP option set for routable VPC with FIS DNS and fisdev.local domain; transit gateway for connection with FIS network; route tables
* IAM & SSO: Identity provider (SAML); SSO; AWS Role for SSO users; AWS Role for TFE;
* FIS tools and services: BitBucket, TFE, Windows Domain Controller (AD/DNS), Vault, Jenkins, Ansible...

Application infrastructure elements are:
* BSM desktop instance
* Elastic Kubernetes Service (EKS) cluster
* EKS application deployment (pods, services etc.)
* RDS SQL instance and databases
* all IAM and security objects not part of core infra: EKS service accounts, instance roles, security groups etc.

In SDL zone Core Infrastructure is owned and maintained by FIS CLoud services.

In Sandbox zone Core Infrastructure is owned and maintained by Ambit Risk and Performance (ARP) team.

Application Infrastructure is owned and maintained by ARP in both zones: SDL and Sandbox. It is automated with single TF configuration kept in corporate BB.







The TF configuration for the sandbox core infrastructure is kept in this repository.



