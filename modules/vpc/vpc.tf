resource "aws_vpc" "waf_vpc" {
  cidr_block = var.vpc_id

  tags = {
    Name = "waf-vpc"
  }
}

# Route table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.waf_vpc.id
  route {
    cidr_block = var.ipv4_full_open_cidr
    gateway_id = aws_internet_gateway.waf_igw.id
  }
  route {
    ipv6_cidr_block = var.ipv6_full_open_cidr
    gateway_id      = aws_internet_gateway.waf_igw.id
  }
  tags = {
    Name = "route-table"
  }
}

resource "aws_internet_gateway" "waf_igw" {
  vpc_id = aws_vpc.waf_vpc.id

  tags = {
    Name = "waf-igw"
  }
}
