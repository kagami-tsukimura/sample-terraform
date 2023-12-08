resource "aws_vpc" "waf_vpc" {
  cidr_block = var.vpc_id

  tags = {
    Name = "waf-vpc"
  }
}
