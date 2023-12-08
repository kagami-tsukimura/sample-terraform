resource "aws_vpc" "waf_vpc" {
  cidr_block = var.vpc_id

  tags = {
    Name = "waf-vpc"
  }
}

resource "aws_internet_gateway" "waf_igw" {
  vpc_id = aws_vpc.waf_vpc.id

  tags = {
    Name = "waf-igw"
  }
}
