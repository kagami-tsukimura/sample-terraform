# Configure the AWS Provider
provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# VPC
resource "aws_vpc" "iac-vpc" {
  cidr_block = "10.0.0.0/16"
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
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.iac-igw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.iac-igw.id
  }
  tags = {
    Name = "iac-route-table"
  }
}

# Subnet
resource "aws_subnet" "iac-subnet" {
  vpc_id            = aws_vpc.iac-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "iac-subnet"
  }
}

# Subnet to Route table
resource "aws_route_table_association" "iac-association" {
  subnet_id      = aws_subnet.iac-subnet.id
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
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "iac-security-group"
  }
}

# ENI
resource "aws_network_interface" "iac-eni" {
  subnet_id       = aws_subnet.iac-subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.iac-security-group.id]
}

# EIP
resource "aws_eip" "iac-eip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.iac-eni.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.iac-igw, aws_instance.iac-instance]
}

# Webサーバ
resource "aws_instance" "iac-instance" {
  ami               = "ami-035d55281a86f9439"
  instance_type     = "t2.micro"
  availability_zone = "ap-northeast-1a"
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
