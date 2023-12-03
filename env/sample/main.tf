# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  # echo 'export TF_VAR_aws_access_key=YOUR_ACCESS_KEY' >> ~/.bashrc
  access_key = var.aws_access_key
  # echo 'export TF_VAR_aws_secret_key=YOUR_SECRET_KEY' >> ~/.bashrc
  secret_key = var.aws_secret_key
}

# VPC
resource "aws_vpc" "iac-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "iac-vpc"
  }
}

# IGW
resource "aws_internet_gateway" "iac-igw" {
  vpc_id = aws_vpc.iac-vpc.id
  tags = {
    Name = "iac-igw"
  }
}

# Route table
resource "aws_route_table" "iac-route-table" {
  vpc_id = aws_vpc.iac-vpc.id
  route {
    cidr_block = var.ipv4_full_open_cidr
    gateway_id = aws_internet_gateway.iac-igw.id
  }
  route {
    ipv6_cidr_block = var.ipv6_full_open_cidr
    gateway_id      = aws_internet_gateway.iac-igw.id
  }
  tags = {
    Name = "iac-route-table"
  }
}

# Subnet
resource "aws_subnet" "iac-subnet1" {
  vpc_id            = aws_vpc.iac-vpc.id
  cidr_block        = var.subnet_cidr[0]
  availability_zone = var.subnet_az[0]
  tags = {
    Name = "iac-subnet1"
  }
}

resource "aws_subnet" "iac-subnet2" {
  vpc_id            = aws_vpc.iac-vpc.id
  cidr_block        = var.subnet_cidr[1]
  availability_zone = var.subnet_az[1]
  tags = {
    Name = "iac-subnet2"
  }
}

# Subnet to Route table
resource "aws_route_table_association" "iac-association" {
  subnet_id      = aws_subnet.iac-subnet1.id
  route_table_id = aws_route_table.iac-route-table.id
}

# SG
resource "aws_security_group" "iac-security-group" {
  name        = "iac-security-group"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.iac-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.ipv4_full_open_cidr]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.ipv4_full_open_cidr]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ipv4_full_open_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ipv4_full_open_cidr]
  }
  tags = {
    Name = "iac-security-group"
  }
}

# ENI
resource "aws_network_interface" "iac-eni" {
  subnet_id       = aws_subnet.iac-subnet1.id
  private_ips     = [var.eni_private_ip]
  security_groups = [aws_security_group.iac-security-group.id]
}

# EIP
resource "aws_eip" "iac-eip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.iac-eni.id
  associate_with_private_ip = var.eni_private_ip
  depends_on                = [aws_internet_gateway.iac-igw, aws_instance.iac-instance]
}

# EC2
resource "aws_instance" "iac-instance" {
  ami               = var.ec2_ami
  instance_type     = var.ec2_instance_type
  availability_zone = var.subnet_az[0]
  key_name          = "iac-key"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.iac-eni.id
  }

  # installing apache
  user_data = <<-EOF
              #!/bin/bash
              sudo yum -y install httpd
              sudo systemctl start httpd.service
              sudo bash -c 'echo Bearded penguins sleep 10,000 times a day! > /var/www/html/index.html'
              sudo bash -c 'echo https://www.science.org/doi/10.1126/science.adh0771 >> /var/www/html/index.html'
              EOF
  tags = {
    Name = "iac-instance"
  }
}
