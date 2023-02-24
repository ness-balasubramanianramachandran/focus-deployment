terraform {
  backend "s3" {
    bucket = "terraform-state-useast1-bucket"
    region = "us-east-1"
    key    = "sandbox/us-east-1/focus/dev/vpc/terraform-main.tfstate"
  }
}
