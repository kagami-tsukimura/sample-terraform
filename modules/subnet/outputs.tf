output "public_subnet_ids" {
  value = [aws_subnet.public_1a.id, aws_subnet.public_1c.id, aws_subnet.public_1d.id]
}
