# ENI
resource "aws_network_interface" "ec2-eni" {
  subnet_id       = var.public_subnet_ids[0]
  private_ips     = [var.eni_private_ip]
  security_groups = [var.sg_id]
}

# EIP
resource "aws_eip" "ec2-eip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.ec2-eni.id
  associate_with_private_ip = var.eni_private_ip
  depends_on                = [var.igw, aws_instance.ec2]
}

# EC2
resource "aws_instance" "ec2" {
  ami               = var.ec2_ami
  instance_type     = var.ec2_instance_type
  availability_zone = "${var.region}a"
  key_name          = "iac-key"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.ec2-eni.id
  }

  #   # installing nginx
  user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install nginx
                sudo bash -c 'echo "<h1>Bearded penguins sleep 10,000 times a day!</h1>" > /var/www/html/index.nginx-debian.html'
                sudo bash -c 'echo "<a href='https://gigazine.net/news/20231201-penguins-hours-seconds-long-micronaps/'>Link to GIGAZINE</a>" >> /var/www/html/index.nginx-debian.html'
                EOF
  tags = {
    Name = "ec2-${var.ec2_instance_type}"
  }
}
