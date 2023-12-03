# Provider
output "aws_region" {
  value = var.aws_region
}

output "access_key" {
  value = var.aws_access_key
}

output "secret_key" {
  value = var.aws_secret_key
}

output "ipv4_full_open_cidr" {
  value = var.ipv4_full_open_cidr
}

output "ipv6_full_open_cidr" {
  value = var.ipv6_full_open_cidr
}

# VPC
output "vpc_cidr" {
  value = var.vpc_cidr
}

# Subnet
output "subnet_cidr" {
  value = var.subnet_cidr
}

output "subnet_az" {
  value = var.subnet_az
}

output "eni_private_ip" {
  value = var.eni_private_ip
}

# EIP
output "eip_public_ip" {
  value = aws_eip.iac-eip.public_ip
}

# EC2
output "ec2_instance_type" {
  value = var.ec2_instance_type
}

output "instance_private_ip" {
  value = aws_instance.iac-instance.private_ip
}

output "instance_id" {
  value = aws_instance.iac-instance.id
}
