resource "aws_security_group" "alb" {
  name        = "from-alb-sg"
  description = "from alb"
  vpc_id      = var.vpc_id

  ingress {
    description = "Request From HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.ipv4_full_open_cidr]
  }

  ingress {
    description = "Request From HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.ipv4_full_open_cidr]
  }

  ingress {
    description = "Request From SSH"
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
    Name = "from-alb-sg"
  }
}
