locals {
  aws_region          = "ap-northeast-1"
  vpc_cidr            = "10.1.0.0/16"
  ipv4_full_open_cidr = "0.0.0.0/0"
  ipv6_full_open_cidr = "::/0"
  public_subnet_cidr  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  private_subnet_cidr = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
  ec2_ami             = "ami-07c589821f2b353aa"
  ec2_instance_type   = "t2.micro"
  eni_private_ip      = "10.1.1.50"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}
