provider "aws" {
  region = data.aws_region.current.id
  alias  = "default"
}