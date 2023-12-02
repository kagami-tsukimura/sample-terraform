# Configure the AWS Provider
provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_vpc" "iac-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sample vpc"
  }
}

resource "aws_subnet" "iac-subnet" {
  vpc_id     = aws_vpc.iac-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "sample subnet"
  }
}

resource "aws_instance" "iac-instance" {
  ami           = "ami-035d55281a86f9439"
  instance_type = "t2.micro"

  tags = {
    Name = "sample ec2 instance"
  }
}
