# EIP
output "eip_public_ip" {
  value = aws_eip.iac-eip.public_ip
}

# Webサーバ
output "instance_private_ip" {
  value = aws_instance.iac-instance.private_ip
}

output "instance_id" {
  value = aws_instance.iac-instance.id
}
