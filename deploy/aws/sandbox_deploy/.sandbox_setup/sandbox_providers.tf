/**
 * File provided as part of base bitbucket scaffolding
 * this file should contain provider information.
 * DO NOT include authorization keys
 */

provider "aws" {}

provider "kubernetes" {
  experiments {
    manifest_resource = true
  }
  host                   = var.create_eks ? data.aws_eks_cluster.cluster.0.endpoint : ""
  cluster_ca_certificate = var.create_eks ? base64decode(data.aws_eks_cluster.cluster.0.certificate_authority.0.data) : ""
  token                  = var.create_eks ? data.aws_eks_cluster_auth.cluster.0.token : ""
}

provider "helm" {
  kubernetes {
    host                   = var.create_eks ? data.aws_eks_cluster.cluster.0.endpoint : ""
    token                  = var.create_eks ? data.aws_eks_cluster_auth.cluster.0.token : ""
    cluster_ca_certificate = var.create_eks ? base64decode(data.aws_eks_cluster.cluster.0.certificate_authority.0.data) : ""
  }
}
