locals {
  aws_region          = "ap-northeast-1"
  vpc_cidr            = "10.0.0.0/16"
  ipv4_full_open_cidr = "0.0.0.0/0"
  ipv6_full_open_cidr = "::/0"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}
