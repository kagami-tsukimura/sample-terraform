locals {
  aws_region          = "ap-northeast-1"
  vpc_cidr            = "10.0.0.0/16"
  ipv4_full_open_cidr = "0.0.0.0/0"
  ipv6_full_open_cidr = "::/0"
  public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidr = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}
