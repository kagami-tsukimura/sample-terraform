output "vpc_id" {
  value = aws_vpc.waf_vpc.id
}

output "route_table_id" {
  value = aws_route_table.route_table.id
}


output "igw" {
  value = aws_internet_gateway.waf_igw
}
