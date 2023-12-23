output "vpc_id" {
  value = aws_vpc.waf_vpc.id
}

output "igw" {
  value = aws_internet_gateway.waf_igw
}
