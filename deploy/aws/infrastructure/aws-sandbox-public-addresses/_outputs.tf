output "windows-bastion-eip" {
  description = "Static IP address of windows bastion"
  value       = aws_eip.windows-bastion-eip.public_ip
}

output "linux-bastion-eip" {
  description = "Static IP address of linux bastion"
  value       = aws_eip.linux-bastion-eip.public_ip
}

output "windows-bastion-eip-id" {
  description = "ID of static IP address of windows bastion"
  value       = aws_eip.windows-bastion-eip.id
}

output "linux-bastion-eip-id" {
  description = "ID of static IP address of linux bastion"
  value       = aws_eip.linux-bastion-eip.id
}