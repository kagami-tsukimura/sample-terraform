# EIP
output "eip_public_ip" {
  value = aws_eip.iac-eip.public_ip
}
