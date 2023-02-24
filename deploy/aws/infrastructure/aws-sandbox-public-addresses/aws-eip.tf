resource "aws_eip" "windows-bastion-eip" {
    tags = merge(local.default_tags, {"Name" = "windows-bastion-eip"})
}

resource "aws_eip" "linux-bastion-eip" {
    tags = merge(local.default_tags, {"Name" = "linux-bastion-eip"})
}