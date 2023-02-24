data "aws_region" "current" {}
data "aws_partition" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_instances" "super-bastion" {
  filter {
    name   = "instance-id"
    values = [aws_instance.windows_super_bastion.id]
  }
}

data "terraform_remote_state" "bastion_static_ips" {
  backend = "s3"

  config = {
    bucket = "terraform-state-useast1-bucket"
    region = "us-east-1"
    key    = "sandbox/us-east-1/focus/dev/public_addresses/terraform-main.tfstate"
  }
}
